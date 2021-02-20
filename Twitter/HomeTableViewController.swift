//
//  HomeTableViewController.swift
//  AliTwitter
//
//  Created by Ali Ma on 2/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBAction func LogoutButton(_ sender: Any) {
        
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        
        //
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "twittCell", for: indexPath) as! TwittCellTableViewCell
        
        
        cell.userNameLabel.text = "Some name"
        cell.twittContent.text = "Something else"
        
        return cell
        
    }
    
    
    
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //# Rows Per Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    

}
