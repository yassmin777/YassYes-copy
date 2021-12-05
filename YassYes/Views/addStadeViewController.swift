//
//  addStadeViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class addStadeViewController: UIViewController {
    
    @IBOutlet weak var nomStade: UITextField!
    @IBOutlet weak var imageStade: UIImageView!
    @IBOutlet weak var descStade: UITextField!
   
    @IBOutlet weak var latitude: UITextField!
    
    @IBOutlet weak var longitude: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveStadeBtn(_ sender: Any) {
        guard let nom = self.nomStade.text else{return}
        guard let latitude = self.latitude.text else{return}
        guard let longitude = self.longitude.text else{return}
        guard let descStade = self.descStade.text else{return}
        let admin = adminModel(_id:"",nom: "", prenom: "", email: "", motdepasse: "", isProprietaireDestade: "")
        let stade = stadeModel(_id:"",admin :admin,nom: nom, lat: Double(latitude)!, lon: Double(longitude)!, discription: descStade)
        if( self.nomStade.text!.isEmpty || self.latitude.text!.isEmpty || self.longitude.text!.isEmpty || self.descStade.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }
        stadeService.shareInstence.addStade(stade: stade){
            (isSuccess) in
            if isSuccess{
                self.present(Alert.makeAlert(titre: "Alert", message: "Stade register successfully"), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Alert", message: "Please try again "), animated: true)
            }
        }


        
        
        

    }
    

}
