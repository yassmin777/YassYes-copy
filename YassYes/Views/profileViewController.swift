//
//  profileViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/11/2021.
//

import UIKit

class profileViewController: UIViewController {
    
    @IBOutlet weak var nomP: UILabel!
    @IBOutlet weak var prenomP: UILabel!
    @IBOutlet weak var emailP: UILabel!
    @IBOutlet weak var roleP: UILabel!
    
    var user : adminModel?

    
    //var profileNom: String?
    //var profilePrenom: String?
    //var profileEmail : String?
    //var profileRole : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        //nomP.text = UserDefaults.standard.string(forKey: "nom")
        //prenomP.text = UserDefaults.standard.string(forKey: "prenom")
        //emailP.text = UserDefaults.standard.string(forKey: "email")
        intialiseProfile()
        // Do any additional setup after loading the view.
    }
    let _id = UserDefaults.standard.string(forKey: "_id")!

    
    func intialiseProfile() {
        print("initializing profile")

        APIManger.shareInstence.getProfile(_id: _id,completionHandler: {
            isSuccess, user in
            if isSuccess{
                self.user = user
                self.nomP.text = self.user?.nom
                self.prenomP.text = self.user?.prenom
                self.emailP.text = self.user?.email

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

/*import Foundation
import UIKit
import FBSDKLoginKit

protocol ModalDelegate {
    func initProfileFromEdit()
}

class ProfileView: UIViewController, ModalDelegate {

    // variables
    let token = UserDefaults.standard.string(forKey: "userToken")!
    var user : User?
    
    // iboutlets
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // protocols
    func initProfileFromEdit() {
        initializeProfile()
    }
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.isEnabled = false
        passwordTF.isEnabled = false
        
        initializeProfile()
    }
    
    // methods
    func initializeProfile() {
        print("initializing profile")
        UserViewModel().getUserFromToken(userToken: token, completed: { success, result in
            if success {
                self.user = result
                self.fullNameTF.text = self.user?.fullName
                self.emailTF.text = self.user?.email
                self.phoneTF.text = self.user?.phone
                self.passwordTF.text = "**"
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not verify token"), animated: true
                )
            }
        })
    }
    
    // actions
    @IBAction func confirmChanges(_ sender: Any) {
        
        //user?.email = emailTF.text
        user?.fullName = fullNameTF.text
        user?.phone = phoneTF.text
        
        UserViewModel().editProfile(user: user!) { success in
            if success {
                let action = UIAlertAction(title: "Proceed", style: .default) { UIAlertAction in
                    self.dismiss(animated: true, completion: nil)
                }
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Profile edited successfully", action: action), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not edit your profile"), animated: true)
            }
        }
    }
}
*/
