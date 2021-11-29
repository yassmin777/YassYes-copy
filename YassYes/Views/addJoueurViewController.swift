//
//  addJoueurViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class addJoueurViewController: UIViewController {
    
    @IBOutlet weak var addImage: UIImageView!
    
    @IBOutlet weak var prenomJoueur: UITextField!
    @IBOutlet weak var nomJoueur: UITextField!
    @IBOutlet weak var ageJoueur: UITextField!
    @IBOutlet weak var longJoueur: UITextField!
    @IBOutlet weak var poidsJoueur: UITextField!
    @IBOutlet weak var numJoueur: UITextField!
    @IBOutlet weak var descJoueur: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addJoueurBtn(_ sender: Any) {
        let joueur = joueurModel(nom: nomJoueur.text!, prenom: prenomJoueur.text!,  age: ageJoueur.text!,  taille: poidsJoueur.text!,longueur: longJoueur.text!, num: numJoueur.text!, discription: descJoueur.text!)

        let status = JoueurService.shareinstance.AddJ(joueur: joueur)
        if status == 201{
                                 
                                 let alert = UIAlertController(title: "Success", message: "Joueur ajouter avec sucsses",preferredStyle: .alert)
                                 let action = UIAlertAction(title:"ok", style: .cancel, handler: { action in self.performSegue(withIdentifier: "GOOD!", sender: self) })
                                 alert.addAction(action)
                                 self.present(alert, animated: true, completion: nil)

    }
    

}
}
