//
//  equipeViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class equipeViewController: UIViewController {
    
    
    var equipe_id:String?
    var equipe_nom:String?
    var equipe_image:String?
    var equipeDescription:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageequipe: UIImageView!
    @IBOutlet weak var nomequipe: UILabel!
    @IBOutlet weak var descequipe: UITextView!
   
    override func viewDidAppear(_ animated: Bool) {
        nomequipe.text = equipe_nom
        var imageUrl = equipe_image!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              imageUrl = imageUrl.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)

               let url = URL(string: imageUrl)!


        imageequipe.af.setImage(withURL: url)
        descequipe.text = equipeDescription
    }
   
    @IBAction func listeDeJoueurDuneLigue(_ sender: Any) {
        
        self.performSegue(withIdentifier: "equipeOfLigue", sender: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "listeDeJoueur"{
           // let indexPath = sender as! IndexPath
            let destination = segue.destination as! listJoueurEquipeViewController
            destination.equipeIId = equipe_id

        


    }
   

}
}
