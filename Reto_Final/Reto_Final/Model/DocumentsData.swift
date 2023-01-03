//
//  DocumentsData.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import Foundation

struct DocumentsData: Codable {
    let Items: [String]
}

struct Items: Codable, Identifiable {
    var id: String {
        return IdRegistro
    }
    let IdRegistro: String
    let Fecha: String
    let TipoId: String
    let Identificacion: String
    let Nombre: String
    let Apellido: String
    let Ciudad: String
    let Correo: String
    let TipoAdjunto: String
    let Adjunto: String
}
