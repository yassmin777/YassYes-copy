//
//  listeEquipesViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import SwiftyJSON
import Alamofire
import MapKit
import AlamofireImage


        @available(iOS 11.0, *)

class listeEquipesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    var equipe_id = [String]()
    //var ligueIId:String?

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "EquipeCell" , for:indexPath)
        
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
        self.performSegue(withIdentifier: "detailsEquipe", sender: indexPath)


    }
    @IBAction func addjouterLigueBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "addEquipe", sender: nil)
    }

   /* func testSegue(_ identifier: String!, sender:AnyObject!){
        performSegue(withIdentifier: identifier, sender: sender)
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailsEquipe"{
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! equipeViewController
            destination.equipe_id = equipe_id[indexPath.row]
            destination.equipe_nom = equipe_nom[indexPath.row]
            destination.equipe_image = equipe_image[indexPath.row]
            destination.equipeDescription = equipeDescription[indexPath.row]

        }
    }
}
