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
        AF.request("http://localhost:3000/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                
                self.stade_nom.removeAll()
                for i in myresult!.arrayValue{
                    let id = i["_id"].stringValue
                    let nom = i["nom"].stringValue
                    let lat = i["lat"].doubleValue
                    let long = i["lon"].doubleValue
                    let stadeDescription = i["discription"].stringValue
                    let image = "http://localhost:3000/"+i["image"].stringValue
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
    
    @IBAction func addjouterStadeBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "interfaceAddStade", sender: nil)

    }
    /* func testSegue(_ identifier: String!, sender:AnyObject!){
        performSegue(withIdentifier: identifier, sender: sender)
    }*/
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
    /*
    /**let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
     AF.request("http://localhost:3000/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).response{ response in
     switch response.result{
     case .success(let data):
     do {
     let json  = try JSONSerialization.jsonObject(with: data!, options: [])
     self.stadeName.removeAll()
     for i in json!.arrayValue {
     let nom = i["nom"].stringValue
     self.stadeName.append(contentsOf: nom)
     }
     self.listeStadeViewController.reloadData()
     }
     case .failure(let err):
     print(err.localizedDescription)
     }
     }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    /* func setupCell(ligue:ligueModel,stade:stadeModel){
     print("initializing profile")
     
     stadeService.shareInstence.getAllChat(_id: _id,completionHandler: {
     isSuccess, [stade] in
     if isSuccess{
     self.stade=stade
     //self.ligue=ligue
     //self.nomLigue.text = self.ligue.nom
     self.stadeName.removeAll()
     //for (key,value) in stade as! [String: Any] {
     sta
     
     
     
     //self.nomStade.text = self.stade.nom
     }
     
     })
     }
     */
    func intialiseStade() {
        print("initializing stade")
        
        stadeService.shareInstence.getstades(_id: _id,completionHandler: {
            isSuccess, stadess in
            if isSuccess{
                self.stades = stadess!
                self.tableVienStade.reloadData()
                
            }
        })
        
        
        

        
        
        
        
        
        
    }
      */

}
