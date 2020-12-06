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
    @IBOutlet weak var Pais1Label: UILabel!
    @IBOutlet weak var Pais2Label: UILabel!
    @IBOutlet weak var Pais3Label: UILabel!
    @IBOutlet weak var Pais4Label: UILabel!
    @IBOutlet weak var Pais5Label: UILabel!
    @IBOutlet weak var Pais1Casos: UILabel!
    @IBOutlet weak var Pais2Casos: UILabel!
    @IBOutlet weak var Pais3Casos: UILabel!
    @IBOutlet weak var Pais4Casos: UILabel!
    @IBOutlet weak var Pais5Casos: UILabel!
    @IBOutlet weak var Pais1Muertes: UILabel!
    @IBOutlet weak var Pais2Muertes: UILabel!
    @IBOutlet weak var Pais3Muertes: UILabel!
    @IBOutlet weak var Pais4Muertes: UILabel!
    @IBOutlet weak var Pais5Muertes: UILabel!
    @IBOutlet weak var Pais1Bandera: UIImageView!
    @IBOutlet weak var Pais2Bandera: UIImageView!
    @IBOutlet weak var Pais3Bandera: UIImageView!
    @IBOutlet weak var Pais4Bandera: UIImageView!
    @IBOutlet weak var Pais5Bandera: UIImageView!
    
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
            //print(casos.total_casos.sorted())
            //print("TOTAL DE CASOS MUNDIALES: \(casos.TotalGlobal)")
            self.CasosGlobalesLabel.text = casos.TotalGlobal
            /*for i in casos.TopPaises {
                print("PAIS: \(casos.pais[i])")
                print("BANDERA: \(casos.bandera[i])")
                print("CASOS: \(casos.total_casos[i])")
                print("MUERTES: \(casos.total_muertes[i])")
            }*/
            //PRIMERO
            var i = casos.TopPaises[0]
            self.Pais1Label.text = casos.pais[i]
            self.Pais1Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais1Casos.text = String(format: "%.0f", casos.total_casos[i])
            self.Pais1Muertes.text = String(format: "%.0f", casos.total_muertes[i])
            //SEGUNDO
            i = casos.TopPaises[1]
            self.Pais2Label.text = casos.pais[i]
            self.Pais2Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais2Casos.text = String(format: "%.0f", casos.total_casos[i])
            self.Pais2Muertes.text = String(format: "%.0f", casos.total_muertes[i])
            //TERCERO
            i = casos.TopPaises[2]
            self.Pais3Label.text = casos.pais[i]
            self.Pais3Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais3Casos.text = String(format: "%.0f", casos.total_casos[i])
            self.Pais3Muertes.text = String(format: "%.0f", casos.total_muertes[i])
            //CUARTO
            i = casos.TopPaises[3]
            self.Pais4Label.text = casos.pais[i]
            self.Pais4Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais4Casos.text = String(format: "%.0f", casos.total_casos[i])
            self.Pais4Muertes.text = String(format: "%.0f", casos.total_muertes[i])
            //QUINTO
            i = casos.TopPaises[4]
            self.Pais5Label.text = casos.pais[i]
            self.Pais5Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais5Casos.text = String(format: "%.0f", casos.total_casos[i])
            self.Pais5Muertes.text = String(format: "%.0f", casos.total_muertes[i])
        }
    }
}
