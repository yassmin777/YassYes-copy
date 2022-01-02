//
//  listeStadeViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 04/12/2021.
//

import UIKit
import SwiftyJSON
import Alamofire
import MapKit
import AlamofireImage

class listeStadeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var stade_nom = [String]()
    var stade_id = [String]()
    var lati = [Double]()
    var longi = [Double]()
    var stade_image = [String]()
    var stadeDescription = [String]()


    var coor = [CLLocationCoordinate2D]()

    //@IBOutlet weak var map: MKMapView!
    @IBOutlet weak var tableVienStade: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request(Host+"/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                print(myresult)
                self.stade_nom.removeAll()
                self.stade_id.removeAll()
                self.lati.removeAll()
                self.longi.removeAll()
                self.stade_image.removeAll()
                self.stadeDescription.removeAll()
                self.coor.removeAll()
                for i in myresult!.arrayValue{
                    let id = i["_id"].stringValue
                    let nom = i["nom"].stringValue
                    let lat = i["lat"].doubleValue
                    let long = i["lon"].doubleValue
                    let stadeDescription = i["discription"].stringValue
                    let image = Host+"/"+i["image"].stringValue
                    self.stade_id.append(id)
                    self.stade_nom.append(nom)
                    self.lati.append(lat)
                    self.longi.append(long)
                    self.stade_image.append(image)
                    self.stadeDescription.append(stadeDescription)
                    let Coords = CLLocationCoordinate2D(latitude: lat, longitude: long)

                    self.coor.append(Coords)
                    
                    

                }
                self.tableVienStade.reloadWithAnimation6()
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
        return stade_nom.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ligueCell" , for:indexPath)
        
        let tv = cell.contentView
        let stade_Name = tv.viewWithTag(1) as! UILabel
        let mapp = tv.viewWithTag(2) as! MKMapView
        let stadeImage = tv.viewWithTag(3) as! UIImageView
        
        
        stade_Name.text = stade_nom[indexPath.row]
        mapp.setRegion(MKCoordinateRegion(center: coor[indexPath.row], span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)), animated: true)

        var path = String(stade_image[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

               path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)



                let url = URL(string: path)!

               



                print(url)


        stadeImage.af.setImage(withURL: url)

           

                


        
            return cell
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailStade", sender: indexPath)


    }
    
    @IBAction func location(_ sender: Any) {
        performSegue(withIdentifier: "mapLocation", sender: nil)

    }
    @IBAction func addjouterStadeBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "interfaceAddStade", sender: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailStade"{
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! stadeViewController
            destination.stadeId = stade_id[indexPath.row]
            destination.stadeImage = stade_image[indexPath.row]
            destination.stadeDescription = stadeDescription[indexPath.row]
            destination.stadeDescription = stadeDescription[indexPath.row]

        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // *********** EDIT ***********
        let editAction = UIContextualAction(style: .destructive, title: "Delete") { [self]
                    (action, sourceView, completionHandler) in
                    
            stadeService.shareInstence.deleteStade(_id: stade_id[indexPath.row], completionHandler: {
                
                (isSuccess) in

                if isSuccess{
                   print("jawek behy")
                    self.present(Alert.makeAlert(titre: "Sucsses", message: "Stade supprimer"), animated: true)
                    let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
                    AF.request(Host+"/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
                        switch response.result{
                        case .success:
                            let myresult = try? JSON(data: response.data!)
                            
                            self.stade_nom.removeAll()
                            self.stade_id.removeAll()
                            self.lati.removeAll()
                            self.longi.removeAll()
                            self.stade_image.removeAll()
                            self.stadeDescription.removeAll()
                            self.coor.removeAll()
                            for i in myresult!.arrayValue{
                                let id = i["_id"].stringValue
                                let nom = i["nom"].stringValue
                                let lat = i["lat"].doubleValue
                                let long = i["lon"].doubleValue
                                let stadeDescription = i["discription"].stringValue
                                let image = Host+"/"+i["image"].stringValue
                                self.stade_id.append(id)
                                self.stade_nom.append(nom)
                                self.lati.append(lat)
                                self.longi.append(long)
                                self.stade_image.append(image)
                                self.stadeDescription.append(stadeDescription)
                                let Coords = CLLocationCoordinate2D(latitude: lat, longitude: long)

                                self.coor.append(Coords)
                                
                                

                            }
                            self.tableVienStade.reloadData()
                            break


                            
                        case .failure:
                            print(response.error!)
                            break
                        }
                    }
                    



                } else {

                    self.present(Alert.makeAlert(titre: "Error", message: " try again"), animated: true)
                }

            })
            completionHandler(true)
        }
                editAction.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.5, alpha: 1)
                // end action Edit
        
        // SWIPE TO LEFT CONFIGURATION
                let swipeConfiguration = UISwipeActionsConfiguration(actions: [ editAction])
                // Delete should not delete automatically
                swipeConfiguration.performsFirstActionWithFullSwipe = false
                
                return swipeConfiguration
    
    }

}
extension UITableView {



    func reloadWithAnimation6() {

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
