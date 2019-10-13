//
//  Materia.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 10/12/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class Materia: NSObject {
    var nombre: String = ""
    var id: Int = 0
    var idSemestre: Int = 0
    init(nombre:String,id:Int,idSemestre:Int)
    {
        self.nombre=nombre
        self.id=id
        self.idSemestre=idSemestre
    }
}
