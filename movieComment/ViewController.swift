//
//  ViewController.swift
//  HelloWorld
//
//  Created by Apple on 2018/9/18.
//  Copyright © 2018年 xvting. All rights reserved.  
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func exitEntry (_ seque : UIStoryboardSegue){print("exit")}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bac2.jpeg")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: Any) {
        if(nameText.text=="admin" && passwordText.text=="123")
        {
            welcomeLabel.text = "Welcome, " + nameText.text!
            self.performSegue(withIdentifier: "login", sender: self)
        }
        else if(!(nameText.text=="admin")){
            welcomeLabel.text = "Wrong name, try again"
        }
        else
        {
            welcomeLabel.text = "Wrong password, try again"
        }
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        welcomeLabel.text = "Welcome, "
        nameText.text = ""
        passwordText.text = ""
    }

}

