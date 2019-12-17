//
//  ViewControllerAnalisis.swift
//  GetMyGrade
//
//  Created by user158430 on 11/5/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class ViewControllerAnalisis: UIViewController {
     // MARK: - Variables y Outlets
    var listaMaterias = [Materia]()
    var matAnalisis : Materia!
    var idMat : Int!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lbPrueba: UILabel!
    @IBOutlet weak var lbCalif: UILabel!
    @IBOutlet weak var tfMeta: UITextField!
    @IBOutlet weak var lbAnalisis: UILabel!
    @IBOutlet weak var lbAnalisis2: UILabel!
    @IBOutlet weak var lbAnalisis3: UILabel!
      // MARK: - DataFileUrl
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Materias.plist")
        return pathArchivo
    }
    
     // MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
         self.addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaMaterias = try PropertyListDecoder().decode([Materia].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        var i = 0
        while (listaMaterias.count > i){

            if (listaMaterias[i].id == idMat){
                matAnalisis = listaMaterias[i]
                print(listaMaterias[i].calificacion)
            }
                           
        i += 1
        }
        
        lbPrueba.text = matAnalisis.nombre
        lbCalif.text = String(matAnalisis.calificacion)
        lbAnalisis.isHidden = true
        lbAnalisis2.isHidden = true
        lbAnalisis3.isHidden = true
        print(matAnalisis.calificacion)
    }
 // MARK: -Hacer analisis
@IBAction func HacerAnalisis(_ sender: UIButton) {
        
    let meta = Int(tfMeta.text!)
        
        if meta == 0 || meta == nil {
            lbAnalisis.isHidden = true
            lbAnalisis2.isHidden = true
            lbAnalisis3.isHidden = true
        }
        else{
            lbAnalisis.isHidden = false
            lbAnalisis.text = "Actualmente llevas una calificacion de " + String(matAnalisis.calificacion)
            lbAnalisis2.isHidden = false
            lbAnalisis2.text = "Y buscas llegar a una calificacion de " + String(meta!)
            lbAnalisis3.isHidden = false
            
            if meta! <= matAnalisis.calificacion {
                
                lbAnalisis3.text = "Felicidades! Ya alcanzaste tu meta!"
            }
                
            else {
                
                let puntosParaMeta = meta! - matAnalisis.calificacion
                let puntosRestantes = 100 - matAnalisis.ponderacion
                
                
                if puntosRestantes < puntosParaMeta {
                    lbAnalisis3.text = "Lo sentimos mucho, con los puntos que quedan ya no podras alcanzar tu meta"
                }
                else{
                    let prom = (puntosParaMeta * 100)/puntosRestantes
                    lbAnalisis3.text = "En el resto de las actividades de la materia, necesitas obtener un promedio de " + String(prom) + " para llegar a tu meta."
                }
            }
        }
    }
    @objc func analisis()->Void
    {
       let meta = Int(tfMeta.text!)
        
        if meta == 0 || meta == nil {
            lbAnalisis.isHidden = true
            lbAnalisis2.isHidden = true
            lbAnalisis3.isHidden = true
        }
        else{
            lbAnalisis.isHidden = false
            lbAnalisis.text = "Actualmente llevas una calificacion de " + String(matAnalisis.calificacion)
            lbAnalisis2.isHidden = false
            lbAnalisis2.text = "Y buscas llegar a una calificacion de " + String(meta!)
            lbAnalisis3.isHidden = false
            
            if meta! <= matAnalisis.calificacion {
                
                lbAnalisis3.text = "Felicidades! Ya alcanzaste tu meta!"
            }
                
            else {
                
                let puntosParaMeta = meta! - matAnalisis.calificacion
                let puntosRestantes = 100 - matAnalisis.ponderacion
                
                
                if puntosRestantes < puntosParaMeta {
                    lbAnalisis3.text = "Lo sentimos mucho, con los puntos que quedan ya no podras alcanzar tu meta"
                }
                else{
                    let prom = (puntosParaMeta * 100)/puntosRestantes
                    lbAnalisis3.text = "En el resto de las actividades de la materia, necesitas obtener un promedio de " + String(prom) + " para llegar a tu meta."
                }
            }
        }
          self.view.endEditing(true)
    }
     // MARK: -Esconder Teclado
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
        @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            var safeArea = self.view.frame
            safeArea.size.height += scrollView.contentOffset.y
            safeArea.size.height -= keyboardSize.height + (UIScreen.main.bounds.height*0.04) // Adjust buffer to your liking

            // determine which UIView was selected and if it is covered by keyboard

            let activeField: UIView? = [tfMeta].first { $0.isFirstResponder }
            if let activeField = activeField {
                if safeArea.contains(CGPoint(x: 0, y: activeField.frame.maxY)) {
                    print("No need to Scroll")
                    return
                } else {
                    distance = activeField.frame.maxY - safeArea.size.height
                    scrollOffset = scrollView.contentOffset.y
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset + distance), animated: true)
                }
            }
            // prevent scrolling while typing

            scrollView.isScrollEnabled = false
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
            if distance == 0 {
                return
            }
            // return to origin scrollOffset
            self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: true)
            scrollOffset = 0
            distance = 0
            scrollView.isScrollEnabled = true
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

                self.tfMeta.inputAccessoryView = doneToolbar
            }

        @objc func doneButtonAction() {
                self.tfMeta.resignFirstResponder()
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
