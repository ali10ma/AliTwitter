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
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        self.loadTweets()
        
        //tableView = tweet-table-view
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 150
        
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        self.loadTweets()
    }
    
    @objc func loadTweets(){
        
        numberOfTweet = 20
        
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweet]

        //Get Tweets
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
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
    
    
    
    func loadMoreTweets(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweet = numberOfTweet + 20
        let myParams = ["count": numberOfTweet]
        
        
        //Get Tweets
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            //Clear & Refresh my list
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
                                
            }
            //Update the Table
            self.tableView.reloadData()

            
        }, failure:{(Error) in print("Could Not Retrieve tweets! oh no!")
        
        
    })
        
        
    }
    
    //calls "loadMoreTweets when scrolling close to end of tweets-list"
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {  //When get end of list, run loadMoreTweets
            loadMoreTweets()
        }
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
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
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
