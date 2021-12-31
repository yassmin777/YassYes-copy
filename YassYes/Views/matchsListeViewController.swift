//
//  matchsListeViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 29/12/2021.
//


import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
@available(iOS 11.0, *)

class matchsListeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    var ligueIId:String?
    var equipe_idA = [String]()
    var equipe_nomA = [String]()
    var equipe_imageA = [String]()
    var equipeDescriptionA = [String]()
    
    var equipe_idB = [String]()
    var equipe_nomB = [String]()
    var equipe_imageB = [String]()
    var equipeDescriptionB = [String]()
    
    @IBOutlet weak var matchTv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/ligue/Als/"+ligueIId!,  method: .get, headers: headers ).responseJSON{ [self] response in
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                let equipes : [equipeModel]
                self.equipe_idA.removeAll()
                self.equipe_nomA.removeAll()
                self.equipe_imageA.removeAll()
                self.equipeDescriptionA.removeAll()
                self.equipe_idB.removeAll()
                self.equipe_nomB.removeAll()
                self.equipe_imageB.removeAll()
                self.equipeDescriptionB.removeAll()
                for singleLeagueJson in myresult!["equipe_A_id"] {
                    //ligues.append(makeItem(makeItem(jsonItem: singleLeagueJson.1)))
                    print(singleLeagueJson.1)
                    // }
                    //for i in myresult!.arrayValue{
                    let idL = singleLeagueJson.1["_id"].stringValue
                    let nom = singleLeagueJson.1["nom"].stringValue
                    let Description = singleLeagueJson.1["discription"].stringValue
                    let image = "http://localhost:3000/"+singleLeagueJson.1["image"].stringValue
                    self.equipe_idA.append(idL)
                    self.equipe_nomA.append(nom)
                    self.equipe_imageA.append(image)
                    self.equipeDescriptionA.append(Description)
                    
                    
                    
                    AF.request("http://localhost:3000/ligue/Bls/"+ligueIId!,  method: .get, headers: headers ).responseJSON{ response in
                        switch response.result{
                        case .success:
                            let myresult = try? JSON(data: response.data!)
                            let equipes : [equipeModel]
                            self.equipe_idB.removeAll()
                            self.equipe_nomB.removeAll()
                            self.equipe_imageB.removeAll()
                            self.equipeDescriptionB.removeAll()
                            for singleLeagueJson in myresult!["equipe_B_id"] {
                                //ligues.append(makeItem(makeItem(jsonItem: singleLeagueJson.1)))
                                print(singleLeagueJson.1)
                                // }
                                //for i in myresult!.arrayValue{
                                let idL = singleLeagueJson.1["_id"].stringValue
                                let nom = singleLeagueJson.1["nom"].stringValue
                                let Description = singleLeagueJson.1["discription"].stringValue
                                let image = "http://localhost:3000/"+singleLeagueJson.1["image"].stringValue
                                self.equipe_idB.append(idL)
                                self.equipe_nomB.append(nom)
                                self.equipe_imageB.append(image)
                                self.equipeDescriptionB.append(Description)
                                
                                
                                
                                
                                
                                
                            }
                            self.matchTv.reloadWithAnimation2()
                            break
                        case .failure:
                            print(response.error!)
                            break
                        }
                    }
                    //
                    
                    
                }
                //self.matchTv.reloadData()
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
        return equipe_nomA.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell" , for:indexPath)
        let tv = cell.contentView
        let equipe_NameA = tv.viewWithTag(1) as! UILabel
        let equipeImageA = tv.viewWithTag(2) as! UIImageView
        let equipe_NameB = tv.viewWithTag(3) as! UILabel
        let equipeImageB = tv.viewWithTag(4) as! UIImageView
        print(equipe_nomA.count)
        print(equipe_nomB.count)
        equipe_NameA.text = equipe_nomA[indexPath.row]
        var path = String(equipe_imageA[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
        let url = URL(string: path)!
        print(url)
        equipeImageA.af.setImage(withURL: url)
        equipe_NameB.text = equipe_nomB[indexPath.row]
        let pathB = String(equipe_imageB[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        path = pathB.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
        let urlB = URL(string: pathB)!
        print(url)
        equipeImageB.af.setImage(withURL: urlB)
        return cell
    }
    
    @IBAction func creationDesMatchs(_ sender: Any) {
        LigueService.shareinstance.creationDesMatches(_id: ligueIId!,completionHandler: {
            
            (isSuccess) in
            
            if isSuccess{
                print("jawek behy")
                
                self.present(Alert.makeAlert(titre: "Sucsses", message: "Matchs gérer"), animated: true)
                
                
                
            } else {
                
                self.present(Alert.makeAlert(titre: "Error", message: " Nombre des equipes est insuffisant"), animated: true)
            }
            
        })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "score", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "score"{
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! ScoreViewController
            
            destination.equipeIdA = equipe_idA[indexPath.row]
            destination.equipeNomA = equipe_nomA[indexPath.row]
            destination.equipeImageA = equipe_imageA[indexPath.row]
            destination.equipeIdB = equipe_idB[indexPath.row]
            destination.equipeNomB = equipe_nomB[indexPath.row]
            destination.equipeImageB = equipe_imageB[indexPath.row]
            //
            //}
            //}
            
            
        }
    }
}
extension UITableView {



    func reloadWithAnimation2() {

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