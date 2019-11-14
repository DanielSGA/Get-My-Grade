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
class ViewControllerAgregaCategoria: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfPorcentaje: UITextField!
    var delegado: protocoloAgregaCategoria!
    var idMateria : Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        if let nom = tfNombre.text,
            let porc = Int(tfPorcentaje.text!)
        {
            let number = Int.random(in: 0 ... 10000)
            let unaCat = Categoria(nombre:nom, ponderacion: porc, id: number, idMateria: idMateria, calificacion: 0)
            delegado.agregaCategoria(cat: unaCat)
            delegado.guardaCategorias()
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
