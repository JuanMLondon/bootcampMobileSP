//
//  NetworkManager.swift
//  Reto_Final
//
//  Created by JML on 19/12/22.
//

import Foundation

class NetworkService {
    
    static let shared: NetworkService = NetworkService()
    
    var working: Bool = false
    var failed: Bool = false
    var success: Bool = false
    var loggedInUser: UserModel?
    
    func login(email: String, password: String/*, completion: @escaping (Bool) -> ()*/) {
        
        var request = URLRequest(url: URL(string: "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Usuarios?idUsuario=\(email)&clave=\(password)") ?? URL(string: "https://www.google.com")!)
        
        print(request)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //DispatchQueue.main.async {
                if error != nil {
                    self?.working = false
                    self?.failed = true
                    self?.success = false
                    
                } else if let safeData = data {
                    do {
                        
                        let loginResponse = try JSONDecoder().decode(UserData.self, from: safeData)
                        
                        self?.working = false
                        self?.failed = false
                        self?.success = true
                        
                        self?.loggedInUser = self?.parseJSON(safeData)
                        Authentication().isAuthenticated()
                        
                        print("Response ok: \((response as! HTTPURLResponse).statusCode)")
                        print(loginResponse)
                        
                        
                    } catch {
                        
                        self?.working = false
                        self?.failed = true
                        self?.success = false
                        
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
    
    func parseJSON(_ userData: Data) -> UserModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(UserData.self, from: userData)
            
            let id = decodedData.id
            let nombre = decodedData.nombre
            let apellido = decodedData.apellido
            let acceso = decodedData.acceso
            let admin = decodedData.admin
            
            let parsedUser = UserModel(id: id, nombre: nombre, apellido: apellido, acceso: acceso, admin: admin)
            
            return parsedUser
            
        } catch {
            return nil
        }
    }
    
}

