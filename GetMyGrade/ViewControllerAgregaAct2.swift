//
//  ViewControllerAgregaAct2.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 11/01/20.
//  Copyright © 2020 ArturoMendez. All rights reserved.
//

import UIKit
// MARK: - protocol
protocol protocoloAgregaActividad2{
func agregaActividad(act:Actividad)->Void
func guardaActividades()->Void
}
class ViewControllerAgregaAct2: UIViewController,UITextFieldDelegate {
    var idCategoria: Int!
    var delegado:protocoloAgregaActividad2!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCalificacion: UITextField!
    @IBOutlet weak var tfPonderacion: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfNombre.delegate = self
        self.tfCalificacion.delegate = self
        self.tfPonderacion.delegate = self
        tfNombre.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    // MARK: - Guardar datos escritos
    @objc func analisis()->Void
    {
        let nom = tfNombre.text
        let cal = Int(tfCalificacion.text!)
        let pond = Int(tfPonderacion.text!)
        
    }
    // MARK: - Restringir rotacion
      override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.landscape
      }
      override var shouldAutorotate: Bool {
      return false
      }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
