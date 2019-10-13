//
//  ViewControllerAgregaSemestre.swift
//  GetMyGrade
//
//  Created by user158022 on 10/10/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit
protocol protocoloAgregaSemestre{
    func agregaSemestre(sem:Semestre)->Void
}
class ViewControllerAgregaSemestre: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    var delegado:protocoloAgregaSemestre!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        if let nom = tfNombre.text
        {
            let unSem = Semestre(nombre:nom, id: 1)
            delegado.agregaSemestre(sem: unSem)
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
