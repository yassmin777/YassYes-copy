//
//  listeLiguesViewController.swift
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

        class listeLiguesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
            var ligue_id = [String]()
            var ligue_nom = [String]()
            var ligue_image = [String]()
            var ligueDescription = [String]()
            //var stadeIId: String?

            @IBOutlet weak var ligueTv: UITableView!
            override func viewDidLoad() {
                super.viewDidLoad()
                
            }
            override func viewDidAppear(_ animated: Bool) {
                let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
                AF.request("http://localhost:3000/ligue/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
                    switch response.result{
                    case .success:
                        let myresult = try? JSON(data: response.data!)
                        
                        self.ligue_id.removeAll()
                        self.ligue_nom.removeAll()
                        self.ligue_image.removeAll()
                        self.ligueDescription.removeAll()
                        for i in myresult!.arrayValue{
                            let idL = i["_id"].stringValue
                            let nom = i["nom"].stringValue
                            let Description = i["discription"].stringValue
                            let image = "http://localhost:3000/"+i["image"].stringValue
                            self.ligue_id.append(idL)
                            self.ligue_nom.append(nom)
                            self.ligue_image.append(image)
                            self.ligueDescription.append(Description)
                            

                            
                            

                        }
                        self.ligueTv.reloadWithAnimation22()
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "ligueCellChoixChoix" , for:indexPath)
                
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
                performSegue(withIdentifier: "ligueDetails", sender: indexPath)


            }/*
            func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                // *********** EDIT ***********
                let editAction = UIContextualAction(style: .destructive, title: "Add") { [self]
                            (action, sourceView, completionHandler) in
                           
                    /*
                    stadeService.shareInstence.addLigueTostade(_id: stadeIId!, ligues_id:ligue_id[indexPath.row], completionHandler: {
                        
                        (isSuccess) in

                        if isSuccess{
                            print(ligue_id[indexPath.row])
                           print("jawek behy")

                            self.present(Alert.makeAlert(titre: "Sucsses", message: "mrigel"), animated: true)



                        } else {

                            self.present(Alert.makeAlert(titre: "Error", message: " try again"), animated: true)
                        }

                    })*/
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
            @IBAction func addjouterLigueBtn(_ sender: Any) {
                self.performSegue(withIdentifier: "addLigue1", sender: nil)
            }
        
           /* func testSegue(_ identifier: String!, sender:AnyObject!){
                performSegue(withIdentifier: identifier, sender: sender)
            }*/
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if  segue.identifier == "ligueDetails"{
                    let indexPath = sender as! IndexPath
                    let destination = segue.destination as! DetailsLigueViewController
                    destination.ligueId = ligue_id[indexPath.row]
                    destination.ligueName = ligue_nom[indexPath.row]
                    destination.ligueImage = ligue_image[indexPath.row]
                    destination.ligueDiscription = ligueDescription[indexPath.row]

                }
            }
            
        
        }
extension UITableView {



    func reloadWithAnimation22() {

        self.reloadData()

        let tableViewHeight = self.bounds.size.height

        let cells = self.visibleCells

        var delayCounter = 0

        for cell in cells {

            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)

        }

        for cell in cells {

            UIView.animate(withDuration: 0.5, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {

                cell.transform = CGAffineTransform.identity

            }, completion: nil)

            delayCounter += 1

        }

    }

}
