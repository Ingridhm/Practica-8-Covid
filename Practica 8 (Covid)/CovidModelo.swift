//
//  CovidModelo.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 03/12/20.
//

import Foundation

struct CovidModelo {
    let pais: [String]
    let bandera: [URL]
    let total_casos: [Double]
    let total_muertes: [Double]
    
    var TotalGlobal: String {
        var total_global = 0.0
        for caso in total_casos {
            total_global = total_global + caso
        }
        return String(format: "%.0f", total_global)
    }
    
    var TopPaises: [Int] {
        var casos = [Double]()
        var i = [Int]()
        casos = total_casos
        //PRIMERO
        i.append(casos.firstIndex(of: casos.max()!)!)
        casos.remove(at: (casos.firstIndex(of: total_casos[i[0]])!))
        //SEGUNDO
        i.append(casos.firstIndex(of: casos.max()!)!)
        casos.remove(at: (casos.firstIndex(of: total_casos[i[1]])!))
        //TERCER
        i.append(casos.firstIndex(of: casos.max()!)!)
        casos.remove(at: (casos.firstIndex(of: total_casos[i[2]])!))
        //CUARTO
        i.append(casos.firstIndex(of: casos.max()!)!)
        casos.remove(at: (casos.firstIndex(of: total_casos[i[3]])!))
        //QUINTO
        i.append(casos.firstIndex(of: casos.max()!)!)
        casos.remove(at: (casos.firstIndex(of: total_casos[i[4]])!))
        return i
    }
}
