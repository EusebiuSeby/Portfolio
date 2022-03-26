//
//  TaskCellVC.swift
//  ToDo
//
//  Created by Pudilic Seby on 15.03.2022.
//

import UIKit


class TaskCellVC: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorView.layer.cornerRadius = 12
        colorView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
