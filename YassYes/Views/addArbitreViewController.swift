//
//  addArbitreViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class addArbitreViewController: UIViewController {
    
    
    //@IBOutlet weak var imageArbitre: UIImageView!
    @IBOutlet weak var nomArbitre: UITextField!
    @IBOutlet weak var prenomArbitre: UITextField!
    @IBOutlet weak var ageArbitre: UITextField!
    @IBOutlet weak var numArbitre: UITextField!
    @IBOutlet weak var descArbitre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveArbitreBtn(_ sender: Any) {
        let arbitre = arbitreModel(nom: nomArbitre.text!, prenom: prenomArbitre.text!,age:ageArbitre.text!,num:numArbitre.text!,discription:descArbitre.text!)

        let status = ArbitreService.shareinstance.AddJ(arbitre:arbitre)
        if status == 201{
                                 
                                 let alert = UIAlertController(title: "Success", message: "arbitre ajouter avec sucsses",preferredStyle: .alert)
                                 let action = UIAlertAction(title:"ok", style: .cancel, handler: { action in self.performSegue(withIdentifier: "GOOD!", sender: self) })
                                 alert.addAction(action)
                                 self.present(alert, animated: true, completion: nil)

       }

    }
    

}
