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

            var nombreDeJoueur = [Int]()

            @IBOutlet weak var equipeTv: UITableView!
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
            }
            override func viewDidAppear(_ animated: Bool) {
                let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
                AF.request(Host+"/ligue/"+ligueIId!,  method: .get, headers: headers ).responseJSON{ response in
                    switch response.result{
                    case .success:
                        let myresult = try? JSON(data: response.data!)
                        let equipes : [equipeModel]
                        self.equipe_id.removeAll()
                        self.equipe_nom.removeAll()
                        self.equipe_image.removeAll()
                        self.equipeDescription.removeAll()
                        self.nombreDeJoueur.removeAll()

                        for singleLeagueJson in myresult!["equipes_ids"] {
                            //ligues.append(makeItem(makeItem(equipes_ids: singleLeagueJson.1)))
                            print(singleLeagueJson.1)
                       // }
                        //for i in myresult!.arrayValue{
                            let idL = singleLeagueJson.1["_id"].stringValue
                            let nom = singleLeagueJson.1["nom"].stringValue
                            let nbj = singleLeagueJson.1["nbJ"].intValue
                            let Description = singleLeagueJson.1["discription"].stringValue
                            let image = Host+"/"+singleLeagueJson.1["image"].stringValue
                            self.equipe_id.append(idL)
                            self.equipe_nom.append(nom)
                            self.equipe_image.append(image)
                            self.equipeDescription.append(Description)
                            self.nombreDeJoueur.append(nbj)


                            
                            

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
                let nb_de_joueur = tv.viewWithTag(10) as! UILabel
                equipe_Name.text = equipe_nom[indexPath.row]
                nb_de_joueur.text = String(nombreDeJoueur[indexPath.row])
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
        UserDefaults.standard.set(equipe_id[indexPath.row], forKey: "equipeIId3")

        destination.equipeIId1 = equipe_id[indexPath.row]
        print(equipe_id[indexPath.row])
        print(equipe_id[indexPath.row])
        print(equipe_id[indexPath.row])
        print(equipe_id[indexPath.row])
        print(equipe_id[indexPath.row])
        
}else if  segue.identifier == "classmentJoueur"{
    //let indexPath = sender as! IndexPath
    let destination = segue.destination as! classementViewController
    destination.ligueIId = ligueIId

}

}
            @IBAction func classemnetJoueur(_ sender: Any) {
                performSegue(withIdentifier: "classmentJoueur", sender: nil)

            }
            

            @IBAction func matches(_ sender: Any) {
                performSegue(withIdentifier: "matchess", sender: nil)

            }
            
        
}
extension UITableView {



    func reloadWithAnimation77() {

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
