//
//  sessionViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 12/12/2021.
//

import UIKit

class sessionViewController: UIViewController {
    
    let token: String? = nil
    let isProprietaireDestade: String? = nil
    //let isProprietaireDestade: Bool? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    //&& (UserDefaults.standard.string(forKey: "token")  != nil)
    override func viewDidAppear(_ animated: Bool) {
        isKeyPresentInUserDefaults(key: "token")
        print(token)
    }
    
    //&& isProprietaireDestade == ""
    func isKeyPresentInUserDefaults(key: String)  {
        if UserDefaults.standard.string(forKey: "token") != nil  {
            print("1111")
            print(UserDefaults.standard.string(forKey: "isProprietaireDestade"))
            
            if token == "" {
                print("222")
                
                performSegue(withIdentifier: "LoginSegue", sender: nil)
                
                
            } else if UserDefaults.standard.string(forKey: "isProprietaireDestade") == "ProprietaireDestade" {
                print("3333")
                
                performSegue(withIdentifier: "registerSegue", sender: nil)
                
            } else if UserDefaults.standard.string(forKey: "isProprietaireDestade") == "SimpleUser" {
                print("4444")
                
                performSegue(withIdentifier: "joueurStade", sender: nil)
                
            } else {
                performSegue(withIdentifier: "LoginSegue", sender: nil)

            }
        }else{
            print("55555")
            
            performSegue(withIdentifier: "LoginSegue", sender: nil)
            
        }
        
        
        
        
    }
}

