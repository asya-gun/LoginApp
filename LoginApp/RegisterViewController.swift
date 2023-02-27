//
//  RegisterViewController.swift
//  LoginApp
//
//  Created by Asya Checkanar on 25.02.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    let service = Service()
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

  

    @IBAction func regBtn(_ sender: Any) {
        service.registerNewUser(email: emailText.text!, password: passwordText.text!) { isReg in
            if isReg {
                self.dismiss(animated: true)
            }
        }
        
    }
    
    
    
    
    
}
