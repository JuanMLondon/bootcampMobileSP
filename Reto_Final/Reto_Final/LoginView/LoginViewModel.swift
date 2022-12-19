//
//  LoginViewModel.swift
//  Reto_Final
//
//  Created by JML on 17/12/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var hasError = false
    @Published var isLoggingIn = false
    @Published var loginSuccessful = false
    
    var verifyInputs: Bool {
        !email.isEmpty || !password.isEmpty
    }
    
    func login() {
        
        guard !email.isEmpty || !password.isEmpty else {
            return
        }
        
        var request = URLRequest(url: URL(string: "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Usuarios?idUsuario=\(email)&clave=\(password)")!)
        print(request)
        
        request.httpMethod = "GET"
        isLoggingIn = true
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [ weak self ] data, response, error in
        //let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
            //DispatchQueue.main.sync {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    print("Response error: \((response as! HTTPURLResponse).statusCode)")
                    self!.hasError = true
                } else if let safeData = data {
                    do {
                        let loginResponse = try JSONDecoder().decode(UserData.self, from: safeData)
                        print("Response ok: \((response as! HTTPURLResponse).statusCode)")
                        print(loginResponse)
                        self!.loginSuccessful = true
                    } catch {
                        print("Response catch: \((response as! HTTPURLResponse).statusCode)")
                        print("Unable to decode response \(error)")
                        self!.hasError = true
                    }
                }
                self!.isLoggingIn = false
            }
        })
        task.resume()
    }
}
