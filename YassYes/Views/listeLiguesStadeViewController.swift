//
//  listeLiguesStadeViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
@available(iOS 11.0, *)

class listeLiguesStadeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    var ligue_nom = [String]()
    var ligue_image = [String]()
    var ligueDescription = [String]()

    @IBOutlet weak var ligueTv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/ligue/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                self.ligue_nom.removeAll()
                for i in myresult!.arrayValue{
                    let nom = i["nom"].stringValue
                    let Description = i["discription"].stringValue
                    let image = "http://localhost:3000/"+i["image"].stringValue
                    self.ligue_nom.append(nom)
                    self.ligue_image.append(image)
                    self.ligue_image.append(Description)
                    

                    
                    

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ligueCellChoix" , for:indexPath)
        
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


    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // *********** EDIT ***********
                let editAction = UIContextualAction(style: .destructive, title: "Add") {
                    (action, sourceView, completionHandler) in
                    // 1. Segue to Edit view MUST PASS INDEX PATH as Sender to the prepareSegue function
                    //self.performSegue(withIdentifier: "showBookEdit", sender: indexPath) // sender = indexPath
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
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
              return true
             }
    func tableView(tableView:UITableView, commit: UITableViewCell.EditingStyle, forRowAt: IndexPath){
        ligueTv.isEditing = true


    }
    editactions

*/
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if (editingStyle == .insert){
            print("jawek zeb")
        }
    }*/
    
   /* func testSegue(_ identifier: String!, sender:AnyObject!){
        performSegue(withIdentifier: identifier, sender: sender)
    }*/
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailStade"{
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! stadeViewController
            destination.stadeName = stade_nom[indexPath.row]
            destination.stadeImage = stade_image[indexPath.row]
            destination.stadeDescription = stadeDescription[indexPath.row]
            
        }
*/
}
