//
//  Top5Modelo.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 05/12/20.
//

import Foundation

struct Top5Modelo {
    let pais: [String]
    let bandera: [URL]
    let total_casos: [Double]
    let total_muertes: [Double]
    
    var TotalGlobal: Double {
        var total_global = 0.0
        for caso in total_casos {
            total_global = total_global + caso
        }
        return total_global
    }
    
    var TopPaises: [Int] {
        var i = [Int]()
        var casos = total_casos
        casos = casos.sorted()
        i.append(total_casos.firstIndex(of: casos[casos.count-1])!)
        i.append(total_casos.firstIndex(of: casos[casos.count-2])!)
        i.append(total_casos.firstIndex(of: casos[casos.count-3])!)
        i.append(total_casos.firstIndex(of: casos[casos.count-4])!)
        i.append(total_casos.firstIndex(of: casos[casos.count-5])!)
        return i
    }
}
