//
//  ScoreViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 30/12/2021.
//

import UIKit

class ScoreViewController: UIViewController {

    var  equipeIdA:String?
    var  equipeNomA:String?
    var  equipeImageA:String?
    var  equipeIdB:String?
    var  equipeNomB:String?
    var  equipeImageB:String?
    @IBOutlet weak var scoreB: UITextField!
    @IBOutlet weak var scoreA: UITextField!
    @IBOutlet var nomA: UILabel!
    @IBOutlet weak var nomB: UILabel!
    @IBOutlet weak var imageB: UIImageView!
    @IBOutlet weak var imageA: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nomA.text = equipeNomA
        var imageUrl = equipeImageA!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              imageUrl = imageUrl.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)

               let url = URL(string: imageUrl)!


        imageA.af.setImage(withURL: url)
        nomB.text = equipeNomB
        var imageUrlB = equipeImageB!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              imageUrlB = imageUrlB.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)

               let urlB = URL(string: imageUrlB)!


        imageB.af.setImage(withURL: urlB)
    }
    @IBAction func ligueAddBtn(_ sender: Any) {
//        if (currentPhoto == nil){
//            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
//            return
            //}
        guard let scorea = self.scoreA.text else{return}
        guard let scoreb = self.scoreB.text else{return}

        if( self.scoreB.text!.isEmpty ||   self.scoreA.text!.isEmpty  ){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }
        if( Int(scoreA.text!) == nil || Int(scoreB.text!) == nil){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "il faut entre un numero"), animated: true)
            return
        }
        //:id
        EquipeService.shareinstance.sccore(id: equipeIdA!, score: Int(scorea)!) { success in
            if success {
                EquipeService.shareinstance.sccore(id: self.equipeIdB!, score: Int(scoreb)!) { success in
                    if success {
                        EquipeService.shareinstance.donnerDesPoint(idA: self.equipeIdA!, idB: self.equipeIdB!) { success in
                            if success {
                                //self.present(Alert.makeAlert(titre: "Success", message: "sccore ajouté"),animated: true)
                                self.present(Alert.makeActionAlert(titre: "Success", message: "sccore ajouté", action: UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in self.navigationController?.popViewController(animated: true)})),animated: true)

                                
                            }else{
                                self.present(Alert.makeAlert(titre: "failed", message: " Equipe exist try again"),animated: true)

                            }
                        }

                    }else{
                        self.present(Alert.makeAlert(titre: "failed", message: " Equipe exist try again"),animated: true)

                    }
                }
            }else{
                self.present(Alert.makeAlert(titre: "failed", message: " Equipe exist try again"),animated: true)

            }
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
