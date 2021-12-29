//
//  joueurStadeLigueViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/12/2021.
//



    import UIKit
    import SwiftyJSON
    import Alamofire
    import AlamofireImage
    @available(iOS 11.0, *)

    class joueurStadeLigueViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
        var ligue_id = [String]()

        var ligue_nom = [String]()
        var ligue_image = [String]()
        var ligueDescription = [String]()
        var stadeIId: String?
        //let _id = self().stadeIId!

        @IBOutlet weak var ligueTv: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
          
        }
        override func viewDidAppear(_ animated: Bool) {
            let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
            AF.request("http://localhost:3000/stade/"+stadeIId!, method: .get, headers: headers ).responseJSON{ response in
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)

                    let ligues : [ligueModel]
                    self.ligue_id.removeAll()
                    self.ligue_nom.removeAll()
                    self.ligue_image.removeAll()
                    self.ligueDescription.removeAll()

                    for singleLeagueJson in myresult!["ligues_id"] {
                        //ligues.append(makeItem(makeItem(jsonItem: singleLeagueJson.1)))
                        print(singleLeagueJson.1)
                   // }
                    //for i in myresult!.arrayValue{
                        let idL = singleLeagueJson.1["_id"].stringValue
                        let nom = singleLeagueJson.1["nom"].stringValue
                        let Description = singleLeagueJson.1["discription"].stringValue
                        let image = "http://localhost:3000/"+singleLeagueJson.1["image"].stringValue
                        self.ligue_id.append(idL)
                        self.ligue_nom.append(nom)
                        self.ligue_image.append(image)
                        self.ligueDescription.append(Description)
                        

                        
                        

                    }
                    self.ligueTv.reloadData()
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
            return ligue_nom.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ligueCelldestade" , for:indexPath)
            
            let tv = cell.contentView
            let ligue_Name = tv.viewWithTag(1) as! UILabel
            let ligueImage = tv.viewWithTag(3) as! UIImageView
            
            
            ligue_Name.text = ligue_nom[indexPath.row]
            

            var path = String(ligue_image[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

                   path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)



                    let url = URL(string: path)!

                   



                    print(url)


            ligueImage.af.setImage(withURL: url)

               

                    


            
                return cell
            
            
            
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "lesEquipe", sender: indexPath)

 }
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if  segue.identifier == "lesEquipe"{
             let indexPath = sender as! IndexPath
             let destination = segue.destination as! joueurStadeLigueEquipeViewController
             destination.ligueIId = ligue_id[indexPath.row]

         }
        
        /*
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            // *********** EDIT ***********
            let editAction = UIContextualAction(style: .destructive, title: "Add") { [self]
                        (action, sourceView, completionHandler) in
                        // 1. Segue to Edit view MUST PASS INDEX PATH as Sender to the prepareSegue function
                /*
                stadeService.shareInstence.addLigueTostade(_id: stadeIId!, ligues_id: ligue_id[indexPath.row]){ success in
                    if success {
                        self.present(Alert.makeAlert(titre: "Success", message: "ligue ajouté"),animated: true)
                    }else{
                        self.present(Alert.makeAlert(titre: "failed", message: "try again"),animated: true)

                    }
                        
                        print(self.stadeIId)
                    print(ligue_id[indexPath.row])
                        
                        
                    }*/
                stadeService.shareInstence.addLigueTostade(_id: stadeIId!, ligues_id:ligue_id[indexPath.row], completionHandler: {
                    
                    (isSuccess) in

                    if isSuccess{
                        print(ligue_id[indexPath.row])
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
        
        }*/
        /*
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if  segue.identifier == "addLigue"{
                let indexPath = sender as! IndexPath
                let destination = segue.destination as! addligue
                destination.ligueId = ligue_id[indexPath.row]
                destination.stadeIId = stadeIId
               

            }
        }
    */
        func makeItem(jsonItem: JSON) -> ligueModel {
        //let isoDate = jsonItem["dateNaissance"]
            ligueModel(
            _id: jsonItem["_id"].stringValue,
            image: "http://localhost:3000/"+jsonItem["image"].stringValue,
            nom: jsonItem["nom"].stringValue,
            discription: jsonItem["discription"].stringValue

        )
    }
    }
    }
