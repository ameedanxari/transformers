//
//  FightRingVC.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

class FightRingVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var pickerTeamA: UIPickerView!
    @IBOutlet weak var pickerTeamD: UIPickerView!
    @IBOutlet weak var vwWinner: UIView!
    @IBOutlet weak var lblWinnerName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSurvivors: UILabel!
    @IBOutlet weak var tblResults: UITableView!
    
    var transformers: [Transformer] = [] {
        didSet {
           setupTeams()
        }
    }
    var teamA: [Transformer] = []
    var teamD: [Transformer] = []
    var resultsArray: [MatchResults] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        setupTeamPickers()
    }
    
    private func setupTeams() {
        teamA = transformers.filter{$0.team == "A"}.sorted{$0.getOverallRating() > $1.getOverallRating()}
        teamD = transformers.filter{$0.team == "D"}.sorted{$0.getOverallRating() > $1.getOverallRating()}
    }
    
    private func setupTeamPickers() {
        pickerTeamA.reloadAllComponents()
        pickerTeamD.reloadAllComponents()
    }
    
    @IBAction func btnStartFightPressed(_ sender: Any) {
        if let sender = sender as? UIButton {
            sender.setTitle("BATTLE IN PROGRESS...", for: .normal)
            sender.isUserInteractionEnabled = false
        }
        
        showBattleStats(getFightResults(), sender: sender)
    }
    
    func getFightResults() -> BattleStats {
        resultsArray = []
        let fights = getMaxFightCount()
        
        for i in 0..<fights {
            pickerTeamA?.selectRow(i, inComponent: 0, animated: true)
            pickerTeamD?.selectRow(i, inComponent: 0, animated: true)
            
            lblWinnerName?.text = "\(i+1)"
            lblStatus?.text = "Battle"
            
            if let matchResult = initiateFightBetween(autobot: teamA[i], decepticon: teamD[i]) {
                resultsArray.append(matchResult)
                tblResults?.reloadData()
            } else {
                return totalAnnihilation()
            }
        }
        
        return getBattleStats()
    }
    
    func getMaxFightCount() -> Int {
        return teamA.count > teamD.count ? teamD.count : teamA.count
    }
    
    private func initiateFightBetween(autobot: Transformer, decepticon: Transformer) -> MatchResults? {
        //Any Transformer named Optimus Prime or Predaking wins his fight automatically regardless of any other criteria
        var isTheAutobot = false
        if autobot.name.lowercased() == "Optimus Prime".lowercased() ||
            autobot.name.lowercased() == "Predaking".lowercased() {
            isTheAutobot = true
        }
        
        var isTheDecepticon = false
        if decepticon.name.lowercased() == "Optimus Prime".lowercased() ||
            decepticon.name.lowercased() == "Predaking".lowercased() {
            isTheDecepticon = true
        }
        //In the event either of the above face each other (or a duplicate of each other), the game immediately ends with all competitors destroyed
        if isTheAutobot && isTheDecepticon {
            return nil //total annihilation
        }
        if isTheAutobot {
            return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: true)
        }
        if isTheDecepticon {
            return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: false)
        }
        
        //If any fighter is down 4 or more points of courage and 3 or more points of strength compared to their opponent, the opponent automatically wins the face-off regardless of overall rating (opponent has ran away)
        if autobot.courage - decepticon.courage >= 4 &&
            autobot.strength - decepticon.strength >= 3 {
            return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: true)
        }
        if decepticon.courage - autobot.courage >= 4 &&
            decepticon.strength - autobot.strength >= 3 {
            return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: false)
        }
        
        //Otherwise, if one of the fighters is 3 or more points of skill above their opponent, they win the fight regardless of overall rating
        if autobot.skill - decepticon.skill >= 3 {
            return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: true)
        }
        if decepticon.skill - autobot.skill >= 3 {
            return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: false)
        }
        
        //The winner is the Transformer with the highest overall rating
        if autobot.getOverallRating() > decepticon.getOverallRating() {
            return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: true)
        }
        if decepticon.getOverallRating() > autobot.getOverallRating() {
            return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: false)
        }
        
        //In the event of a tie, both Transformers are considered destroyed
        return MatchResults(autobot: autobot, decepticon: decepticon, isAutobotWinner: nil)
    }
    
    private func totalAnnihilation() -> BattleStats {
        var autobotWins = 0
        var decepticonWins = 0
        
        for result in resultsArray {
            if result.isAutobotWinner == true {
                autobotWins += 1
            }
            else if result.isAutobotWinner == false {
                decepticonWins += 1
            }
        }
        
        return BattleStats(autobotWins: autobotWins,
                           decepticonWins: decepticonWins,
                           survivorsText: "No survivors...",
                           resultTitle: "TOTAL ANNIHILATION")
    }
    
    private func getBattleStats() -> BattleStats {
        var autobotWins = 0
        var autobotSurvivors = ""
        var decepticonWins = 0
        var decepticonSurvivors = ""
        
        for result in resultsArray {
            if result.isAutobotWinner == true {
                autobotWins += 1
                autobotSurvivors += ", \(result.autobot.name)"
            }
            else if result.isAutobotWinner == false {
                decepticonWins += 1
                decepticonSurvivors += ", \(result.decepticon.name)"
            }
        }
        
        if teamA.count > teamD.count {
            for i in resultsArray.count ..< teamA.count {
                autobotSurvivors += ", \(teamA[i].name)"
            }
        }
        else if teamD.count > teamA.count {
            for i in resultsArray.count ..< teamD.count {
                decepticonSurvivors += ", \(teamD[i].name)"
            }
        }
        
        autobotSurvivors = String(autobotSurvivors.dropFirst(2))
        decepticonSurvivors = String(decepticonSurvivors.dropFirst(2))
        
        if teamA.count == 0 || teamD.count == 0 {
            return BattleStats(autobotWins: autobotWins,
                    decepticonWins: decepticonWins,
                    survivorsText: "Autobot Survivors: \(autobotSurvivors)\nDecepticon Survivors: \(decepticonSurvivors)",
            resultTitle: "NO OPPONENTS")
        } else if autobotWins > decepticonWins {
            return BattleStats(autobotWins: autobotWins,
                        decepticonWins: decepticonWins,
                        survivorsText: "Winning team (Autobots): \(autobotSurvivors)\nSurvivors from the losing team (Decepticons): \(decepticonSurvivors)",
                resultTitle: "AUTOBOTS WIN!")
        } else if decepticonWins > autobotWins {
            return BattleStats(autobotWins: autobotWins,
                    decepticonWins: decepticonWins,
                    survivorsText: "Winning team (Decepticons): \(decepticonSurvivors)\nSurvivors from the losing team (Autobots): \(autobotSurvivors)",
            resultTitle: "DECEPTICONS WIN!")
        }
        return BattleStats(autobotWins: autobotWins,
                decepticonWins: decepticonWins,
                survivorsText: "Autobot Survivors: \(autobotSurvivors)\nDecepticon Survivors: \(decepticonSurvivors)",
        resultTitle: "BATTLE TIED!")
    }
    
    private func showBattleStats(_ stats: BattleStats, sender: Any) {
        if let sender = sender as? UIButton {
            sender.setTitle(stats.resultTitle, for: .normal)
        }
        
        lblSurvivors.text = stats.survivorsText
    }
}

extension FightRingVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == pickerTeamA ? teamA.count : teamD.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == pickerTeamA ? teamA[row].name : teamD[row].name
    }
}

extension FightRingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FightResultTVCell") as! FightResultTVCell
        cell.prepareUIFor(matchResult: self.resultsArray[indexPath.row])
        return cell
    }
    
    
}
