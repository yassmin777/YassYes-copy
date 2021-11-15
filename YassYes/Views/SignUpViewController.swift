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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url=URL(string: "http://localhost/joueur")else{return}
        let session = URLSession.shared.dataTask(with: url){ data,response,error in
        if let error = error{
            print("there was an erorr:\(error.localizedDescription)")
        }else{
            let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
            print("the response:\(jsonRes)")
        }

        // Do any additional setup after loading the view.
        }.resume()
    
    }
    
    
    
    @IBAction func saveBtn(_ sender: Any) {
    }
    
    
}
