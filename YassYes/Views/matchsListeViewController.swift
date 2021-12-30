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
            AF.request("http://localhost:3000/ligue/Als/"+ligueIId!,  method: .get, headers: headers ).responseJSON{ response in
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    let equipes : [equipeModel]
                    self.equipe_idA.removeAll()
                    self.equipe_nomA.removeAll()
                    self.equipe_imageA.removeAll()
                    self.equipeDescriptionA.removeAll()
print(myresult)
                    for singleLeagueJson in myresult!.arrayValue {
                        //ligues.append(makeItem(makeItem(equipes_ids: singleLeagueJson.1)))
                   print(singleLeagueJson)
                    //for i in myresult!.arrayValue{
                        let idLa = singleLeagueJson["_id"].stringValue
                        let noma = singleLeagueJson["nom"].stringValue
                        let Descriptiona = singleLeagueJson["discription"].stringValue
                        let imagea = "http://localhost:3000/"+singleLeagueJson["image"].stringValue
                        self.equipe_idA.append(idLa)
                        self.equipe_nomA.append(noma)
                        self.equipe_imageA.append(imagea)
                        self.equipeDescriptionA.append(Descriptiona)





                    }
                    self.matchTv.reloadData()
                    break



                case .failure:
                    print(response.error!)
                    break
                }
            }
            AF.request("http://localhost:3000/ligue/Bls/"+ligueIId!,  method: .get, headers: headers ).responseJSON{ response in
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    let equipes : [equipeModel]
                  self.equipe_idB.removeAll()
                   self.equipe_nomB.removeAll()
                   self.equipe_imageB.removeAll()
                    self.equipeDescriptionB.removeAll()
                    for singleLeagueJson in myresult!.arrayValue {
                        //ligues.append(makeItem(makeItem(equipes_ids: singleLeagueJson.1)))
                        print(singleLeagueJson)
                   // }
                    for i in singleLeagueJson["equipe_A_id"]{
                        let idL = i.1["_id"].stringValue
                        let nom = i.1["nom"].stringValue
                        let Description = i.1["discription"].stringValue
                        let image = "http://localhost:3000/"+i.1["image"].stringValue
                        self.equipe_idB.append(idL)
                        self.equipe_nomB.append(nom)
                        self.equipe_imageB.append(image)
                        self.equipeDescriptionB.append(Description)


                    }


                    }
                    self.matchTv.reloadData()
                    break



                case .failure:
                    print(response.error!)
                    break
                }
            }
//
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
            print(equipe_NameA)
            equipe_NameA.text = equipe_nomA[indexPath.row]
            var path = String(equipe_imageA[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                   path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                    let url = URL(string: path)!
                    print(url)
            equipeImageA.af.setImage(withURL: url)
//            equipe_NameB.text = equipe_nomB[indexPath.row]
//            var pathB = String(equipe_imageB[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//                   path = pathB.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
//                    let urlB = URL(string: pathB)!
//                    print(url)
//            equipeImageB.af.setImage(withURL: urlB)
                return cell
        }
     
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//performSegue(withIdentifier: "listeJoueur1", sender: indexPath)

}
        
        @IBAction func creationDesMatchs(_ sender: Any) {
            LigueService.shareinstance.creationDesMatches(_id: ligueIId!,completionHandler: {
                
                (isSuccess) in

                if isSuccess{
                   print("jawek behy")

                    self.present(Alert.makeAlert(titre: "Sucsses", message: "mrigel"), animated: true)



                } else {

                    self.present(Alert.makeAlert(titre: "Error", message: " try again"), animated: true)
                }

            })
        }
        
//
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//if  segue.identifier == "listeJoueur1"{
//    let indexPath = sender as! IndexPath
//    let destination = segue.destination as! joueurStadeLigueEquipeJoueurViewController
//    UserDefaults.standard.set(equipe_id[indexPath.row], forKey: "equipeIId3")
//
//    destination.equipeIId1 = equipe_id[indexPath.row]
//    print(equipe_id[indexPath.row])
//    print(equipe_id[indexPath.row])
//    print(equipe_id[indexPath.row])
//    print(equipe_id[indexPath.row])
//    print(equipe_id[indexPath.row])
//
//}
//}
        
        
}
