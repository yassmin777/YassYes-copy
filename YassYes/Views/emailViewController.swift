//
//  emailViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 03/01/2022.
//

import UIKit

class emailViewController: UIViewController {

    @IBOutlet weak var emailM: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailM.layer.cornerRadius = 10.0
        emailM.layer.borderWidth = 1.0
        emailM.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func recevoirUnCode(_ sender: Any) {
        guard self.emailM.text != nil else{return}
        if( self.emailM.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }

        APIManger.shareInstence.motDePasseOublier(email: emailM.text!, completionHandler: {
            (isSuccess) in
            if isSuccess{
                self.performSegue(withIdentifier: "codeMotDePasse", sender: nil)
            }else{                    self.present(Alert.makeAlert(titre: "Error", message: "Email incorrect"), animated: true)
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
