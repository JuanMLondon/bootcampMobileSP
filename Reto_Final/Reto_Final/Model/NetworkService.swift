//
//  NetworkManager.swift
//  Reto_Final
//
//  Created by JML on 19/12/22.
//

import Foundation

class NetworkService: ObservableObject {
    
    static let shared = NetworkService()
    
    @Published var working: Bool?
    @Published var failed: Bool = false
    @Published var success: Bool = false
    @Published var loggedInUser: UserModel?
    
    init() { }
    
    func login(email: String, password: String, completion: @escaping(Bool) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Usuarios?idUsuario=\(email)&clave=\(password)") ?? URL(string: "https://www.google.com")!)
        
        print(request)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in

                if error != nil {
                    self?.working = false
                    self?.failed = true
                    self?.success = false
                    
                    completion(false)
                    
                } else if let safeData = data {
                    DispatchQueue.main.async {
                        do {
                            
                            let loginResponse = try JSONDecoder().decode(UserData.self, from: safeData)
                            
                            self?.working = false
                            self?.failed = false
                            self?.success = true
                            
                            self?.loggedInUser = self?.parseUsersJSON(safeData, completion: { [ weak self ] success in
                                self!.loggedInUser = (success != nil) ? self?.loggedInUser : UserModel(id: "", nombre: "", apellido: "", acceso: false, admin: false)
                            })
                            
                            print("User name test (from networkService.login): \(String(describing: self!.loggedInUser!.nombre))")
                            print("Response ok: \((response as! HTTPURLResponse).statusCode)")
                            print(loginResponse)
                            
                            completion(true)
                            
                        } catch {
                            
                            self?.working = false
                            self?.failed = true
                            self?.success = false
                            
                            print("Response catch: \((response as! HTTPURLResponse).statusCode)")
                            print("Unable to decode response \(error)")
                            
                            completion(false)
                        }
                    }
                }
        })
        task.resume()
    }
    
    func parseUsersJSON(_ userData: Data, completion: @escaping(UserModel?) -> Void) -> UserModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(UserData.self, from: userData)
            
            let id = decodedData.id
            let nombre = decodedData.nombre
            let apellido = decodedData.apellido
            let acceso = decodedData.acceso
            let admin = decodedData.admin
            
            let parsedUser = UserModel(id: id, nombre: nombre, apellido: apellido, acceso: acceso, admin: admin)
            
            self.loggedInUser = parsedUser
            
            print("Parsed user name test: \(parsedUser.nombre)")
            completion(parsedUser)
            return parsedUser
            
        } catch {
            completion(nil)
            return nil
        }
    }
    
    func getLoggedInUser() -> UserModel {
        return loggedInUser ?? UserModel(id: "", nombre: "Usuario", apellido: "", acceso: false, admin: false)
    }
}
