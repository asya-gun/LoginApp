//
//  AuthViewController.swift
//  LoginApp
//
//  Created by Asya Checkanar on 25.02.2023.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    let service = Service()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



  
    
    @IBAction func logInBtn(_ sender: Any) {
        
        guard let email = emailText.text, let password = passwordText.text, !email.isEmpty, !password.isEmpty else {
            show(message: "No data in email/password")
            return
        }
        service.logIn(email: email, password: password, completion: { isLoggedIn in
            if isLoggedIn {
                UserDefaults.standard.set(true, forKey: "isLogin")
                
                print("logged in")
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DataTVC")
                self.view.insertSubview(vc.view, at: 9)
            }
        })
    }
    
    
    @IBAction func regBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC")
        
        self.present(vc, animated: true)
        
    }
    
    func show(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default)
        
        alertVC.addAction(okBtn)
        present(alertVC, animated: true)
        
    }
    
    
    
}
