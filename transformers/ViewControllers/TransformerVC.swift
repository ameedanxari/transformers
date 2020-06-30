//
//  TransformerVC.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

class TransformerVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblTransformers: UITableView!
    @IBOutlet weak var lblStatus: UILabel!
    
    var transformers = UtilManager.shared.getCachedTransformers()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setStatusLabel()
        initSession()
        registerNotifications()
    }
    
    private func setStatusLabel() {
        lblStatus.isHidden = !(transformers.count == 0)
    }
    
    private func initSession() {
        if let _ = UtilManager.shared.getToken() {
            getTransformers()
        } else {
            ServerManager.shared.getAllSparkToken() { (token, error) in
                if let token = token {
                    UtilManager.shared.saveToken(token)
                    
                    self.getTransformers()
                } else {
                    UtilManager.shared.showAlert(msg: "AllSpark is inaccessible. Functionality will be limited.")
                }
            }
        }
    }
    
    private func getTransformers() {
        ServerManager.shared.getTransformers() { [weak self] (transformers, error) in
            if let transformers = transformers {
                UtilManager.shared.saveTransformers(transformers)
                
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.reloadData()
            }
        }
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: Global.TRANSFORMERS_CHANGED, object: nil)
    }
    
    @objc func reloadData() {
        transformers = UtilManager.shared.getCachedTransformers()
        
        DispatchQueue.main.async {
            self.setStatusLabel()
            self.tblTransformers.reloadData()
        }
    }
    
    @IBAction func createTransformer(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let transformerDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "TransformerDetailVC") as! TransformerDetailVC
        navigationController?.pushViewController(transformerDetailVC, animated: true)
    }
    
    @IBAction func initiateFight(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let fightRingVC = mainStoryboard.instantiateViewController(withIdentifier: "FightRingVC") as! FightRingVC
        fightRingVC.transformers = transformers
        navigationController?.pushViewController(fightRingVC, animated: true)
    }
}

extension TransformerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransformerTVCell", for: indexPath) as! TransformerTVCell
        cell.prepareUIFor(transformer: transformers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            ServerManager.shared.deleteTransformer(transformers[indexPath.row]) { [weak self] (transformers, error) in
                if let transformers = transformers {
                    UtilManager.shared.saveTransformers(transformers)
                    
                    guard let strongSelf = self else {
                        return
                    }
                    
                    strongSelf.reloadData()
                } else if error == nil {
                    guard let strongSelf = self else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        strongSelf.transformers.remove(at: indexPath.row)
                        UtilManager.shared.saveTransformers(strongSelf.transformers)
                        strongSelf.tblTransformers.deleteRows(at: [indexPath], with: .automatic)
                    }
                } else {
                    UtilManager.shared.showAlert(msg: "Unable to delete transformer. Please try again later.")
                }
            }
        }
    }
    
}
extension TransformerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblTransformers.deselectRow(at: indexPath, animated: true)
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let transformerDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "TransformerDetailVC") as! TransformerDetailVC
        transformerDetailVC.transformer = transformers[indexPath.row]
        navigationController?.pushViewController(transformerDetailVC, animated: true)
    }
}

