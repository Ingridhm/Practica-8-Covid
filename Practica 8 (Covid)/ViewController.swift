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
    
    var topmanager = Top5Manager()

    override func viewDidLoad() {
        super.viewDidLoad()
        Estilos()
        topmanager.delegado = self
        //BuscarField.delegate = self
        topmanager.ObtenerCasos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnviarPais" {
            if (BuscarField.text == "") {
                let alert = UIAlertController(title: "Campo en blanco", message: "Por favor ingrese el nombre de un país", preferredStyle: .alert)
                let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(aceptar)
                present(alert, animated: true, completion: nil)
            }
            else {
                let destino = segue.destination as! PaisViewController
                destino.pais = BuscarField.text
                BuscarField.text = ""
            }
        }
        if segue.identifier == "EnviarPais1" {
            let destino = segue.destination as! PaisViewController
            destino.pais = Pais1Label.text
        }
        if segue.identifier == "EnviarPais2" {
            let destino = segue.destination as! PaisViewController
            destino.pais = Pais2Label.text
        }
        if segue.identifier == "EnviarPais3" {
            let destino = segue.destination as! PaisViewController
            destino.pais = Pais3Label.text
        }
        if segue.identifier == "EnviarPais4" {
            let destino = segue.destination as! PaisViewController
            destino.pais = Pais4Label.text
        }
        if segue.identifier == "EnviarPais5" {
            let destino = segue.destination as! PaisViewController
            destino.pais = Pais5Label.text
        }
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
/*extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(BuscarField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (BuscarField.text != "") {
            return true
        }
        else {
            BuscarField.placeholder = "Ingresa un país"
            return false
        }
    }
}*/

//MARK:- Actualizar Covid TOP5
extension ViewController: Top5ManagerDelegate {
    func ActualizarTop(casos: Top5Modelo) {
        DispatchQueue.main.async {
            //print(casos.total_casos.sorted())
            print("TOTAL DE CASOS MUNDIALES: \(casos.TotalGlobal)")
            self.CasosGlobalesLabel.text = String(casos.TotalGlobal.Commas())
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
            self.Pais1Casos.text = String(casos.total_casos[i].Commas())
            self.Pais1Muertes.text = String(casos.total_muertes[i].Commas())
            //SEGUNDO
            i = casos.TopPaises[1]
            self.Pais2Label.text = casos.pais[i]
            self.Pais2Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais2Casos.text = String(casos.total_casos[i].Commas())
            self.Pais2Muertes.text = String(casos.total_muertes[i].Commas())
            //TERCERO
            i = casos.TopPaises[2]
            self.Pais3Label.text = casos.pais[i]
            self.Pais3Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais3Casos.text = String(casos.total_casos[i].Commas())
            self.Pais3Muertes.text = String(casos.total_muertes[i].Commas())
            //CUARTO
            i = casos.TopPaises[3]
            self.Pais4Label.text = casos.pais[i]
            self.Pais4Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais4Casos.text = String(casos.total_casos[i].Commas())
            self.Pais4Muertes.text = String(casos.total_muertes[i].Commas())
            //QUINTO
            i = casos.TopPaises[4]
            self.Pais5Label.text = casos.pais[i]
            self.Pais5Bandera.image = UIImage(data: try! Data(contentsOf: casos.bandera[i]))
            self.Pais5Casos.text = String(casos.total_casos[i].Commas())
            self.Pais5Muertes.text = String(casos.total_muertes[i].Commas())
        }
    }
    
    func Error(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Pais no encontrado", message: "Por favor verifique que el nombre del pais ingresado sea correcto", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(aceptar)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK:- Formato de números con comas
extension Double {
    func Commas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
