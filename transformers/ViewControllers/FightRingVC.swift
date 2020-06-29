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
    
    var transformers: [Transformer] = []
    var teamA: [Transformer] = []
    var teamD: [Transformer] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        setupTeamPickers()
    }
    
    private func setupTeamPickers() {
        teamA = transformers.filter{$0.team == "A"}.sorted{$0.getOverallRating() > $1.getOverallRating()}
        teamD = transformers.filter{$0.team == "D"}.sorted{$0.getOverallRating() > $1.getOverallRating()}
        
        pickerTeamA.reloadAllComponents()
        pickerTeamD.reloadAllComponents()
    }
    
    @IBAction func btnStartFightPressed(_ sender: Any) {
        print("btnStartFightPressed")
    }
}

extension FightRingVC: UIPickerViewDataSource {
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FightResultTVCell") as! FightResultTVCell
//        cell.setValuesFor(object: self.results[indexPath.row])
        return cell
    }
    
    
}
