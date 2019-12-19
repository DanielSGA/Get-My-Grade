//
//  ViewControllerAgregaActividad.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit
// MARK: - protocol
protocol protocoloAgregaActividad{
func agregaActividad(act:Actividad)->Void
func guardaActividades()->Void
}
class ViewControllerAgregaActividad: UIViewController,UITextFieldDelegate {
    // MARK: - Variables y Outlets
    var delegado: protocoloAgregaActividad!
    var idCategoria: Int!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCalificacion: UITextField!
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
// MARK: - viewDidLoad
override func viewDidLoad() {
    super.viewDidLoad()
    self.addDoneButtonOnKeyboard()
    self.tfNombre.delegate = self
    self.tfCalificacion.delegate = self
        // Do any additional setup after loading the view.
    }
// MARK: - Guardar datos escritos
@IBAction func guardar(_ sender: UIButton) {
    let nom = tfNombre.text
    let cal = Int(tfCalificacion.text!)
    if nom != "", cal != nil
    {
       
        if(cal!>100)
        {
        let alertController = UIAlertController(title: "Alerta", message: "Se esta agregando una calificacion arriba de 100", preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Modificar", style: .default) { (action) in
                    
        }
            let aceptar = UIAlertAction(title: "Aceptar", style: .default){
                (action) in
                let number = Int.random(in: 0 ... 10000)
                let unAct = Actividad(nombre:nom!, calificacion: cal!, id: number, idCategoria: self.idCategoria)
                self.delegado.agregaActividad(act: unAct)
                self.delegado.guardaActividades()
                self.navigationController?.popViewController(animated: true)
            }
        alertController.addAction(aceptar)
        alertController.addAction(cancelar)
        present(alertController,animated: true,completion: nil)
        }
        if cal!<=100
        {
           
            let number = Int.random(in: 0 ... 1000)
            let unAct = Actividad(nombre:nom!, calificacion: cal!, id: number, idCategoria: idCategoria)
            delegado.agregaActividad(act: unAct)
            delegado.guardaActividades()
            navigationController?.popViewController(animated: true)
        }
    }
    }
    // MARK: - Done del teclado
    @objc func analisis()->Void
    {
        let nom = tfNombre.text
        let cal = Int(tfCalificacion.text!)
        if nom != "", cal != nil
        {
           
            if(cal!>100)
            {
            let alertController = UIAlertController(title: "Alerta", message: "Se esta agregando una calificacion arriba de 100", preferredStyle: .alert)
            let cancelar = UIAlertAction(title: "Modificar", style: .default) { (action) in
                        
            }
                let aceptar = UIAlertAction(title: "Aceptar", style: .default){
                    (action) in
                    let number = Int.random(in: 0 ... 10000)
                    let unAct = Actividad(nombre:nom!, calificacion: cal!, id: number, idCategoria: self.idCategoria)
                    self.delegado.agregaActividad(act: unAct)
                    self.delegado.guardaActividades()
                    self.navigationController?.popViewController(animated: true)
                }
            alertController.addAction(aceptar)
            alertController.addAction(cancelar)
            present(alertController,animated: true,completion: nil)
            }
            if cal!<=100
            {
               
                let number = Int.random(in: 0 ... 1000)
                let unAct = Actividad(nombre:nom!, calificacion: cal!, id: number, idCategoria: idCategoria)
                delegado.agregaActividad(act: unAct)
                delegado.guardaActividades()
                navigationController?.popViewController(animated: true)
            }
        }
    }
     // MARK: -Esconder Teclado
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

            let activeField: UIView? = [tfNombre,tfCalificacion].first { $0.isFirstResponder }
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
    // MARK: - Done y Next
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.switchBasedNextTextField(textField)
         return true
     }
     private func switchBasedNextTextField(_ textField: UITextField) {
         switch textField {
         case self.tfNombre:
             self.tfCalificacion.becomeFirstResponder()
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

            self.tfCalificacion.inputAccessoryView = doneToolbar
        }

    @objc func doneButtonAction() {
            self.tfCalificacion.resignFirstResponder()
         
            //self.view.endEditing(true);
            
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
