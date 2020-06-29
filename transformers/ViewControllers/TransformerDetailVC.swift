//
//  TransformerDetailVC.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

class TransformerDetailVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var sgmtTeam: UISegmentedControl!
    @IBOutlet weak var lblStrength: UILabel!
    @IBOutlet weak var sldStrength: UISlider!
    @IBOutlet weak var lblIntelligence: UILabel!
    @IBOutlet weak var sldIntelligence: UISlider!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var sldSpeed: UISlider!
    @IBOutlet weak var lblEndurance: UILabel!
    @IBOutlet weak var sldEndurance: UISlider!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var sldRank: UISlider!
    @IBOutlet weak var lblCourage: UILabel!
    @IBOutlet weak var sldCourage: UISlider!
    @IBOutlet weak var lblFirepower: UILabel!
    @IBOutlet weak var sldFirepower: UISlider!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var sldSkill: UISlider!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var transformer: Transformer?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        setupUI()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupUI() {
        guard let transformer = transformer else {
            return
        }
        
        lblHeading.text = "Update Transformer"
        txtName.text = transformer.name
        if transformer.team == "A" {
            sgmtTeam.selectedSegmentIndex = 0
        } else {
            sgmtTeam.selectedSegmentIndex = 1
        }
//        sldStrength.value = Float(transformer.strength)
//        lblStrength.text = "Strength (\(transformer.strength))"
//        sldIntelligence.value = Float(transformer.intelligence)
//        lblIntelligence.text = "Intelligence (\(transformer.intelligence))"
//        sldSpeed.value = Float(transformer.speed)
//        lblSpeed.text = "Speed (\(transformer.speed))"
//        sldEndurance.value = Float(transformer.endurance)
//        lblEndurance.text = "Endurance (\(transformer.endurance))"
//        sldRank.value = Float(transformer.rank)
//        lblRank.text = "Rank (\(transformer.rank))"
//        sldCourage.value = Float(transformer.courage)
//        lblCourage.text = "Courage (\(transformer.courage))"
//        sldFirepower.value = Float(transformer.firepower)
//        lblFirepower.text = "Firepower (\(transformer.firepower))"
//        sldSkill.value = Float(transformer.skill)
//        lblSkill.text = "Skill (\(transformer.skill))"
        btnSubmit.setTitle("UPDATE", for: .normal)
    }
    
    private func validateTransformer() -> Bool {
        //TODO:- add checks and show alerts
        return true
    }
    
    private func createTransformer() {
        transformer = Transformer(id: "",
                                   courage: Int(sldCourage.value),
                                   endurance: Int(sldEndurance.value),
                                   firepower: Int(sldFirepower.value),
                                   intelligence: Int(sldIntelligence.value),
                                   name: txtName.text ?? "",
                                   rank: Int(sldRank.value),
                                   skill: Int(sldSkill.value),
                                   speed: Int(sldSpeed.value),
                                   strength: Int(sldStrength.value),
                                   team: sgmtTeam.selectedSegmentIndex == 0 ? "A" : "D",
                                   team_icon: "")
        
        guard let transformer = transformer else {
            //TODO:- notify user of error
            return
        }
        
        ServerManager.shared.createTransformer(transformer) { (transformer, error) in
            if let transformer = transformer {
                //TODO:- save transformer and update UI
                UtilManager.shared.addTransformer(transformer)
                NotificationCenter.default.post(name: Global.TRANSFORMERS_CHANGED, object: nil)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                //TODO: - handle error scenario
            }
        }
    }
    
    private func updateTransformer() {
        transformer?.name = txtName.text ?? ""
        transformer?.courage = Int(sldCourage.value)
        transformer?.endurance = Int(sldEndurance.value)
        transformer?.firepower = Int(sldFirepower.value)
        transformer?.intelligence = Int(sldIntelligence.value)
        transformer?.rank = Int(sldRank.value)
        transformer?.skill = Int(sldSkill.value)
        transformer?.speed = Int(sldSpeed.value)
        transformer?.strength = Int(sldStrength.value)
        transformer?.team = sgmtTeam.selectedSegmentIndex == 0 ? "A" : "D"
        
        guard let transformer = transformer else {
            //TODO:- notify user of error
            return
        }
        
        ServerManager.shared.updateTransformer(transformer) { (transformer, error) in
            if let transformer = transformer {
                //TODO:- save transformer and update UI
                UtilManager.shared.updateTransformer(transformer)
                NotificationCenter.default.post(name: Global.TRANSFORMERS_CHANGED, object: nil)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                //TODO: - handle error scenario
            }
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        dismissKeyboard()
        
        switch sender {
        case sldStrength:
            lblStrength.text = "Strength (\(Int(sender.value)))"
        case sldIntelligence:
            lblIntelligence.text = "Intelligence (\(Int(sender.value)))"
        case sldSpeed:
            lblSpeed.text = "Speed (\(Int(sender.value)))"
        case sldEndurance:
            lblEndurance.text = "Endurance (\(Int(sender.value)))"
        case sldRank:
            lblRank.text = "Rank (\(Int(sender.value)))"
        case sldCourage:
            lblCourage.text = "Courage (\(Int(sender.value)))"
        case sldFirepower:
            lblFirepower.text = "Firepower (\(Int(sender.value)))"
        case sldSkill:
            lblSkill.text = "Skill (\(Int(sender.value)))"
        default:
            if Global.DEBUG {
                print("Invalid selection")
            }
        }
    }
    
    @IBAction func btnSubmitPressed(_ sender: Any) {
        if validateTransformer() == false {
            return
        }
        
        if transformer == nil {
            createTransformer()
        } else {
            updateTransformer()
        }
    }
}
