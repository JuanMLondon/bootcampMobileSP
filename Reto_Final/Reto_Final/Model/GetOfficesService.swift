//
//  GetOfficesService.swift
//  Reto_Final
//
//  Created by JML on 7/01/23.
//

import Foundation

class GetOfficesService: ObservableObject {
    
    // Singleton
    static let shared = GetOfficesService() //Lazy access.
    
    @Published var officesList: [OfficeModel] = []
    @Published var currentCity: String? //= "Bogotá"
    
    init() { }
    
    func getOffices(completion: @escaping(Bool) -> Void) {
        
        var urlString = "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Oficinas"
        let safeCityQuery = "?ciudad=" + "\(String(describing: currentCity ?? "Medellín"))".addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        if currentCity != nil {
            urlString.append(safeCityQuery)
        }
        
        var request = URLRequest(url: URL(string: urlString)!)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        print("Resquest URL: \(request)")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { /*[weak self]*/ data, response, error in
            
            if let response = response as? HTTPURLResponse {
                print("All headers: \(response.allHeaderFields)")
                print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
                print("Response code: \((response ).statusCode)")
            }
            
            /*if let jsonData = data, let dataString = String(data: jsonData, encoding: .utf8) {
             print("Response data as string:\n\(dataString)")
             }*/
            
            if error != nil {
                print("An error has ocurred while connecting. \(String(describing: error))")
                
                completion(false)
                
            } else if let jsonData = data {
                DispatchQueue.main.async {
                    self.officesList = self.parseCitiesJSON(jsonData, completion: { [weak self] success in
                        self?.officesList = (success != nil) ? self!.officesList : [OfficeModel(IdOficina: 0, Nombre: "", Ciudad: "", Longitud: "", Latitud: "")]
                    })!
                    
                    // For debugging only. Modifies the variable's life cycle in memory.
                    /*self.officesList = self.parseCitiesJSON(jsonData, completion: { success in
                        self.officesList = (success != nil) ? self.officesList : [OfficeModel(IdOficina: 0, Nombre: "", Ciudad: "", Longitud: "", Latitud: "")]
                    })!*/
                    
                    completion(true)
                }
            }
        })
        task.resume()
    }
    
    func parseCitiesJSON(_ jsonData: Data, completion: @escaping([OfficeModel]?) -> Void) -> [OfficeModel]? {
        let decoder = JSONDecoder()
        do {
            
            let officesResponse = try decoder.decode(OfficesData.self, from: jsonData)
            self.officesList = officesResponse.Items
            
            OfficesView().officeLocations = officesResponse.Items
            
            //print("Decoder test (officesList Iterator):")
            //self.officesList.forEach({print($0.IdOficina, $0.Nombre, $0.Ciudad, $0.longitudeDouble, $0.latitudeDouble)})
            
            completion(self.officesList)
            return self.officesList
            
        } catch let jsonError {
            print("Error, unable to decode response:\n\(jsonError)")
            completion([])
            return([])
        }
    }
    
    func getOfficesList() -> [OfficeModel] {
        return self.officesList
    }
}
