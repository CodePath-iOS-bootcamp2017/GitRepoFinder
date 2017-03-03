//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingsPresentingViewControllerDelegate {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    @IBOutlet weak var repoResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSearchBar()
        
        self.setupTableView()
        
        // Perform the first search when the view controller first loads
        doSearch()
    }
    
    func setupSearchBar(){
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    func setupTableView(){
        //tableview delegate and datasource
        self.repoResultsTableView.dataSource = self
        self.repoResultsTableView.delegate = self
        
        //table view cell size from autolayout
        self.repoResultsTableView.estimatedRowHeight = 120
        self.repoResultsTableView.rowHeight = UITableViewAutomaticDimension
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(self.searchSettings, successCallback: { (newRepos) -> Void in

            self.repos = newRepos
            self.repoResultsTableView.reloadData()
            
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }   

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error.debugDescription)
        })
    }
    
    //implementing UITableViewDataSource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        cell.repo = self.repos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.repos == nil{
            return 0
        }else{
            return self.repos.count
        }
    }
    
    func didSaveSettings(settings: GithubRepoSearchSettings) {
        self.searchSettings = settings
        self.doSearch()
    }
    
    func didCancelSettings() {
        self.doSearch()
    }
    
    //Mark navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nc = segue.destination as! UINavigationController
        let vc = nc.topViewController as! SettingsViewController
        vc.setting = self.searchSettings
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.doSearch()
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
