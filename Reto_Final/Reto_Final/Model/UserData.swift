//
//  User.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import Foundation

struct UserData: Decodable {
    let id: String
    let nombre: String
    let apellido: String
    let acceso: Bool
    let admin: Bool
}

