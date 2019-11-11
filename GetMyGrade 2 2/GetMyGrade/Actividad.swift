//
//  Actividad.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 10/12/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class Actividad: Codable {
    var nombre: String = ""
    var calificacion: Int = 0
    var id : Int = 0
    var idCategoria: Int = 0
    init(nombre:String,calificacion:Int,id:Int,idCategoria: Int)
    {
        self.nombre=nombre
        self.calificacion=calificacion
        self.id=id
        self.idCategoria=idCategoria
    }
}
