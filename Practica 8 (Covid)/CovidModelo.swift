//
//  CovidModelo.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 03/12/20.
//

import Foundation

struct CovidModelo {
    let pais: [String]
    let bandera: [String]
    let total_casos: [Double]
    
    var TotalGlobal: String {
        var total_global = 0.0
        for caso in total_casos {
            total_global = total_global + caso
        }
        return String(format: "%.0f", total_global)
    }
    
    var TopPaises: [String] {
        var x = total_casos.count
        var casos = total_casos.sorted()
        return [String(format: "%.0f", total_casos)]
    }
}
