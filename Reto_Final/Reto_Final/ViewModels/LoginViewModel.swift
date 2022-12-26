//
//  LoginViewModel.swift
//  Reto_Final
//
//  Created by JML on 17/12/22.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @ObservedObject var networkService = NetworkService.shared.self
    
    @Published var hasError: Bool = false
    @Published var isLoggingIn: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var defaults: UserDefaults?
    
    var email: String = ""
    var password: String  = ""
    
    func login(email: String, password: String) {
        if email.isEmpty || password.isEmpty  {
            self.hasError = true
            return
        } else {
            self.isLoggingIn = true
            networkService.login(email: email, password: password, completion: { [ weak self ] success in
                DispatchQueue.main.async {
                    self!.isLoggedIn = success ? true : false;
                    self!.hasError = success ? false : true;
                    self!.isLoggingIn = success ? false : true;
                }
                //print("Is successful?: \(success)")
                //print("Has error?: \(String(describing: self!.hasError))")
                //print("Is logging in??: \(String(describing: self!.isLoggingIn!))")
                //print("Is logged in?: \(String(describing: self!.isLoggedIn ?? false))")
            })
        }
    }
    
    func updateBusyStatus() {
        self.isLoggingIn = false
    }
    
    func saveUserSettings() {
        defaults = UserDefaults.standard
        defaults!.set(email, forKey: "LastUserEmail")
        defaults!.set(true, forKey: "UseTouchID")
        defaults!.set(Date(), forKey: "LastRun")
        print("Saving: \(defaults?.string(forKey: "LastUserEmail")! ?? "")")
    }
}

