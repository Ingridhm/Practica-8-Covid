//
//  PaisViewController.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 05/12/20.
//

import UIKit

class PaisViewController: UIViewController {

    @IBOutlet weak var PaisView: UIView!
    @IBOutlet weak var CasosView: UIView!
    @IBOutlet weak var MuertesView: UIView!
    @IBOutlet weak var HistoricoTitleView: UIView!
    @IBOutlet weak var HistoricoView: UIView!
    @IBOutlet weak var HoyTitleView: UIView!
    @IBOutlet weak var HoyView: UIView!
    @IBOutlet weak var PaisLabel: UILabel!
    @IBOutlet weak var PoblacionLabel: UILabel!
    @IBOutlet weak var TotalCasosLabel: UILabel!
    @IBOutlet weak var TotalMuertesLabel: UILabel!
    @IBOutlet weak var TotalActivosLabel: UILabel!
    @IBOutlet weak var TotalCriticosLabel: UILabel!
    @IBOutlet weak var TotalRecuperadosLabel: UILabel!
    @IBOutlet weak var CasosHoyLabel: UILabel!
    @IBOutlet weak var MuertesHoyLabel: UILabel!
    @IBOutlet weak var RecuperadosHoyLabel: UILabel!
    @IBOutlet weak var BanderaView: UIImageView!
    
    var pais: String?
    var covidmanager = CovidManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        print(pais!)
        covidmanager.delegado = self
        covidmanager.ObtenerCasos(pais: pais!)
    }
    
    func Estilos() {
        PaisView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        PaisView.layer.cornerRadius = 20
        CasosView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        CasosView.layer.cornerRadius = 10
        MuertesView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        MuertesView.layer.cornerRadius = 10
        HistoricoTitleView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        HistoricoTitleView.layer.cornerRadius = 10
        HistoricoView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        HistoricoView.layer.cornerRadius = 10
        HoyTitleView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        HoyTitleView.layer.cornerRadius = 10
        HoyView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        HoyView.layer.cornerRadius = 10
    }
}

//MARK:- Actualizar Covid País
extension PaisViewController: CovidManagerDelegate {
    func Actualizar(casos: CovidModelo) {
        DispatchQueue.main.async {
            print("País: \(casos.pais)")
            print("Bandera \(casos.bandera)")
            print("Total de casos: \(casos.total_casos)")
            print("Total de muertes: \(casos.total_muertes)")
            print("Total de recuperados: \(casos.total_recuperados)")
            print("Total de activos: \(casos.total_activos)")
            print("Total de críticos: \(casos.total_criticos)")
            print("Total de pobación: \(casos.total_poblacion)")
            print("Casos hoy: \(casos.casos_hoy)")
            print("Muertes hoy: \(casos.muertes_hoy)")
            print("Recuperados hoy: \(casos.recuperados_hoy)")
            self.PaisLabel.text = casos.pais
            self.BanderaView.image = UIImage(data: try! Data(contentsOf: casos.bandera))
            self.TotalCasosLabel.text = String(casos.total_casos.withCommas())
            self.TotalMuertesLabel.text = String(casos.total_muertes.withCommas())
            self.TotalRecuperadosLabel.text = String(casos.total_recuperados.withCommas())
            self.TotalActivosLabel.text = String(casos.total_activos.withCommas())
            self.TotalCriticosLabel.text = String(casos.total_criticos.withCommas())
            self.PoblacionLabel.text = String(casos.total_poblacion.withCommas())
            self.CasosHoyLabel.text = String(casos.casos_hoy.withCommas())
            self.MuertesHoyLabel.text = String(casos.muertes_hoy.withCommas())
            self.RecuperadosHoyLabel.text = String(casos.recuperados_hoy.withCommas())
        }
    }
    
    func Error(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            //self.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "Pais no encontrado", message: "Por favor verifique que el nombre del pais ingresado sea correcto", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK:- Formato de números con comas
extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
