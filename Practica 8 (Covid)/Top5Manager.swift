//
//  CovidManager.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 03/12/20.
//

import Foundation

protocol Top5ManagerDelegate {
    func ActualizarTop(casos: Top5Modelo)
    func Error(error: Error)
}

struct Top5Manager {
    var delegado: Top5ManagerDelegate?
    let url = "https://corona.lmao.ninja/v3/covid-19/countries"
    
    func ObtenerCasos() {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url, completionHandler: Handle(data:respuesta:error:))
            tarea.resume()
        }
    }
    
    func Handle(data: Data?, respuesta: URLResponse?, error: Error?) {
        if (error != nil) {
            delegado?.Error(error: error!)
            return
        }
        if let datos = data {
            if let casos = self.Decodificar(casos: datos) {
                delegado?.ActualizarTop(casos: casos)
            }
        }
    }
    
    func Decodificar(casos: Data) -> Top5Modelo? {
        let decoder = JSONDecoder()
        var pais = [String]()
        var bandera = [URL]()
        var total_casos = [Double]()
        var total_muertes = [Double]()
        do {
            let decoded = try decoder.decode([CovidData].self, from: casos)
            for c in decoded {
                pais.append(c.country)
                bandera.append(c.countryInfo.flag)
                total_casos.append(c.cases)
                total_muertes.append(c.deaths)
            }
            let casos = Top5Modelo(pais: pais, bandera: bandera, total_casos: total_casos, total_muertes: total_muertes)
            return casos
        }
        catch {
            print(error)
            delegado?.Error(error: error)
            return nil
        }
    }
}
