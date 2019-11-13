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
    
    @IBOutlet weak var tfNombre: UITextField!
    var delegado: protocoloAgregaMateria!
        
    //var gradientLayer: CAGradientLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        if let nom = tfNombre.text
        {
            let number = Int.random(in: 0 ... 1000)
            let unaMat = Materia(nombre:nom, id: number, calificacion: 0)
            delegado.agregaMateria(mat: unaMat)
            delegado.guardaMaterias()
            navigationController?.popToRootViewController(animated: true)
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

}
