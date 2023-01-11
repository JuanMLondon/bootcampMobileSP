//
//  GetDataService.swift
//  Reto_Final
//
//  Created by JML on 5/01/23.
//

import Foundation

class GetDataService: ObservableObject {
    
    // Singleton
    static let shared = GetDataService()
    
    @Published var working: Bool?
    @Published var failed: Bool = false
    @Published var success: Bool = false
    @Published var documentData = [GetDocumentModel]()
    @Published var retrievedAttachment: String?
    
    var docID: String?
    var email: String?
    
    init() { }
    
    func fetchData(completion: @escaping(Bool) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Documentos?idRegistro=\(self.docID!)&correo=\(self.email!)")!)
        print("Request URL: \(request)")
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            
            if let response = response as? HTTPURLResponse {
 
                print("All headers: \(response.allHeaderFields)")
                print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
                print("Response code: \(response.statusCode)")
            }
            
            if error != nil {
                
                self?.working = false
                self?.failed = true
                self?.success = false
                
                print("An error has ocurred while connecting. \(String(describing: error))")
                
                completion(false)
                
            } else if let jsonData = data {
                
                DispatchQueue.main.async {
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        let getDataResponse = try decoder.decode(GetDocumentData.self, from: jsonData)

                        self?.working = false
                        self?.failed = false
                        self?.success = true
                        
                        self?.documentData = getDataResponse.Items
                        
                        //print("GetData test: \(self?.documentData[0].Adjunto! ?? "")")
                        self?.retrievedAttachment = self?.documentData[0].Adjunto! ?? ""
                        
                        completion(true)
                        
                    } catch let jsonError{
                        
                        self?.working = false
                        self?.failed = true
                        self?.success = false
                        
                        print("Error, unable to decode response:\n\(jsonError)")
                        
                        completion(false)
                    }
                }
            }
        })
        task.resume()
    }
}
