//
//  UITableViewCellMateria.swift
//  GetMyGrade
//
//  Created by user158022 on 11/17/19.
//  Copyright © 2019 ArturoMendez. All rights reserved.
//

import UIKit

class UITableViewCellMateria: UITableViewCell {

    @IBOutlet weak var lbMat: UILabel!
    
    @IBOutlet weak var lbCalif: UILabel!
    
    @IBOutlet weak var btAnalisis: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let backgroundColor = UIColor.init(red: 152/255, green: 25/255, blue: 25/255, alpha: 1).cgColor
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
