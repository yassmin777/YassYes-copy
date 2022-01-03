//
//  SignInViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import GoogleSignIn
import LocalAuthentication

class SignInViewController: UIViewController {
    
    let signInConfig = GIDConfiguration.init(clientID: "397497342777-fe4bo2vkv8av5k8eduune23g7dc3jga2.apps.googleusercontent.com")
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var motdepasse: UITextField!
    var adminvm = APIManger()

    
    @IBOutlet weak var photoo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        photoo.layer.borderWidth = 1
        photoo.layer.masksToBounds = true
        photoo.layer.borderColor = UIColor(red:18/255, green:19/255, blue:38/255, alpha: 1).cgColor
        photoo.layer.cornerRadius = photoo.frame.height/2
        photoo.clipsToBounds = true;

        //Style Email TestField
        email.layer.cornerRadius = 10.0
        email.layer.borderWidth = 1.0
        email.layer.masksToBounds = true
        
        //Style Password TestField
        motdepasse.layer.cornerRadius = 10.0
        motdepasse.layer.borderWidth = 1.0
        motdepasse.layer.masksToBounds = true
        initializeHideKeyboard()

    }
    @IBAction func connect(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
           guard error == nil else { return }

            let emailAddress = user?.profile?.email

           // let hasImage = user?.profile?.imageURL(withDimension: 512)
            let givenName = user?.profile?.givenName
            let familyName = user?.profile?.familyName
            
            APIManger.shareInstence.loginGoogle(nom:givenName!,prenom:familyName!,email: emailAddress!,motdepasse:"0000000"){
                (isSuccess) in
                if isSuccess{
                   self.performSegue(withIdentifier: "SeConnecter", sender: nil)
                } else {
                    self.present(Alert.makeAlert(titre: "Error", message: "Email ou mot de passe incorrect"), animated: true)
                }
            }

         }
        
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "motDePasseOublier", sender: nil)

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
                if UserDefaults.standard.string(forKey: "isProprietaireDestade")=="SimpleUser"{
                    self.performSegue(withIdentifier: "SimpleUser", sender: nil)
                    }else{self.performSegue(withIdentifier: "SeConnecter", sender: nil)}
            } else {
                self.present(Alert.makeAlert(titre: "Alert", message: "Please try again "), animated: true)
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
    
    
    
    @IBAction func touchID(_ sender: Any) {
        let localString = "Biometric Authentication"
        let context = LAContext()
           var error: NSError?

           if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
               let reason = "Identify yourself!"

               context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                   [weak self] success, authenticationError in

                   DispatchQueue.main.async {
                       if success {
                           self!.performSegue(withIdentifier: "SimpleUser", sender: IndexPath.self)
                       } else {
                           // error
                       }
                   }
               }
           } else {
               // no biometry
    }
    }
    
}
