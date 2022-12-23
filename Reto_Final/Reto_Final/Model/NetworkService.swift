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
    @Published var user: UserModel? = nil
    
    func login(email: String, password: String/*, completion: @escaping (Bool) -> ()*/) {
        
        var request = URLRequest(url: URL(string: "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Usuarios?idUsuario=\(email)&clave=\(password)") ?? URL(string: "https://www.google.com")!)
        
        print(request)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            //DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                if error != nil {
                    self?.working = false
                    self?.failed = true
                    self?.success = false
                    
                    print("Failed? \(self!.failed) from NetworService \"Error\"")
                    
                } else if let safeData = data {
                    do {
                        
                        let loginResponse = try JSONDecoder().decode(UserData.self, from: safeData)
                        
                        self?.working = false
                        self?.failed = false
                        self?.success = true
                        
                        self?.fetchData(safeData: safeData)
                        
                        print("Success? \(self!.success) from NetworService \"Do\"")
                        
                        print("Response ok: \((response as! HTTPURLResponse).statusCode)")
                        print(loginResponse)
                        
                        
                    } catch {
                        
                        self?.working = false
                        self?.failed = true
                        self?.success = false
                        
                        print("Failed? \(self!.failed) from NetworService \"Catch\"")
                        
                        print("Response catch: \((response as! HTTPURLResponse).statusCode)")
                        print("Unable to decode response \(error)")
                    }
                }
                self?.working = false
            }
        })
        task.resume()
    //completion()
    }
    
    func fetchData(safeData: Data) {
        //Calling JSON Parser
        if let user = self.parseJSON(safeData) {
            DispatchQueue.main.async {
                self.user = user
                print("Parser test \"nombre\" :\(user.nombre)")
            }
        }
    }
    
    func parseJSON(_ userData: Data) -> UserModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(UserData.self, from: userData)
            
            let id = decodedData.id
            let nombre = decodedData.nombre
            let apellido = decodedData.apellido
            let acceso = decodedData.acceso
            let admin = decodedData.admin
            
            let user = UserModel(id: id, nombre: nombre, apellido: apellido, acceso: acceso, admin: admin)
            
            return user
            
        } catch {
            return nil
        }
    }
}

