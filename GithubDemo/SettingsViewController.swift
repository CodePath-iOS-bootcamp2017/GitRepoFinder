//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Satyam Jaiswal on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var languagesTableView: UITableView!
    
    @IBOutlet weak var filterSwitch: UISwitch!
    
    @IBOutlet weak var starsSlider: UISlider!
    
    @IBOutlet weak var minStarsLabel: UILabel!
    
    
    let languages = ["java", "swift", "objective C", "javascript", "assembly", "python"]
    
    var setting:GithubRepoSearchSettings?
    
    weak var delegate: SettingsPresentingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLanguageTableView()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        if let minStars = self.setting?.minStars{
            self.starsSlider.value = Float(minStars)
            self.minStarsLabel.text = "\(minStars)"
        }
        
        if let languageFilterState = self.setting?.searchByLanguage{
            self.filterSwitch.isOn = languageFilterState
        }else{
            self.filterSwitch.isOn = false
        }
        
        self.languagesTableView.reloadData()
    }
    
    func setupLanguageTableView(){
        self.languagesTableView.delegate = self
        self.languagesTableView.dataSource = self
        self.languagesTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesTableViewCell", for: indexPath) as! LanguagesTableViewCell
        cell.languageLabel.text = self.languages[indexPath.row]
        //        ["java", "swift", "objective C", "javascript", "assembly", "python"]
        var cellState = false
        switch(indexPath.row){
            case 0:
                if let state = self.setting?.java{
                    cellState = state
                }
            case 1:
                if let state = self.setting?.java{
                    cellState = state
                }
            case 2:
                if let state = self.setting?.java{
                    cellState = state
                }
            case 3:
                if let state = self.setting?.java{
                    cellState = state
                }
            case 4:
                if let state = self.setting?.java{
                    cellState = state
                }
            case 5:
                if let state = self.setting?.java{
                    cellState = state
                }
            default:
                cellState = false
        }
        
        if cellState{
            cell.tickImageView.isHidden = false
        }else{
            cell.tickImageView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LanguagesTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        var newState: Bool
        if cell.tickImageView.isHidden{
           cell.tickImageView.isHidden = false
           newState = true
        }else{
           cell.tickImageView.isHidden = true
           newState = false
        }
        
        switch(indexPath.row){
        case 0: self.setting?.java = newState
        case 1: self.setting?.swift = newState
        case 2: self.setting?.objectiveC = newState
        case 3: self.setting?.javascript = newState
        case 4: self.setting?.assembly = newState
        case 5: self.setting?.python = newState
        default:
            self.setting?.java = newState
            self.setting?.swift = newState
            self.setting?.objectiveC = newState
            self.setting?.javascript = newState
            self.setting?.assembly = newState
            self.setting?.python = newState
        }
    }
    
    @IBAction func onSwitchStateChanged(_ sender: Any) {
        if self.filterSwitch.isOn{
            self.languagesTableView.isHidden = false
            self.setting?.searchByLanguage = true
        }else{
            self.languagesTableView.isHidden = true
            self.setting?.searchByLanguage = false
        }
    }
    
    @IBAction func onStarFilterChanged(_ sender: Any) {
        self.minStarsLabel.text = "\(Int(self.starsSlider.value))"
        self.setting?.minStars = Int(self.starsSlider.value)
    }
    
    @IBAction func onSaveTapped(_ sender: Any) {
        self.delegate?.didSaveSettings(settings: self.setting!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCanelTapped(_ sender: Any) {
        self.delegate?.didCancelSettings()
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
