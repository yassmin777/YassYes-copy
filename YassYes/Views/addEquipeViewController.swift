//
//  addEquipeViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class addEquipeViewController: UIViewController {
    
    
    @IBOutlet weak var nomEquipe: UITextField!
    
    @IBOutlet weak var descEquipe: UITextField!
    
    @IBOutlet weak var capaEquipe: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ajoutEquipeBtn(_ sender: Any) {
        let equipe = equipeModel(nom: nomEquipe.text!, discription: descEquipe.text!,equipecapacite:capaEquipe.text!)

        let status = EquipeService.shareinstance.AddJ(equipe: equipe)
        if status == 201{
                                 
                                 let alert = UIAlertController(title: "Success", message: "Equipe ajouter avec sucsses",preferredStyle: .alert)
                                 let action = UIAlertAction(title:"ok", style: .cancel, handler: { action in self.performSegue(withIdentifier: "GOOD!", sender: self) })
                                 alert.addAction(action)
                                 self.present(alert, animated: true, completion: nil)

       }
    

     }
    }
    
 
