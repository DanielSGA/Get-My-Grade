//
//  Semestre.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 10/12/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class Semestre: Codable {
    var nombre: String = ""
    var id: Int = 0
    init(nombre:String,id:Int)
    {
        self.nombre=nombre
        self.id=id
    }
}
