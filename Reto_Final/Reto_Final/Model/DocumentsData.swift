//
//  DocumentsData.swift
//  Reto_Final
//
//  Created by JML on 30/12/22.
//

import Foundation

struct DocumentsData: Decodable {
    let Items: [DocumentModel]
    let Count: Int
    let ScannedCount: Int
}


struct DocumentModel: Decodable, Identifiable {
    var id: String {
        return IdRegistro ?? ""
    }
    let IdRegistro: String?
    let Fecha: String?
    let Nombre: String?
    let Apellido: String?
    let TipoAdjunto: String?
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z''"
        let date = formatter.date(from: Fecha!) ?? Date.now
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}


struct GetDocumentData: Decodable {
    let Items: [GetDocumentModel]
}


struct GetDocumentModel: Decodable {
    let IdRegistro: String?
    let Fecha: String?
    let TipoId: String?
    let Identificacion: String?
    let Nombre: String?
    let Apellido: String?
    let Ciudad: String?
    let Correo: String?
    let TipoAdjunto: String?
    let Adjunto: String?
}


struct PostDocumentModel: Codable {
    let TipoId: String?
    let Identificacion: String?
    let Nombre: String?
    let Apellido: String?
    let Ciudad: String?
    let Correo: String?
    let TipoAdjunto: String?
    let Adjunto: String?
}


struct PutModel: Decodable {
    let put: Bool
}
