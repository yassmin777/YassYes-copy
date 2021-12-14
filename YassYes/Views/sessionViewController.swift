//
//  sessionViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 12/12/2021.
//

import UIKit

class sessionViewController: UIViewController {
    
    let token: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isKeyPresentInUserDefaults(key: "token")
         print(token)
    }
    
 
    func isKeyPresentInUserDefaults(key: String)  {
        if UserDefaults.standard.string(forKey: "token") != nil {
            if token == ""{
                performSegue(withIdentifier: "LoginSegue", sender: nil)


            } else {
                performSegue(withIdentifier: "registerSegue", sender: nil)        }
        }else{
            performSegue(withIdentifier: "LoginSegue", sender: nil)

        }
        
        
    

}
}

