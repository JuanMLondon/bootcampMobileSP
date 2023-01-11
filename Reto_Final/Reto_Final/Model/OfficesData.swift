//
//  OfficesData.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import Foundation

struct OfficesData: Decodable {
    let Items: [OfficeModel]
    let Count: Int
    let ScannedCount: Int
}


struct OfficeModel: Decodable, Identifiable {
    var id: Int {
        return IdOficina
    }
    let IdOficina: Int
    let Nombre: String
    let Ciudad: String
    let Longitud: String
    let Latitud: String
    var LongitudeDouble: Double {
        return Double(Longitud) ?? 0.0
    }
    var LatitudeDouble: Double {
        return Double(Latitud) ?? 0.0
    }
}
