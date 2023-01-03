//
//  OfficesData.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import Foundation

struct OfficesData: Decodable {
    let Items: [String]
}

struct OfficesItems: Decodable, Identifiable {
    var id: Int {
        return IdOficina
    }
    let IdOficina: Int
    let Nombre: String
    let Ciudad: String
    let Longitud: String
    let Latitud: String
    
}
