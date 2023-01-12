//
//  LoginViewModel.swift
//  Reto_Final
//
//  Created by JML on 17/12/22.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    // Singleton
    static let shared = LoginViewModel()
    
    @ObservedObject var authenticationService = AuthenticationService.shared.self
    @Published var hasError: Bool = false
    @Published var isLoggingIn: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var defaults = UserDefaults()
    
    var email: String = ""
    var password: String  = ""
    
    init() { }
    
    func login(email: String, password: String) {
        if email.isEmpty || password.isEmpty  {
            self.hasError = true
            return
        } else {
            DispatchQueue.main.async {
                self.isLoggingIn = true
            }
            authenticationService.login(email: email, password: password, completion: { [ weak self ] success in
                DispatchQueue.main.async {
                    self!.isLoggedIn = success ? true : false;
                    self!.hasError = success ? false : true;
                    self!.isLoggingIn = success ? false : true;
                }
            })
        }
    }
    
    func updateBusyStatus() {
        self.isLoggingIn = false
    }
    
    func saveUserSettings() {
        defaults = UserDefaults.standard
        defaults.set(email, forKey: "LastUserEmail")
        defaults.set(password, forKey: "BMASP")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(Date(), forKey: "LastRun")
        print("Saving: \(String(describing: defaults.string(forKey: "LastUserEmail")))")
    }
    
    func retrieveUserSettings() {
        self.email = self.defaults.string(forKey: "LastUserEmail") ?? ""
    }
}



