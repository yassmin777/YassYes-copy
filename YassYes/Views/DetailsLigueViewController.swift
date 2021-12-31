//
//  DetailsLigueViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 13/12/2021.
//

import UIKit
import AlamofireImage

class DetailsLigueViewController: UIViewController {

    
    var ligueName: String?
    var ligueImage: String?
    var ligueDiscription: String?
    var ligueId: String?
    
    @IBOutlet weak var imageligue: UIImageView!
    @IBOutlet weak var nomligue: UILabel!
    @IBOutlet weak var descligue: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        nomligue.text = ligueName
        var imageUrl = ligueImage!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              imageUrl = imageUrl.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)

               let url = URL(string: imageUrl)!


        imageligue.af.setImage(withURL: url)
        descligue.text = ligueDiscription
    }
    @IBAction func adduneequipeaunstadeBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "addEquipeToLigue", sender: nil)

    }
    @IBAction func listeEquipeduneligue(_ sender: Any) {
        
        self.performSegue(withIdentifier: "equipeOfLigue", sender: nil)

    }
    @IBAction func listeDesM(_ sender: Any) {
        self.performSegue(withIdentifier: "listeDesMatchs", sender: nil)

    }
    @IBAction func classement(_ sender: Any) {
        self.performSegue(withIdentifier: "Classment", sender: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "addEquipeToLigue"{
           // let indexPath = sender as! IndexPath
            let destination = segue.destination as! listeEquipesLigueViewController
            destination.ligueIId = ligueId

        } else if  segue.identifier == "equipeOfLigue"{
            // let indexPath = sender as! IndexPath
             let destination = segue.destination as! EquipeOfLigueViewController
             destination.ligueIId = ligueId

         } else if  segue.identifier == "listeDesMatchs"{
             // let indexPath = sender as! IndexPath
              let destination = segue.destination as! matchsListeViewController
              destination.ligueIId = ligueId

          }else if  segue.identifier == "Classment"{
              // let indexPath = sender as! IndexPath
               let destination = segue.destination as! classementViewController
               destination.ligueIId = ligueId

           }



    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


