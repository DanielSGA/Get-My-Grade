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
class ViewControllerAgregaMateria: UIViewController,UITextFieldDelegate{
    // MARK: - Variables y Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfNombre: UITextField!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    var delegado: protocoloAgregaMateria!
   
     // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfNombre.delegate = self
         tfNombre.addTarget(self, action: #selector(MyTextFielAction)
                               , for: UIControl.Event.primaryActionTriggered)
        self.tfNombre.becomeFirstResponder()
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: tfNombre.frame.height-2, width: tfNombre.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 152/255, green: 25/255, blue: 25/255, alpha: 1).cgColor
        tfNombre.borderStyle = .none
        tfNombre.layer.addSublayer(bottomLine)
    // Do any additional setup after loading the view.
    }
     // MARK: - Guardar datos escritos
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
                else if(nom == "")
                    {
                        let alert = UIAlertController(title: "Missing value", message: "Name of the course is missing", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                            self.tfNombre.becomeFirstResponder()
                        }
                        alert.addAction(ok)
                        present(alert,animated: true,completion: nil)
                    }
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
