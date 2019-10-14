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
}
class ViewControllerAgregaMateria: UIViewController {
    
    @IBOutlet weak var tfNombre: UITextField!
    var delegado: protocoloAgregaMateria!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        if let nom = tfNombre.text
        {
            let unaMat = Materia(nombre:nom, id: 1, idSemestre: 1)
            delegado.agregaMateria(mat: unaMat)
            navigationController?.popToRootViewController(animated: true)
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
