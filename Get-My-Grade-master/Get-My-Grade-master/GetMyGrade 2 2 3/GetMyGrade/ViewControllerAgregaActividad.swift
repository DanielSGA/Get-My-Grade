//
//  ViewControllerAgregaActividad.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit
protocol protocoloAgregaActividad{
func agregaActividad(act:Actividad)->Void
func guardaActividades()->Void
}
class ViewControllerAgregaActividad: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCalificacion: UITextField!
    var delegado: protocoloAgregaActividad!
    var idCategoria: Int!
    
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        if let nom = tfNombre.text,
            let cal = Int(tfCalificacion.text!)
        {
            let number = Int.random(in: 0 ... 1000)
            let unAct = Actividad(nombre:nom, calificacion: cal, id: number, idCategoria: idCategoria)
            delegado.agregaActividad(act: unAct)
            delegado.guardaActividades()
            navigationController?.popViewController(animated: true)
        }
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
