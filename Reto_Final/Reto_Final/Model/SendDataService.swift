//
//  SendDataService.swift
//  Reto_Final
//
//  Created by JML on 3/01/23.
//

import SwiftUI

class SendDataService: ObservableObject {
    
    // Singleton
    static let shared = SendDataService()
    
    @Published var working: Bool?
    @Published var failed: Bool = false
    @Published var success: Bool = false
    @Published var result: PutModel?
    
    var typeId: String = ""
    var idNumber: String = ""
    var name: String = ""
    var lastname: String = ""
    var city: String = ""
    var email: String = ""
    var doctype: String = ""
    var encodedDoc: String = ""
    
    init() { }
    
    func postData(completion: @escaping(Bool) -> Void) {
        
        let url = URL(string: "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Documentos")
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newDocument = PostDocumentModel(TipoId: self.typeId, Identificacion: self.idNumber, Nombre: self.name, Apellido: self.lastname, Ciudad: self.city, Correo: self.email, TipoAdjunto: self.doctype, Adjunto: self.encodedDoc)
        
        do{
            let jsonData = try JSONEncoder().encode(newDocument)
            request.httpBody = jsonData
            print(request)
            //print(newDocument)
        } catch let jsonError{
            print(jsonError)
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            
            if let response = response as? HTTPURLResponse {
                // Read all HTTP Response Headers
                print("All headers: \(response.allHeaderFields)")
                // Read a specific HTTP Response Header by name
                print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
                
                print("Response code (initial): \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let jsonData = data, let dataString = String(data: jsonData, encoding: .utf8) {
                print("Response data string:\n\(dataString)")
            }
            
            if error != nil {
                self?.working = false
                self?.failed = true
                self?.success = false
                
                print("An error has ocurred while connecting. \(String(describing: error))")
                
                completion(false)
                
            } else if let jsonData = data{
                
                /*do {
                    
                    let sentResponse = try JSONDecoder().decode(DocumentModel.self, from: jsonData)*/
                    
                    self?.working = false
                    self?.failed = false
                    self?.success = true
                    
                    //Parse JSON Result Response
                    self?.result = self?.parseJSONResult(jsonData, completion: { [ weak self ] success in
                        self?.result = (success != nil) ? self?.result : PutModel(put: false)
                    })
                    
                    print("Response code: \((response as! HTTPURLResponse).statusCode)")
                    
                    completion(true)
                    
                /*} catch let jsonError{
                    
                    self?.working = false
                    self?.failed = true
                    self?.success = false
                    
                    print("Error, unable to decode response:\n\(jsonError)")
                    
                    completion(false)
                }*/
            }
        })
        task.resume()
    }
    
    func parseJSONResult(_ jsonData: Data, completion: @escaping(PutModel?) -> Void) -> PutModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(PutModel.self, from: jsonData)
            
            let put = decodedData.put
            
            let parsedResult = PutModel(put: put)
            self.result = parsedResult
            
            print("Parsed result test: \(String(describing: parsedResult.put))")
            completion(parsedResult)
            return parsedResult
            
        } catch let jsonError{
            print("Error, unable to decode response:\n\(jsonError)")
            completion(nil)
            return nil
        }
    }
    
    
    func encodeImgBase64(image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 0)
        //let imageData = UIImageJPEGRepresentation(image, 0.1)
        let base64String = imageData?.base64EncodedString()
        print(base64String ?? "")
        return base64String!
    }
}
