//
//  MannerDetailViewController.swift
//  Assignment5
//
//  Created by Abigail Atchison on 4/27/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//

import UIKit

class MannerDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var manner : Manner!
    
    @IBOutlet weak var mannerImage: UIImageView!
    @IBOutlet weak var mannerInfo: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = manner.name
        self.mannerInfo.text = manner.info
        mannerImage.image = UIImage(named: manner.image)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        
        let tutorialVC = self.storyboard!.instantiateViewControllerWithIdentifier("main_view")
        self.presentViewController(tutorialVC, animated: true, completion: nil)
    }
}

