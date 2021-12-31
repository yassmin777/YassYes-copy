//
//  detailsJoueur21ViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/12/2021.
//

import UIKit

class detailsJoueur21ViewController: UIViewController {

    var joueurId: String?
        @IBOutlet weak var ageJoueur: UILabel!
    @IBOutlet weak var longeurJoueur: UILabel!
    @IBOutlet weak var poidJoueur: UILabel!
    @IBOutlet weak var imageJoueur: UIImageView!
    
    @IBOutlet weak var discription: UITextView!
    @IBOutlet weak var numJoueur: UILabel!
    @IBOutlet weak var nomjoueur: UILabel!
    var joueur : joueurModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        intialiseProfile()

    }
    func intialiseProfile() {
        print("initializing profile")
        imageJoueur.layer.borderWidth = 1
        imageJoueur.layer.masksToBounds = true
        imageJoueur.layer.borderColor = UIColor(red:18/255, green:19/255, blue:38/255, alpha: 1).cgColor
        imageJoueur.layer.cornerRadius = imageJoueur.frame.height/2
        imageJoueur.clipsToBounds = true;


        JoueurService.shareinstance.getJoueurProfile(_id: joueurId!,completionHandler: {
            isSuccess, joueur in
            if isSuccess{
                self.joueur = joueur
                self.nomjoueur.text = self.joueur?.nom
                self.longeurJoueur.text = self.joueur?.longueur
                self.poidJoueur.text = self.joueur?.taille
                self.numJoueur.text = self.joueur?.num
                self.ageJoueur.text = self.joueur?.age
                self.discription.text = self.joueur?.discription
                //print(joueur?.image!)
                let image = "http://localhost:3000/"+(self.joueur?.image)!

                var imageUrl = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                
                imageUrl = imageUrl.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)

                let url = URL(string: imageUrl)
                print(url)
                self.imageJoueur.af.setImage(withURL: url!)

            }
        })
                                           
    }
}


