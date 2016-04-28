//
//  EmailViewController.swift
//  Assignment5
//
//  Created by Abigail Atchison on 4/27/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isValidEmail(Str:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(Str)
    }
  
    
    @IBAction func done(sender: AnyObject) {
        
        if(isValidEmail(EmailText.text!))
        {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setBool(true, forKey: "emailEntered")
            userDefaults.setValue(EmailText.text!, forKey: "email")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
}

