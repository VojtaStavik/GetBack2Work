//
//  ViewController.swift
//  GetBack2Work
//
//  Created by Vojta Stavik on 30/07/15.
//  Copyright (c) 2015 STRV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static var userName: String = ""
    
    lazy var alertController : UIAlertController = {

            let alertController = UIAlertController(title: "Enter your e-mail", message: "E-mail is used as your unique identifier.", preferredStyle: .Alert)
        
        
            alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
                
                textField.placeholder = "E-mail"
            }
        
        
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { [weak self] (action) -> Void in
                
                if let textField = alertController.textFields?.first as? UITextField where textField.text.isEmpty == false {
                    
                    ViewController.userName = textField.text
                    UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: (.Badge | .Sound | .Alert), categories: nil))
                
                } else {
                    
                    self?.statusLabel.text = "You have to enter your e-mail."
                    self?.showStatusLabel()
                }
            }))

        
            return alertController
            
        }()
    
    
    @IBOutlet weak var statusLabel: UILabel! {
        
        didSet { statusLabel.alpha = 0 }
    }
    
    
    override func viewDidLoad() {
        
        NSNotificationCenter.defaultCenter().addObserverForName(Notifications.NotificationsRegistrationError, object: nil, queue: nil) {[weak self] (notification) -> Void in
            
            self?.statusLabel.text = "Some error happened ..."
            self?.showStatusLabel()
        }

    
        NSNotificationCenter.defaultCenter().addObserverForName(Notifications.NotificationsRegistrationSuccessfull, object: nil, queue: nil) {[weak self] (notification) -> Void in

            self?.statusLabel.text = "Status: Ready!"
            self?.showStatusLabel()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        showAlertController()
    }
    
    
    @IBAction func handleTap(sender: AnyObject) {
        
        showAlertController()
    }
    
    
    func showAlertController() {
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func showStatusLabel() {
        
        UIView.animateWithDuration(0.33, animations: { () -> Void in
            
            self.statusLabel.alpha = 1
        })
    }
}

