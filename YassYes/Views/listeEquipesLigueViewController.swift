//
//  listeEquipesLigueViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
@available(iOS 11.0, *)


class listeEquipesLigueViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
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
        AF.request("http://localhost:3000/equipe/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                self.equipe_nom.removeAll()
                for i in myresult!.arrayValue{
                    let idL = i["_id"].stringValue
                    let nom = i["nom"].stringValue
                    let Description = i["discription"].stringValue
                    let image = "http://localhost:3000/"+i["image"].stringValue
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "EquipeCellChoix" , for:indexPath)
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


    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // *********** EDIT ***********
        let editAction = UIContextualAction(style: .destructive, title: "Add") { [self]
                    (action, sourceView, completionHandler) in
                    
            LigueService.shareinstance.addEquipeToLigue(_id: ligueIId!, equipes_ids:equipe_id[indexPath.row], completionHandler: {
                
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
            LigueService.shareinstance.addEquipeToLigue(_id: ligueIId!, ligues_id:ligue_id[indexPath.row], completionHandler: {
                
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
    
    }
 */
}
