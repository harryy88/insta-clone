//
//  LoginViewController.swift
//  insta
//
//  Created by Harrison Groll on 3/19/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // loginSeg
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRegister(_ sender: Any) {
        
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground( block: { (success, error) in
            if success {
                
                self.performSegue(withIdentifier: "loginSeg", sender: nil)
            } else {
                print("ERROR \(String(describing: error?.localizedDescription))")
            }
        } )
    }
    @IBAction func onLogin(_ sender: Any) {
        let user = usernameField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: user, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSeg", sender: nil)
            } else {
                print("ERROR \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
