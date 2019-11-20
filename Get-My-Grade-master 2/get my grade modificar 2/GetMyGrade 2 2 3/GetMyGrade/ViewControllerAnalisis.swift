//
//  ViewControllerAnalisis.swift
//  GetMyGrade
//
//  Created by user158430 on 11/5/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class ViewControllerAnalisis: UIViewController {
    
    var listaMaterias = [Materia]()
    var matAnalisis : Materia!
    
    @IBOutlet weak var lbPrueba: UILabel!
    @IBOutlet weak var lbCalif: UILabel!
    @IBOutlet weak var tfMeta: UITextField!
    @IBOutlet weak var lbAnalisis: UILabel!
    @IBOutlet weak var lbAnalisis2: UILabel!
    
    @IBOutlet weak var lbAnalisis3: UILabel!
    var idMat : Int!
    
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Materias.plist")
        return pathArchivo
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaMaterias = try PropertyListDecoder().decode([Materia].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        var i = 0
        while (listaMaterias.count > i){

            if (listaMaterias[i].id == idMat){
                matAnalisis = listaMaterias[i]
                print(listaMaterias[i].calificacion)
            }
                           
        i += 1
        }
        
        lbPrueba.text = matAnalisis.nombre
        lbCalif.text = String(matAnalisis.calificacion)
        lbAnalisis.isHidden = true
        lbAnalisis2.isHidden = true
        lbAnalisis3.isHidden = true
        print(matAnalisis.calificacion)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
    return false
    }
    @IBAction func HacerAnalisis(_ sender: UIButton) {
        
        let meta = Int(tfMeta.text!)
        
        if meta == 0 || meta == nil {
            lbAnalisis.isHidden = true
            lbAnalisis2.isHidden = true
            lbAnalisis3.isHidden = true
        }
        else{
            lbAnalisis.isHidden = false
            lbAnalisis.text = "Actualmente llevas una calificacion de " + String(matAnalisis.calificacion)
            lbAnalisis2.isHidden = false
            lbAnalisis2.text = "Y buscas llegar a una calificacion de " + String(meta!)
            lbAnalisis3.isHidden = false
            
            if meta! <= matAnalisis.calificacion {
                
                lbAnalisis3.text = "Felicidades! Ya alcanzaste tu meta!"
            }
                
            else {
                
                let puntosParaMeta = meta! - matAnalisis.calificacion
                let puntosRestantes = 100 - matAnalisis.ponderacion
                
                
                if puntosRestantes < puntosParaMeta {
                    lbAnalisis3.text = "Lo sentimos mucho, con los puntos que quedan ya no podras alcanzar tu meta"
                }
                else{
                    let prom = (puntosParaMeta * 100)/puntosRestantes
                    lbAnalisis3.text = "En el resto de las actividades de la materia, necesitas obtener un promedio de " + String(prom) + " para llegar a tu meta."
                }
                
                
            }
            
        }
        
        
        
    }
    
    @IBAction func quitaTeclado() {
        view.endEditing(true)
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
