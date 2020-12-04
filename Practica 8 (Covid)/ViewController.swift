//
//  ViewController.swift
//  Practica 8 (Covid)
//
//  Created by Ingrid on 03/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BuscarView: UIView!
    @IBOutlet weak var BuscarField: UITextField!
    
    var covidmanager = CovidManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        covidmanager.delegado = self
        BuscarField.delegate = self
    }
    
    func Estilos() {
        BuscarView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        BuscarView.layer.cornerRadius = 20
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

//MARK:- Actualizar
extension ViewController: CovidManagerDelegate {
    func Actualizar(casos: CovidModelo) {
        DispatchQueue.main.async {
            print("País: \(casos.pais)")
            print("Bandera \(casos.bandera)")
            print("Total de casos: \(casos.total_casos)")
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
