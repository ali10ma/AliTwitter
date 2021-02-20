//
//  HomeTableViewController.swift
//  AliTwitter
//
//  Created by Ali Ma on 2/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    //when program runs the first time, we're running the "loadTweet"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        loadTweet()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
    }
    
    @objc func loadTweet(){
        
        let mUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 20]

        //Get Tweets
        TwitterAPICaller.client?.getDictionariesRequest(url: mUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            //Clear & Refresh my list
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
                                
            }
            //Update the Table
            self.tableView.reloadData()
            
            //End Refreshing
            self.myRefreshControl.endRefreshing()

            
        }, failure:{(Error) in print("Could Not Retrieve tweets! oh no!")
        
        
    })
    }
    
    
    @IBAction func LogoutButton(_ sender: Any) {
        
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        
        //
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }

    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "twittCell", for: indexPath) as! TwittCellTableViewCell
        
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        
        cell.userNameLabel.text = user["name"] as? String
        cell.twittContent.text = tweetArray[indexPath.row]["text"] as? String
        
        //Set Up Image:
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        
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
        return tweetArray.count //Returns whatever available tweets
    }

    

}
