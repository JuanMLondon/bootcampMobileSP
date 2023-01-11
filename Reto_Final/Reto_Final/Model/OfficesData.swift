//
//  OfficesData.swift
//  Reto_Final
//
//  Created by JML on 18/12/22.
//

import _MapKit_SwiftUI
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
    var longitudeDouble: Double {
        return Double(Longitud) ?? 0.0
    }
    var latitudeDouble: Double {
        return Double(Latitud) ?? 0.0
    }
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitudeDouble, longitude: longitudeDouble)
    }
}
