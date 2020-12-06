//
//  CovidManager.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 03/12/20.
//

import Foundation

protocol CovidManagerDelegate {
    func Actualizar(casos: CovidModelo)
    func Error(error: Error)
}

struct CovidManager {
    var delegado: CovidManagerDelegate?
    let url = "https://corona.lmao.ninja/v3/covid-19/countries"
    
    func ObtenerCasos(pais: String) {
        let urls = "\(url)/\(pais)"
        print(urls)
        Solicitar(urls: urls)
    }
    
    func Solicitar(urls: String) {
        if let url = URL(string: urls) {
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
                delegado?.Actualizar(casos: casos)
            }
        }
    }
    
    func Decodificar(casos: Data) -> CovidModelo? {
        let decoder = JSONDecoder()
        var pais = [String]()
        var bandera = [URL]()
        var total_casos = [Double]()
        var total_muertes = [Double]()
        do {
            let decoded = try decoder.decode(CovidData.self, from: casos)
            pais.append(decoded.country)
            bandera.append(decoded.countryInfo.flag)
            total_casos.append(decoded.cases)
            total_muertes.append(decoded.deaths)
            let casos = CovidModelo(pais: pais, bandera: bandera, total_casos: total_casos, total_muertes: total_muertes)
            return casos
        }
        catch {
            print(error)
            delegado?.Error(error: error)
            return nil
        }
    }
}
