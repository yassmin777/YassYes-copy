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
    @IBOutlet weak var isProprietaireDestade: UITextField!
    @IBOutlet weak var motdepasse: UITextField!
    @IBOutlet weak var confirmermotdepasse: UITextField!
    

    let signUpService = SignUpService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    
    
    @IBAction func saveBtn(_ sender: Any) {
        
        
        guard let nom = self.nom.text else{return}
        guard let prenom = self.prenom.text else{return}
        guard let email = self.email.text else{return}
        guard let motdepasse = self.motdepasse.text else{return}
        guard let isProprietaireDestade = self.isProprietaireDestade.text else{return}
        let admin = adminModel(_id:"",nom: nom, prenom: prenom, email: email, motdepasse: motdepasse, isProprietaireDestade: isProprietaireDestade)
        if( self.nom.text!.isEmpty || self.prenom.text!.isEmpty || self.email.text!.isEmpty || self.motdepasse.text!.isEmpty || self.isProprietaireDestade.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }else
            if (!(self.confirmermotdepasse.text! == self.motdepasse.text!)){
                                         self.present(Alert.makeAlert(titre: "Error", message: "Passwords don't match, please verify and try again"), animated: true)
            return
                         }
        APIManger.shareInstence.register(admin: admin){
            (isSuccess) in
            if isSuccess{
                self.present(Alert.makeAlert(titre: "Alert", message: "User register successfully"), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Alert", message: "Please try again "), animated: true)
            }
        }


        
        
        
}
    }

