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
        do {
            let decoded = try decoder.decode(CovidData.self, from: casos)
            let pais = decoded.country
            let bandera = decoded.countryInfo.flag
            let total_casos = decoded.cases
            let total_muertes = decoded.deaths
            let total_recuperados =  decoded.recovered
            let total_activos = decoded.active
            let total_criticos = decoded.critical
            let total_poblacion = decoded.population
            let casos_hoy = decoded.todayCases
            let muertes_hoy = decoded.todayDeaths
            let recuperados_hoy = decoded.todayRecovered
            let casos = CovidModelo(pais: pais, bandera: bandera, total_casos: total_casos, total_muertes: total_muertes, total_recuperados: total_recuperados, total_activos: total_activos, total_criticos: total_criticos, total_poblacion: total_poblacion, casos_hoy: casos_hoy, muertes_hoy: muertes_hoy, recuperados_hoy: recuperados_hoy)
            return casos
        }
        catch {
            print(error)
            delegado?.Error(error: error)
            return nil
        }
    }
}
