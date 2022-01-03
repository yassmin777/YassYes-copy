//
//  updateProfileViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/11/2021.
//

import UIKit

class updateProfileViewController: UIViewController {

    @IBOutlet weak var nomUP: UITextField!
    
    @IBOutlet weak var prenomUP: UITextField!
    
    @IBOutlet weak var emailUP: UITextField!
    
    @IBOutlet weak var motdepasseUP: UITextField!
    
    @IBOutlet weak var confirmerMotDePasseUP: UITextField!
    
    var user : adminModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        intialiseProfile()

    }
    let _id = UserDefaults.standard.string(forKey: "_id")!

    func intialiseProfile() {
        print("initializing profile")

        APIManger.shareInstence.getProfile(_id: _id,completionHandler: {
            isSuccess, user in
            if isSuccess{
                self.user = user
                self.nomUP.text = self.user?.nom
                self.prenomUP.text = self.user?.prenom
                self.emailUP.text = self.user?.email

            }
        })
                                           
    }
    @IBAction func updateBtn(_ sender: Any) {
       guard let nom = self.nomUP.text else{return}
        guard let prenom = self.prenomUP.text else{return}
        guard let email = self.emailUP.text else{return}
        guard let motdepasse = self.motdepasseUP.text else{return}
        //let admin = adminModel(_id:"",nom: nom, prenom: prenom, email: email, motdepasse: motdepasse,isProprietaireDestade: "")
        if( self.nomUP.text!.isEmpty || self.prenomUP.text!.isEmpty || self.emailUP.text!.isEmpty || self.motdepasseUP.text!.isEmpty || self.confirmerMotDePasseUP.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }else
            if (!(self.confirmerMotDePasseUP.text! == self.motdepasseUP.text!)){
                                         self.present(Alert.makeAlert(titre: "Error", message: "Passwords don't match, please verify and try again"), animated: true)
            return
                         }
        APIManger.shareInstence.updateProfile(_id: _id, nom: nom, prenom: prenom, email: email, motdepasse: motdepasse,completionHandler: {
            (isSuccess) in
            if isSuccess{
//                self.present(Alert.makeAlert(titre: "Alert", message: "User updated successfully"), animated: true)
                self.present(Alert.makeActionAlert(titre: "Success", message: "User updated successfully", action: UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in self.navigationController?.popViewController(animated: true)})),animated: true)

            } else {
                self.present(Alert.makeAlert(titre: "Alert", message: "Please try again "), animated: true)
            }
        })
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
