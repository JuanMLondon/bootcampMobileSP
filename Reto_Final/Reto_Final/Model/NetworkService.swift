//
//  NetworkManager.swift
//  Reto_Final
//
//  Created by JML on 19/12/22.
//

import Foundation

class NetworkService: ObservableObject {
    
    @Published var working: Bool = false
    @Published var failed: Bool = false
    @Published var success: Bool = false
    
    func login(email: String, password: String) {
        
        self.working = true
        
        var request = URLRequest(url: URL(string: "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Usuarios?idUsuario=\(email)&clave=\(password)") ?? URL(string: "https://www.google.com")!)
        
        print(request)
        
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if error != nil {
                self.working = false
                self.failed = true
                self.success = false
                
                print("Working? \(self.working) from NetworService \"Error\"")
                print("Failed? \(self.failed) from NetworService \"Error\"")
                print("Success? \(self.success) from NetworService \"Error\"")
                
            } else if let safeData = data {
                do {
                    let loginResponse = try JSONDecoder().decode(UserData.self, from: safeData)
                    
                    DispatchQueue.main.async {
                        self.working = false
                        self.failed = false
                        self.success = true
                        
                        print("Working? \(self.working) from NetworService \"Do\"")
                        print("Failed? \(self.failed) from NetworService \"Do\"")
                        print("Success? \(self.success) from NetworService \"Do\"")
                        
                        print("Response ok: \((response as! HTTPURLResponse).statusCode)")
                        print(loginResponse)
                    }
                    
                } catch {
                    self.working = false
                    self.failed = true
                    self.success = false
                    
                    print("Working? \(self.working) from NetworService \"Catch\"")
                    print("Failed? \(self.failed) from NetworService \"Catch\"")
                    print("Success? \(self.success) from NetworService \"Catch\"")
                    
                    print("Response catch: \((response as! HTTPURLResponse).statusCode)")
                    print("Unable to decode response \(error)")
                }
                //self.working = false
            }
        })
        task.resume()
    }
}
