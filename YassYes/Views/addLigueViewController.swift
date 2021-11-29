//
//  addLigueViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class addLigueViewController: UIViewController {
    
    
    @IBOutlet weak var nomLigue: UITextField!
    @IBOutlet weak var capaLigue: UITextField!
    @IBOutlet weak var descLigue: UITextField!
    
    @IBAction func ligueAddBtn(_ sender: Any) {
        let ligue = ligueModel(nom: nomLigue.text!, discription: descLigue.text!,liguecapacite:capaLigue.text!)

        let status = LigueService.shareinstance.AddJ(ligue:ligue)
        if status == 201{
                                 
                                 let alert = UIAlertController(title: "Success", message: "Ligue ajouter avec sucsses",preferredStyle: .alert)
                                 let action = UIAlertAction(title:"ok", style: .cancel, handler: { action in self.performSegue(withIdentifier: "GOOD!", sender: self) })
                                 alert.addAction(action)
                                 self.present(alert, animated: true, completion: nil)

       }


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
 }

  


