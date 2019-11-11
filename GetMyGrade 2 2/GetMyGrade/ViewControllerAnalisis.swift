//
//  ViewControllerAnalisis.swift
//  GetMyGrade
//
//  Created by user158430 on 11/5/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class ViewControllerAnalisis: UIViewController {
    
 var listaCategorias = [Categoria]()
 var listaActividades = [Actividad]()
    
    @IBOutlet weak var lbPrueba: UILabel!
    var materia : Materia!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            listaCategorias = try PropertyListDecoder().decode([Categoria].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl2())
            listaActividades = try PropertyListDecoder().decode([Actividad].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        lbPrueba.text = String(materia.nombre)
    }
    
    
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Categorias.plist")
        return pathArchivo
    }
    func dataFileUrl2() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Actividades.plist")
        return pathArchivo
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
