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
            }
                           
        i += 1
        }
        
        lbPrueba.text = matAnalisis.nombre
        lbCalif.text = String(matAnalisis.calificacion)
        print(matAnalisis.calificacion)
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
