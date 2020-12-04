//
//  ViewController.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 03/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BuscarView: UIView!
    @IBOutlet weak var GlobalView: UIView!
    @IBOutlet weak var BuscarField: UITextField!
    @IBOutlet weak var CasosGlobalesLabel: UILabel!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var Pais1View: UIView!
    @IBOutlet weak var Pais2View: UIView!
    @IBOutlet weak var Pais3View: UIView!
    @IBOutlet weak var Pais4View: UIView!
    @IBOutlet weak var Pais5View: UIView!
    
    var covidmanager = CovidManager()
    var topmanager = Top5Manager()

    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        covidmanager.delegado = self
        topmanager.delegado = self
        BuscarField.delegate = self
        topmanager.ObtenerCasos()
    }
    
    func Estilos() {
        BuscarView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        BuscarView.layer.cornerRadius = 10
        GlobalView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        GlobalView.layer.cornerRadius = 20
        TopView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        TopView.layer.cornerRadius = 10
        Pais1View.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        Pais1View.layer.cornerRadius = 10
        Pais2View.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        Pais2View.layer.cornerRadius = 10
        Pais3View.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        Pais3View.layer.cornerRadius = 10
        Pais4View.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        Pais4View.layer.cornerRadius = 10
        Pais5View.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        Pais5View.layer.cornerRadius = 10
    }
    
}

//MARK:- BuscarButton
extension ViewController: UITextFieldDelegate {
    @IBAction func Buscar(_ sender: UIButton) {
        if (BuscarField.text == "") {
            let alert = UIAlertController(title: "Campo en blanco", message: "Por favor ingrese el nombre de un país", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            present(alert, animated: true, completion: nil)
        }
        else {
            //CiudadLabel.text = BuscarField.text
            covidmanager.ObtenerCasos(pais: BuscarField.text!)
            BuscarField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(BuscarField.text!)
        //CiudadLabel.text = BuscarField.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (BuscarField.text != "") {
            return true
        }
        else {
            BuscarField.placeholder = "Ingresa una ciudad"
            return false
        }
    }
}

//MARK:- Actualizar Covid País
extension ViewController: CovidManagerDelegate {
    func Actualizar(casos: CovidModelo) {
        DispatchQueue.main.async {
            print("País: \(casos.pais[0])")
            print("Bandera \(casos.bandera[0])")
            print("Total de casos: \(casos.total_casos[0])")
        }
    }
    
    func Error(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            //self.Limpiar()
            let alert = UIAlertController(title: "Pais no encontrado", message: "Por favor verifique que el nombre del pais ingresado sea correcto", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK:- Actualizar Covid TOP5
extension ViewController: Top5ManagerDelegate {
    func ActualizarTop(casos: CovidModelo) {
        DispatchQueue.main.async {
            for p in casos.pais {
                print(p)
            }
            for b in casos.bandera {
                print(b)
            }
            for c in casos.total_casos {
                print(c)
            }
            print(casos.total_casos.sorted())
            print("TOTAL DE CASOS MUNDIALES: \(casos.TotalGlobal)")
            self.CasosGlobalesLabel.text = casos.TotalGlobal
        }
    }
}
