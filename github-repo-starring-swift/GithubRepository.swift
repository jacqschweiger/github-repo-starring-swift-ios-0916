//
//  FISGithubRepository.swift
//  github-repo-list-swift
//
//  Created by susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubRepository {
    //set up and initialization for structure of a GitHubRepository
    
    var fullName: String
    var htmlURL: URL
    var repositoryID: String

    init(dictionary: [String: Any]){
        self.fullName = dictionary["full_name"] as! String
        self.htmlURL = URL(string: (dictionary["html_url"] as! String))!
        self.repositoryID = String(dictionary["id"] as! Int)
    }

    
}
