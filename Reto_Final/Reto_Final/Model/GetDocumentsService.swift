//
//  GetDocumentsService.swift
//  Reto_Final
//
//  Created by JML on 4/01/23.
//

import Foundation

class GetDocumentsService: ObservableObject {
    
    // Singleton
    static let shared = GetDocumentsService()
    
    @Published var working: Bool?
    @Published var failed: Bool = false
    @Published var success: Bool = false
    @Published var documentsList = [DocumentModel]()
    
    var email: String?
    
    init() { }
    
    func fetchData(completion: @escaping(Bool) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Documentos?correo=\(self.email!)")!)
        
        print(request)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            
            if let response = response as? HTTPURLResponse {
                print("All headers: \(response.allHeaderFields)")
                print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
                print("Response code: \(response.statusCode)")
            }
            
            /*if let jsonData = data, let dataString = String(data: jsonData, encoding: .utf8) {
                print("Response data as string:\n\(dataString)")
            }*/
            
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
                        
                        let fetchResponse = try decoder.decode(DocumentsData.self, from: jsonData)

                        self?.working = false
                        self?.failed = false
                        self?.success = true
                        
                        self?.documentsList = fetchResponse.Items
                        
                        /*print("Decoder test: \(self!.documentsList[0].formattedDate)")
                        print("Decoder test (Iterator):")
                        self!.documentsList.forEach{print($0.IdRegistro!, $0.Fecha!, $0.TipoAdjunto!)}
                        print("Response code: \((response as! HTTPURLResponse).statusCode)")
                        print("Response: \(fetchResponse)")*/
                        
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
