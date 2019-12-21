//
//  ViewControllerAgregaCategoria.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit
protocol protocoloAgregaCategoria{
    func agregaCategoria(cat:Categoria)->Void
    func guardaCategorias()->Void
}
class ViewControllerAgregaCategoria: UIViewController,UITextFieldDelegate {
    // MARK: - Variables y Outlets
    var delegado: protocoloAgregaCategoria!
    var idMateria : Int!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    var listaCategorias = [Categoria]()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfPorcentaje: UITextField!
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfNombre.delegate = self
        self.tfPorcentaje.delegate = self
        self.addDoneButtonOnKeyboard()
        self.tfNombre.becomeFirstResponder()
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: tfNombre.frame.height-2, width: tfNombre.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 152/255, green: 25/255, blue: 25/255, alpha: 1).cgColor
        tfNombre.borderStyle = .none
        tfNombre.layer.addSublayer(bottomLine)
        
        let bottomLines = CALayer()
        bottomLines.frame = CGRect(x: 0, y: tfPorcentaje.frame.height-2, width: tfPorcentaje.frame.width, height: 2)
        bottomLines.backgroundColor = UIColor.init(red: 152/255, green: 25/255, blue: 25/255, alpha: 1).cgColor
        tfPorcentaje.borderStyle = .none
        tfPorcentaje.layer.addSublayer(bottomLines)
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaCategorias = try PropertyListDecoder().decode([Categoria].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
    }
    // MARK: - DataFileUrl
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Categorias.plist")
        return pathArchivo
    }
// MARK: -Acumulado de Porcentaje
    func calcularPorc() -> Int {
        var acum = 0
        var i = 0
        while(listaCategorias.count>i)
        {
            if(listaCategorias[i].idMateria == idMateria)
            {
                acum+=listaCategorias[i].ponderacion
            }
            i = i + 1
        }
        return acum
    }
// MARK: - Guardar datos escritos

    @objc func analisis()->Void
    {
       let nom = tfNombre.text
       let porc = Int(tfPorcentaje.text!)
       if nom != "", porc != nil
       {
       let porcAcum = calcularPorc() + porc!
           if(porcAcum>100)
           {
               let alertController = UIAlertController(title: "Alerta", message: "Se esta agregando una calificacion arriba de 100", preferredStyle: .alert)
               let cancelar = UIAlertAction(title: "Modificar", style: .default) { (action) in
                           
               }
                   let aceptar = UIAlertAction(title: "Aceptar", style: .default){
                       (action) in
                           let number = Int.random(in: 0 ... 10000)
                       let unaCat = Categoria(nombre:nom!, ponderacion: porc!, id: number, idMateria: self.idMateria, calificacion: 0)
                       self.delegado.agregaCategoria(cat: unaCat)
                       self.delegado.guardaCategorias()
                       self.navigationController?.popViewController(animated: true)
                   }
               alertController.addAction(aceptar)
               alertController.addAction(cancelar)
               present(alertController,animated: true,completion: nil)
           }
           if nom != "", porc != nil , porcAcum<=100
                  {
                      let number = Int.random(in: 0 ... 10000)
                      let unaCat = Categoria(nombre:nom!, ponderacion: porc!, id: number, idMateria: idMateria, calificacion: 0)
                      delegado.agregaCategoria(cat: unaCat)
                      delegado.guardaCategorias()
                      navigationController?.popViewController(animated: true)
                  }
       }
        else if(nom == "" && porc == nil)
            {
                let alert = UIAlertController(title: "Missing values", message: "Both values are missing", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                    self.tfNombre.becomeFirstResponder()
                }
                alert.addAction(ok)
                present(alert,animated: true,completion: nil)
                
            }
            else if(nom == "" && porc != nil)
            {
                let alert = UIAlertController(title: "Missing value", message: "Name of the category is missing", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                    self.tfNombre.becomeFirstResponder()
                }
                alert.addAction(ok)
                present(alert,animated: true,completion: nil)
            }
             else if(nom != "" && porc == nil)
            {
                let alert = UIAlertController(title: "Missing value", message: "Percentage of the category is missing", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                    self.tfPorcentaje.becomeFirstResponder()
                }
                alert.addAction(ok)
                present(alert,animated: true,completion: nil)
            }
         
    }
  
    // MARK: - Done y Next
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.tfNombre:
            self.tfPorcentaje.becomeFirstResponder()
        default:
            self.tfNombre.resignFirstResponder()
        }
    }
    func addDoneButtonOnKeyboard() {
                 let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
                 doneToolbar.barStyle       = UIBarStyle.default
         let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
         let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(analisis))

                 var items = [UIBarButtonItem]()
                 items.append(flexSpace)
                 items.append(done)

                 doneToolbar.items = items
                 doneToolbar.sizeToFit()

                 self.tfPorcentaje.inputAccessoryView = doneToolbar
             }

         @objc func doneButtonAction() {
                 self.tfPorcentaje.resignFirstResponder()
                 /* Or:
                 self.view.endEditing(true);
                 */
             }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Restringir rotacion
      override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.landscape
      }
      override var shouldAutorotate: Bool {
      return false
      }
}
