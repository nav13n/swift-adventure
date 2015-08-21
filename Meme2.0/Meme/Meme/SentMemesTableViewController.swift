//
//  SentMemesTableViewController.swift
//  Meme
//
//  Created by Naveen Pandey on 18/08/15.
//  Copyright (c) 2015 navlabs. All rights reserved.
//


import UIKit

class SentMemesTableViewController:UITableViewController{
    
    @IBOutlet weak var sentMemeTableView: UITableView!
    
    var memes:[Meme]!
    
    //MARK View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Sent Meme"
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate=(UIApplication.sharedApplication().delegate as! AppDelegate)
        self.memes=appDelegate.memes
        self.tableView.reloadData()
        
    }
    
    //MARK : TableView  delegate Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.item]
        cell.memeImageView.image=meme.image
        cell.memeDescriptionLabel.text=meme.topText
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Get MemeDetailViewController from Storyboard
        let object:AnyObject = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")!
        
        let detailVC = object as! MemeDetailViewController
        //Populate view controller with data from the selected item
        detailVC.selectedMeme = memes[indexPath.row]
        
        //Present the view controller using navigation
        navigationController!.pushViewController(detailVC, animated: true)
        
    }
    
}
    