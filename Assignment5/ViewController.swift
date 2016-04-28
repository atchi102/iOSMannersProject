//
//  ViewController.swift
//  Assignment5
//
//  Created by Abigail Atchison on 4/27/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var mannerTableView: UITableView!
    
    
    
    var manners : [Manner] = [
        Manner(info: "When asking for something say Please. \n When you recieve the item you hoped for say Thank You", name: "Saying Please and Thank You",  image:"Please and Thank You", clickedKey: "One"),
        Manner(info: "Knock on closed doors -- and wait to see if there's a response -- before entering.", name: "Closed Doors",  image:"Doors", clickedKey: "Two"),
        Manner(info: "Cover your mouth when you cough or sneeze, and don't pick your nose in public.", name: "Coughing",  image:"Coughing", clickedKey: "Three"),
        Manner(info: "If you do need to get somebody's attention right away, the phrase \"excuse me\" is the most polite way for you to enter the conversation", name: "Getting Someones Attention",  image:"Attention", clickedKey: "Four"),
        Manner(info: "Do not comment on other people's physical characteristics unless, of course, it's to compliment them, which is always welcome.", name: "Commenting on Physical Appearance", image:"Physical", clickedKey: "Five"),
        Manner(info: "Do not make fun of anyone for any reason. Teasing shows others you are weak, and ganging up on someone else is cruel.", name: "Teasing",  image:"Teasing", clickedKey: "Six"),
        Manner(info: "Don't reach for things at the table; ask to have them passed. \n Keep a napkin on your lap; use it to wipe your mouth when necessary.", name: "Table Manners",  image:"Table Manners", clickedKey: "Seven"),
        Manner(info: "When asking to borrow an item ask nicely using \"Please\". \n Once you are finished using the item return it to where you found it and thank the indivdual you borrowed it from. \n Don't use people's things without permission.", name: "Borrowing Items",  image:"Borrowing", clickedKey: "Eight")]
    
    @IBAction func SettingsClicked(sender: AnyObject) {
        let tutorialVC = self.storyboard!.instantiateViewControllerWithIdentifier("email_view")
        self.presentViewController(tutorialVC, animated: true, completion: nil)
    }
    @IBAction func SendSummaryClicked(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([userDefaults.stringForKey("email")!])
        mailComposerVC.setSubject("Manners Practice")
        mailComposerVC.setMessageBody("I have learned \(userDefaults.integerForKey("tasks")) manners!!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.mannerTableView.dataSource = self
        self.mannerTableView.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let viewTutorial = userDefaults.boolForKey("emailEntered")
        
        
        if(!viewTutorial)
        {
            let tutorialVC = self.storyboard!.instantiateViewControllerWithIdentifier("email_view")
            self.presentViewController(tutorialVC, animated: true, completion: nil)
            userDefaults.setInteger(0, forKey: "tasks")
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manners.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        let manner = self.manners[indexPath.row]
        
        let viewTutorial = userDefaults.boolForKey(manner.clickedKey)
        
        let cell = UITableViewCell()
        cell.textLabel!.text = manner.name
        if(viewTutorial)
        {
            cell.textLabel?.textColor = UIColor .greenColor()
        }
        else
        {
            cell.textLabel?.textColor = UIColor .redColor()
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(userDefaults.integerForKey("tasks")+1, forKey: "tasks")
        userDefaults.setBool(true, forKey: self.manners[indexPath.row].clickedKey)
        
        let navVC = storyboard!.instantiateViewControllerWithIdentifier("detail_view") as! UINavigationController
        
        let detailVC = navVC.viewControllers[0] as! MannerDetailViewController
        detailVC.manner = self.manners[indexPath.row]
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    
}

