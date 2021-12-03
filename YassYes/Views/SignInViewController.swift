//
//  SignInViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController ,GIDSignInUIDelegate{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var motdepasse: UITextField!
    
    let networkingService = NetworkingService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        let gSignIn = GIDSignInButton(frame: CGRect(x: 57, y: 671, width: 120, height: 70))
        view.addSubview(gSignIn)
        
        let signOut = UIButton (frame: CGRect(x: 220, y: 671, width: 120, height: 44))
        signOut.backgroundColor = UIColor.red
        signOut.setTitle("Sign out", for:  .normal)
        signOut.addTarget(self, action: #selector(self.signOut(sender:)), for: .touchUpInside)
        self.view.addSubview(signOut)
        
        // Do any additional setup after loading the view.
    }
    @objc func signOut(sender: UIButton)
    {
        print ("signOut")
        GIDSignIn.sharedInstance().signOut()
    }
    
    
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
    }
    
    @IBAction func logInBtn(_ sender: Any) {
        if(email.text!.isEmpty || motdepasse.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Vous devez taper vos identifiants"), animated: true)
            return
        }
        
        
        guard let email = self.email.text else{return}
        guard let motdepasse = self.motdepasse.text else{return}
        //let admin = adminModel(email: email, motdepasse: motdepasse)
        if(self.email.text!.isEmpty || self.motdepasse.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Vous devez taper vos identifiants"), animated: true)
            return
        }
        
        APIManger.shareInstence.login(email: email, motdepasse: motdepasse){
            (isSuccess) in
            if isSuccess{
                //self.present(Alert.makeAlert(titre: "Alert", message: "User register successfully"), animated: true)
                self.performSegue(withIdentifier: "SeConnecter", sender: nil)
            } else {
                self.present(Alert.makeAlert(titre: "Alert", message: "Please try again successfully"), animated: true)
            }
        }


    }
    
    
    
    //yassineo888@esprit.tn
    @IBAction func signUpBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "CreeCompte", sender: nil)
        
    }
    
    func testSegue(_ identifier: String!, sender:AnyObject!){
        performSegue(withIdentifier: identifier, sender: sender)
    }
    func propmt(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive , handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "SeConnecter"{
            
            let distination = segue.destination as? profileViewController
            
            /*distination.profileNom = UserDefaults.standard.string(forKey: "nom")
             distination.profilePrenom = UserDefaults.standard.string(forKey: "prenom")
             distination.profileEmail = UserDefaults.standard.string(forKey: "email")*/
            
            //let user =  adminModel(nom: <#T##String#>, prenom: <#T##String#>, email: <#T##String#>, role: <#T##String#>, motdepasse: <#T##String#>)
            
            //distination.user = user
            
            //distination.profileRole = (UserDefaults.standard.string(forKey: "roles") as? [String])?.first
            //}
            
            
            
            
            
        }
        
    }
}
