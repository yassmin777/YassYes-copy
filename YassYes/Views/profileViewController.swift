//
//  profileViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/11/2021.
//

import UIKit

class profileViewController: UIViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nomP: UILabel!
    @IBOutlet weak var prenomP: UILabel!
    @IBOutlet weak var emailP: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!

    
    var user : adminModel?

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        print("hi")
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        intialiseProfile()

    }
    let _id = UserDefaults.standard.string(forKey: "_id")!

    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.setValue("", forKey: "token")
        UserDefaults.standard.setValue("", forKey: "_id")
        UserDefaults.standard.setValue("", forKey: "isProprietaireDestade")
        //UserDefaults.standard.removeObject(forKey: "isProprietaireDestade")
        performSegue(withIdentifier: "logout", sender: nil)

    }
    
    func intialiseProfile() {
        print("initializing profile")
        imageProfile.layer.borderWidth = 1
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.borderColor = UIColor(red:18/255, green:19/255, blue:38/255, alpha: 1).cgColor
        imageProfile.layer.cornerRadius = imageProfile.frame.height/2
        imageProfile.clipsToBounds = true;


        APIManger.shareInstence.getProfile(_id: _id,completionHandler: {
            isSuccess, user in
            if isSuccess{
                self.user = user
                self.nomP.text = self.user?.nom
                self.prenomP.text = self.user?.prenom
                self.emailP.text = self.user?.email
                print(user?.image!)
                //let image = "http://localhost:3000/"+(self.user?.image)!

                var imageUrl = self.user?.image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                
                imageUrl = imageUrl!.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)

                let url = URL(string: imageUrl!)
                
                self.imageProfile.af.setImage(withURL: url!)

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

    @IBAction func modifierBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "Modifier", sender: nil)

    }
    func testSegue(_ identifier: String!, sender:AnyObject!){
        performSegue(withIdentifier: identifier, sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "Modifer"{
            
            let distination = segue.destination as? updateProfileViewController
        }
            
}


    @IBOutlet weak var switchthemeBtn: UIButton!
    
    @IBAction func switchTheme(_ sender: Any) {
        let window = UIApplication.shared.keyWindow
            if #available(iOS 13.0, *) {
                if window?.overrideUserInterfaceStyle == .dark {
                   
                    switchthemeBtn.setTitle("Light mode", for: .normal)
                    window?.overrideUserInterfaceStyle = .light
                } else {
                  
                    window?.overrideUserInterfaceStyle = .dark
                    switchthemeBtn.setTitle("Dark mode", for: .normal)
                }
            }
    }
    
    
    
}
