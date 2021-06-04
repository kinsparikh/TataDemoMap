//
//  ListOfVehicleCell.swift
//  TataMapDemo
//
//  Created by Kayaan on 04/06/21.
//  Copyright © 2021 Abhilash Mathur. All rights reserved.
//

import UIKit

class ListOfVehicleCell: UITableViewCell {
  
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var imgVehicle: UIImageView!
    @IBOutlet weak var innerView: UIView!
       

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
