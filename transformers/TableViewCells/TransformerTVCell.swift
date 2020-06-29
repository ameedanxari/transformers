//
//  TransformerTVCell.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

class TransformerTVCell: UITableViewCell {
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverallRating: UILabel!
    @IBOutlet weak var lblStrength: UILabel!
    @IBOutlet weak var lblIntelligence: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblEndurance: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblCourage: UILabel!
    @IBOutlet weak var lblFirepower: UILabel!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var imgTeam: UIImageView!
    
    func prepareUIFor(transformer: Transformer) {
        vwBackground.backgroundColor = .white
        lblStrength.text = "\(transformer.strength)"
        lblIntelligence.text = "\(transformer.intelligence)"
        lblSpeed.text = "\(transformer.speed)"
        lblEndurance.text = "\(transformer.endurance)"
        lblRank.text = "\(transformer.rank)"
        lblCourage.text = "\(transformer.courage)"
        lblFirepower.text = "\(transformer.firepower)"
        lblSkill.text = "\(transformer.skill)"
        lblOverallRating.text = "\(transformer.getOverallRating())"
        imgTeam.setCustomImage(transformer.team_icon)
    
        if transformer.team == "A" {
            vwBackground.backgroundColor = Global.AUTOBOT_COLOR
            lblTitle.text =  "\(transformer.name) (Autobot)"
        } else if transformer.team == "D" {
            vwBackground.backgroundColor =  Global.DECEPTICON_COLOR
            lblTitle.text = "\(transformer.name) (Decepticon)"
        } else {
            vwBackground.backgroundColor =  UIColor.white
            lblTitle.text = "\(transformer.name) (Unknown)"
        }
    }
}
