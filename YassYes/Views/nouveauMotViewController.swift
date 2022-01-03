//
//  nouveauMotViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 03/01/2022.
//

import UIKit

class nouveauMotViewController: UIViewController {

    @IBOutlet weak var mdpN: UITextField!
    @IBOutlet weak var mdp: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let _id = UserDefaults.standard.string(forKey: "_id")!

    @IBAction func confirmer(_ sender: Any) {
        guard let mdp = self.mdpN.text else{return}
         guard let nmdp = self.mdp.text else{return}
         if( self.mdpN.text!.isEmpty || self.mdp.text!.isEmpty ){
             self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
             return
         }else
             if (!(self.mdpN.text! == self.mdp.text!)){
             performSegue(withIdentifier: "ligueDetails", sender: nil)
             return
                          }
         APIManger.shareInstence.update(_id: _id, motdepasse: mdp ,completionHandler: {
             (isSuccess) in
             if isSuccess{
                 self.performSegue(withIdentifier: "seconnect1", sender: nil)

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
