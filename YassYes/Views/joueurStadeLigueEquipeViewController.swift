//
//  joueurStadeLigueEquipeViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/12/2021.
//


        import UIKit
        import Alamofire
        import AlamofireImage
        import SwiftyJSON
        @available(iOS 11.0, *)

        class joueurStadeLigueEquipeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
            var equipe_id = [String]()
            var ligueIId:String?

            var equipe_nom = [String]()
            var equipe_image = [String]()
            var equipeDescription = [String]()

            @IBOutlet weak var equipeTv: UITableView!
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
            }
            override func viewDidAppear(_ animated: Bool) {
                let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
                AF.request("http://localhost:3000/ligue/"+ligueIId!,  method: .get, headers: headers ).responseJSON{ response in
                    switch response.result{
                    case .success:
                        let myresult = try? JSON(data: response.data!)
                        let equipes : [equipeModel]
                        for singleLeagueJson in myresult!["equipes_ids"] {
                            //ligues.append(makeItem(makeItem(equipes_ids: singleLeagueJson.1)))
                            print(singleLeagueJson.1)
                       // }
                        self.equipe_nom.removeAll()
                        //for i in myresult!.arrayValue{
                            let idL = singleLeagueJson.1["_id"].stringValue
                            let nom = singleLeagueJson.1["nom"].stringValue
                            let Description = singleLeagueJson.1["discription"].stringValue
                            let image = "http://localhost:3000/"+singleLeagueJson.1["image"].stringValue
                            self.equipe_id.append(idL)
                            self.equipe_nom.append(nom)
                            self.equipe_image.append(image)
                            self.equipeDescription.append(Description)
                            

                            
                            

                        }
                        self.equipeTv.reloadData()
                        break


                        
                    case .failure:
                        print(response.error!)
                        break
                    }
                }
                
            }
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return equipe_nom.count
            }
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EquipeCellChoix11" , for:indexPath)
                let tv = cell.contentView
                let equipe_Name = tv.viewWithTag(1) as! UILabel
                let equipeImage = tv.viewWithTag(3) as! UIImageView
                equipe_Name.text = equipe_nom[indexPath.row]
                var path = String(equipe_image[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                       path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                        let url = URL(string: path)!
                        print(url)
                equipeImage.af.setImage(withURL: url)
                    return cell
            }
         
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
performSegue(withIdentifier: "listeJoueur1", sender: indexPath)

}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if  segue.identifier == "listeJoueur1"{
        let indexPath = sender as! IndexPath
        let destination = segue.destination as! joueurStadeLigueEquipeJoueurViewController
        destination.equipeIId = equipe_id[indexPath.row]

}
}


            /*
            func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                // *********** EDIT ***********
                let editAction = UIContextualAction(style: .destructive, title: "Add") { [self]
                            (action, sourceView, completionHandler) in
                            // 1. Segue to Edit view MUST PASS INDEX PATH as Sender to the prepareSegue function
                    
                    /*stadeService.shareInstence.addLigueTostade(_id: stadeIId!, ligues_id: ligue_id[indexPath.row]){ success in
                        if success {
                            self.present(Alert.makeAlert(titre: "Success", message: "ligue ajouté"),animated: true)
                        }else{
                            self.present(Alert.makeAlert(titre: "failed", message: "try again"),animated: true)

                        }
                            
                            print(self.stadeIId)
                        print(ligue_id[indexPath.row])
                            
                            
                        }*/
                    EquipeService.shareinstance.addEquipeToligue(_id: ligueIId!, equipes_ids:equipe_id[indexPath.row], completionHandler: {
                        
                        (isSuccess) in

                        if isSuccess{
                            print(equipe_id[indexPath.row])
                           print("jawek behy")

                            self.present(Alert.makeAlert(titre: "Sucsses", message: "mrigel"), animated: true)



                        } else {

                            self.present(Alert.makeAlert(titre: "Error", message: " try again"), animated: true)
                        }

                    })
                    completionHandler(true)
                }
                        editAction.backgroundColor = UIColor(red: 0/255, green: 209/255, blue: 45/255, alpha: 1.0)
                        // end action Edit
                
                // SWIPE TO LEFT CONFIGURATION
                        let swipeConfiguration = UISwipeActionsConfiguration(actions: [ editAction])
                        // Delete should not delete automatically
                        swipeConfiguration.performsFirstActionWithFullSwipe = false
                        
                        return swipeConfiguration
            
            }
        */

        
}
