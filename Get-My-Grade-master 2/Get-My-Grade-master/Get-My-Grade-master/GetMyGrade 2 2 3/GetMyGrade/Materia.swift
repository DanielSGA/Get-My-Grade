//
//  Materia.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 10/12/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class Materia: Codable {
    var nombre: String = ""
    var id: Int = 0
    var calificacion: Int = 0
    var ponderacion: Int = 0
    init(nombre:String,id:Int,calificacion:Int, ponderacion:Int)
    {
        self.nombre=nombre
        self.id=id
        self.calificacion=calificacion
        self.ponderacion = ponderacion
    }
}
