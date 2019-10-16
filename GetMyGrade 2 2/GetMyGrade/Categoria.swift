//
//  Categoria.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 10/12/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class Categoria: Codable {
    var nombre: String = ""
    var ponderacion: Int = 0
    var id: Int = 0
    var idMateria: Int = 0
    init(nombre:String,ponderacion:Int,id:Int,idMateria: Int)
    {
        self.nombre=nombre
        self.ponderacion=ponderacion
        self.id=id
        self.idMateria=idMateria
    }

}
