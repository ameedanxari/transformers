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
    
    func prepareUIFor(matchResult: MatchResults) {
        if matchResult.isAutobotWinner == true {
            op1img.setCustomImage(matchResult.autobot.team_icon)
            op1name.text = matchResult.autobot.name
            op1status.text = "WINNER"
            
            op2img.setCustomImage(matchResult.decepticon.team_icon)
            op2name.text = matchResult.decepticon.name
            op2status.text = "ELIMINATED"
        } else if matchResult.isAutobotWinner == false {
            op1img.setCustomImage(matchResult.decepticon.team_icon)
            op1name.text = matchResult.decepticon.name
            op1status.text = "WINNER"
            
            op2img.setCustomImage(matchResult.autobot.team_icon)
            op2name.text = matchResult.autobot.name
            op2status.text = "ELIMINATED"
        } else {
            op1img.setCustomImage(matchResult.autobot.team_icon)
            op1name.text = matchResult.autobot.name
            op1status.text = "TIED"
            
            op2img.setCustomImage(matchResult.decepticon.team_icon)
            op2name.text = matchResult.decepticon.name
            op2status.text = "TIED"
        }
    }
}
