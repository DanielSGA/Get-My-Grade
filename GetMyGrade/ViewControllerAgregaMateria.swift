//
//  ViewControllerAgregaMateria.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit
protocol protocoloAgregaMateria{
    func agregaMateria(mat:Materia)->Void
    func guardaMaterias()->Void
}
class ViewControllerAgregaMateria: UIViewController {
    // MARK: - Variables y Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfNombre: UITextField!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    var delegado: protocoloAgregaMateria!
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
     // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
         tfNombre.addTarget(self, action: #selector(MyTextFielAction)
                               , for: UIControl.Event.primaryActionTriggered)
    // Do any additional setup after loading the view.
    }
     // MARK: - Guardar datos escritos
    @IBAction func guardar(_ sender: UIButton) {
        let nom = tfNombre.text
        if nom != ""
        {
            let number = Int.random(in: 0 ... 1000)
            let unaMat = Materia(nombre:nom!, id: number, calificacion: 0, ponderacion:  0)
            delegado.agregaMateria(mat: unaMat)
            delegado.guardaMaterias()
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    @objc func MyTextFielAction(textField: UITextField) {
        let nom = tfNombre.text
               if nom != ""
               {
                   let number = Int.random(in: 0 ... 1000)
                   let unaMat = Materia(nombre:nom!, id: number, calificacion: 0, ponderacion:  0)
                   delegado.agregaMateria(mat: unaMat)
                   delegado.guardaMaterias()
                   navigationController?.popToRootViewController(animated: true)
               }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
}
 // MARK: - Teclado
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

        let activeField: UIView? = [tfNombre].first { $0.isFirstResponder }
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
    /*
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
     
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.white.cgColor]
     
        self.view.layer.addSublayer(gradientLayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientLayer()
    }
    
    
    */

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
