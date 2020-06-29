//
//  FightResultTVCell.swift
//  transformers
//
//  Created by macintosh on 2020-06-29.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

class FightResultTVCell: UITableViewCell {

    @IBOutlet weak var op1img: UIImageView!
    @IBOutlet weak var op1name: UILabel!
    @IBOutlet weak var op1status: UILabel!
    
    @IBOutlet weak var op2img: UIImageView!
    @IBOutlet weak var op2name: UILabel!
    @IBOutlet weak var op2status: UILabel!
    
    func setValuesFor(object: MatchResults) {
        op1img.setCustomImage(object.op1.team_icon)
        op1name.text = object.op1.name
        
        op2img.setCustomImage(object.op2.team_icon)
        op2name.text = object.op2.name
        
        if (object.tied){
            op1status.text = "TIED"
            op2status.text = "TIED"
        } else {
            if (object.winner != nil) {
                op1status.text = (object.winner!.id == object.op1.id) ? "WINNER" : "ELIMINATED"
                op2status.text = (object.winner!.id == object.op2.id) ? "WINNER" : "ELIMINATED"
            }
        }
        
    }
}
