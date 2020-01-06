//
//  ViewControllerAnalisis.swift
//  GetMyGrade
//
//  Created by user158430 on 11/5/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class ViewControllerAnalisis: UIViewController,UITextFieldDelegate,UIViewControllerTransitioningDelegate {
     // MARK: - Variables y Outlets
    var listaMaterias = [Materia]()
    var matAnalisis : Materia!
    var calif: CGFloat = 0
    var idMat : Int!
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    var countFired: CGFloat = 0
    var resultado: String!
    let transition = CircularTransition()
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var tfMeta: UITextField!
      // MARK: - DataFileUrl
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Materias.plist")
        return pathArchivo
    }
    
     // MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        // Do any additional setup after loading the view.
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaMaterias = try PropertyListDecoder().decode([Materia].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        self.tfMeta.delegate = self
        self.tfMeta.becomeFirstResponder()
        let bottomLine = CALayer()
              bottomLine.frame = CGRect(x: 0, y: tfMeta.frame.height-2, width: tfMeta.frame.width, height: 2)
              bottomLine.backgroundColor = UIColor.init(red: 152/255, green: 25/255, blue: 25/255, alpha: 1).cgColor
              tfMeta.borderStyle = .none
              tfMeta.layer.addSublayer(bottomLine)
        
        encontrarMateria()
        califBar()
        
    }
func encontrarMateria()
{
    var i = 0
         while (listaMaterias.count > i){

             if (listaMaterias[i].id == idMat){
                 matAnalisis = listaMaterias[i]
             }
                            
         i += 1
         }
}
 // MARK: -Progress Bar
 func califBar()
 {
    calif = CGFloat(Double(matAnalisis.calificacion) * 0.01)
    if(calif>0)
    {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
          self.countFired += 1
          
          DispatchQueue.main.async {
            self.progressBar.progress = min(0.03 * self.countFired, self.calif)
            
            if self.progressBar.progress == self.calif {
              timer.invalidate()
            }
          }
        }
    }
    else
    {
          DispatchQueue.main.async {
            self.progressBar.progress = min(0.0 * self.countFired, self.calif)
          }
        
    }
  }
 // MARK: -Hacer analisis
@IBAction func HacerAnalisis(_ sender: UIButton) {

    let meta = Int(tfMeta.text!)
        
        if meta == 0 || meta == nil {
            
        }
        else{
            if meta! <= matAnalisis.calificacion {
                
                resultado = "Felicidades! Ya alcanzaste tu meta!"
            }
                
            else {
                
                let puntosParaMeta = meta! - matAnalisis.calificacion
                let puntosRestantes = matAnalisis.total - matAnalisis.ponderacion
                
                if puntosRestantes < puntosParaMeta {
                    resultado = "Lo sentimos mucho, con los puntos que quedan ya no podras alcanzar tu meta"
                 
                }
                else{
                    let prom = (puntosParaMeta * 100)/puntosRestantes
                    resultado = "En el resto de las actividades de la materia, necesitas obtener un promedio de " + String(prom) + " para llegar a tu meta."
                }
            }
        }
    }
    
    // MARK: - Navigation y animacion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! ViewControllerResultadosAnalisis
         secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        secondVC.mostrar = resultado
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
  
    
    
    // MARK: - Restringir rotacion
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
    return false
    }
}
