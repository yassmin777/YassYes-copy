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
    
    //var profileNom: String?
    //var profilePrenom: String?
    //var profileEmail : String?
    //var profileRole : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        //nomP.text = profileNom
        //prenomP.text = profilePrenom
        //emailP.text = profileEmail
        //roleP.text = profileRole
        
        // Do any additional setup after loading the view.
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
