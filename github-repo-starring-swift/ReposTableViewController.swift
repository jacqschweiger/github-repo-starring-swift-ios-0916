//
//  FISReposTableViewController.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    var store = ReposDataStore.sharedInstance //all the data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        
        store.getRepositoriesFromAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        
        cell.textLabel?.text = store.repositories[indexPath.row].fullName
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        store.toggleStarStatus(for: store.repositories[indexPath.row].fullName) { isStarred in
            
            let selectedRepo = self.store.repositories[indexPath.row].fullName
            if isStarred {
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(title: "Alert!", message:  "You just starred \(selectedRepo)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: (nil) ))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
            else {
                //DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert!", message:  "You just unstarred \(selectedRepo)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: (nil) ))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
}

