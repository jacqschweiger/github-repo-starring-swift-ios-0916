//
//  FISReposDataStore.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    //all the data!
    
    static let sharedInstance = ReposDataStore()
    
    private init() {}
    
    var repositories: [GithubRepository]!
    
    func getRepositoriesFromAPI(completion: @escaping ()->()) {
        
        repositories = []
        
        //get dictionaries, turn into repositories, append to array of GitHubRepositories. needs completion closure bc autofill. autofill looks like this: GithubAPIClient.getRepositories(with: ([[String : AnyObject]]) -> Void)
        //retitle dictionary array argument as repo
        
        //talks to API, gets the API versions of the repositories
        GithubAPIClient.getRepositories { (repos) in
            for repo in repos {
                let newRepo = GithubRepository(dictionary: repo)
                //for each, creates instance using class so code workable
                self.repositories.append(newRepo)
                //adds repo to array
            }
            completion()
        }
    }
    
    
    func toggleStarStatus(for fullName: String, starred:@escaping (Bool)->()){
        
        GithubAPIClient.checkIfRepositoryIsStarred(fullName: fullName) { (isStarred) in
            if isStarred {
                GithubAPIClient.unstarRepository(fullName: fullName, completion: { (success) in
                    starred(false)
                })
                
            }  else {
                GithubAPIClient.starRepository(fullName: fullName, completion: { (success) in
                    starred(true)
                })
            }
        }
    }
    

    
    
}
