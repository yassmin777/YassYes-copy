//
//  SignUpViewController.swift
//  YassYes
//
//  Created by Mac-Mini-2021 on 13/11/2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var role: UITextField!
    @IBOutlet weak var motdepasse: UITextField!
    @IBOutlet weak var confirmermotdepasse: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    
    
    @IBAction func saveBtn(_ sender: Any) {
        if confirmermotdepasse.text != motdepasse.text{
                             self.showAlert(title: "Error", message: "Passwords don't match, please verify and try again")
                         } else {
                             
                             let admin = adminModel(nom: nom.text!, prenom: prenom.text!, email: email.text!, role: role.text!, motdepasse: motdepasse.text!
                             )
                             
                             let status = SignUpService.shareinstance.signup(admin : admin)
                             
                             if status == 201{
                                 
                                 let alert = UIAlertController(title: "Success", message: "User registred succcessfully",preferredStyle: .alert)
                                 let action = UIAlertAction(title:"ok", style: .cancel, handler: { action in self.performSegue(withIdentifier: "registersuccess", sender: self) })
                                 alert.addAction(action)
                                 self.present(alert, animated: true, completion: nil)
                                 
                             } else if status == 400 {
                                 self.showAlert(title: "Missing info !", message: "Please make sure to fill all the form and try again")
                             } else if status == 409 {
                                 let alert = UIAlertController(title: "User exists", message: "User already exists please login",preferredStyle: .alert)
                               /*  let action = UIAlertAction(title:"ok", style: .cancel, handler: { action in self.performSegue(withIdentifier: "registersuccess", sender: self) })
                                 alert.addAction(action)
                                 self.present(alert, animated: true, completion: nil)*/
                             }
                         }
                
            }


    
        func showAlert(title:String, message:String){
               let alert = UIAlertController(title: title, message: message,preferredStyle: .alert)
               let action = UIAlertAction(title:"ok", style: .cancel, handler:nil)
               alert.addAction(action)
               self.present(alert, animated: true, completion: nil)
           }

    
}
