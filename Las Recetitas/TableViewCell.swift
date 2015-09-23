//
//  TableViewCell.swift
//  Las Recetitas
//
//  Created by Laura Sirvent Collado on 28/8/15.
//  Copyright © 2015 Laura Sirvent Collado. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var recipeDesc: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
