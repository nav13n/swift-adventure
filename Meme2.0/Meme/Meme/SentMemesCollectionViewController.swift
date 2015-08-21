//
//  SentMemesCollectionViewController.swift
//  Meme
//
//  Created by Naveen Pandey on 18/08/15.
//  Copyright (c) 2015 navlabs. All rights reserved.
//


import UIKit

class SentMemesCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes:[Meme]!
    
    //MARK View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Sent Meme"
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing=space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate=(UIApplication.sharedApplication().delegate as! AppDelegate)
        self.memes=appDelegate.memes
        self.collectionView!.reloadData()
    }
    
    //MARK : CollectionView Delegate Methods
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeGridViewCell", forIndexPath: indexPath) as! MemeGridViewCell
        let meme = memes[indexPath.item]
        cell.memeImageView.image=meme.image
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        //Get MemmeDetailViewController from Storyboard
        let object:AnyObject = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")!
        
        let detailVC = object as! MemeDetailViewController
        //Populate view controller with data from the selected item
        detailVC.selectedMeme = memes[indexPath.row]
        
        //Present the view controller using navigation
        navigationController!.pushViewController(detailVC, animated: true)
    }
    
    
    
    
}
    