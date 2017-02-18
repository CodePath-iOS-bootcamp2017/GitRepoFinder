//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Satyam Jaiswal on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var languagesTableView: UITableView!
    
    @IBOutlet weak var filterSwitch: UISwitch!
    
    @IBOutlet weak var starsSlider: UISlider!
    
    let languages: [String] = ["java", "swift", "objective C", "javascript", "assembly", "python"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.languagesTableView.delegate = self
        self.languagesTableView.dataSource = self
    
        self.languagesTableView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesTableViewCell", for: indexPath) as! LanguagesTableViewCell
        cell.languageLabel.text = self.languages[indexPath.row]
        cell.tickImageView.isHidden = true
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
        case 0: RepoResultsViewController.searchSettings.java = newState
        case 1: RepoResultsViewController.searchSettings.swift = newState
        case 2: RepoResultsViewController.searchSettings.objectiveC = newState
        case 3: RepoResultsViewController.searchSettings.javascript = newState
        case 4: RepoResultsViewController.searchSettings.assembly = newState
        case 5: RepoResultsViewController.searchSettings.python = newState
        default:
            RepoResultsViewController.searchSettings.java = newState
            RepoResultsViewController.searchSettings.swift = newState
            RepoResultsViewController.searchSettings.objectiveC = newState
            RepoResultsViewController.searchSettings.javascript = newState
            RepoResultsViewController.searchSettings.assembly = newState
            RepoResultsViewController.searchSettings.python = newState
        }
    }
    @IBAction func onSwitchStateChanged(_ sender: Any) {
        if self.languagesTableView.isHidden {
           self.languagesTableView.isHidden = false
        }else{
           self.languagesTableView.isHidden = true
        }
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
