//
//  joueurStadeLigueEquipeJoueurViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/12/2021.
//


    import UIKit
    import Alamofire
    import AlamofireImage
    import SwiftyJSON
    @available(iOS 11.0, *)

    class joueurStadeLigueEquipeJoueurViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
        var joueur_id = [String]()
        var equipeIId: String?
        var joueur_nom = [String]()
        var joueur_image = [String]()
        var joueurDescription = [String]()
        var equipeIId1:String?
        var equipeIId2:String?

        
        
        
        var toyToDemand : joueurModel?
        var myToyList : [joueurModel]?
        
        var popUpChosenToy : String?=nil
        //widgets
        @IBOutlet weak var IMVToyToSwapWith: UIImageView!
        @IBOutlet weak var equipeTv: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
        }
        override func viewDidAppear(_ animated: Bool) {
            let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
            AF.request("http://localhost:3000/equipe/"+equipeIId1!, method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    print(myresult)
                    let joueurs : [joueurModel]
                    self.joueur_id.removeAll()
                    self.joueur_nom.removeAll()
                    self.joueur_image.removeAll()
                    self.joueurDescription.removeAll()

                    for singleLeagueJson in myresult!["joueurs_id"] {
                        //ligues.append(makeItem(makeItem(jsonItem: singleLeagueJson.1)))
                        print(singleLeagueJson.1)
                        print(singleLeagueJson.1["_id"])
//                        self.equipeIId2 = self.equipeIId1
                        //for i in myresult!.arrayValue{
                            let idL = singleLeagueJson.1["_id"].stringValue
                            let nom = singleLeagueJson.1["nom"].stringValue
                            let Description = singleLeagueJson.1["discription"].stringValue
                            let image = "http://localhost:3000/"+singleLeagueJson.1["image"].stringValue
                            self.joueur_id.append(idL)
                            self.joueur_nom.append(nom)
                            self.joueur_image.append(image)
                            self.joueurDescription.append(Description)

                        
                        

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
            return joueur_nom.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "joueurell" , for:indexPath)
            
            let tv = cell.contentView
            let equipe_Name = tv.viewWithTag(2) as! UILabel
            let equipeImage = tv.viewWithTag(3) as! UIImageView
            
            
            equipe_Name.text = joueur_nom[indexPath.row]
            

            var path = String(joueur_image[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

                   path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)



                    let url = URL(string: path)!

                   



                    print(url)


            equipeImage.af.setImage(withURL: url)

               

                    


            
                return cell
            
            
            
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsJoueur", sender: indexPath)

        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if  segue.identifier == "detailsJoueur"{
                let indexPath = sender as! IndexPath
                let destination = segue.destination as! detailsJoueur21ViewController
                destination.joueurId = joueur_id[indexPath.row]

        }else if segue.identifier == "popUpViewController" {
            let destination = segue.destination as! popUpViewController
            //callback onchoose function to get the selected row data
            //assign to function
            //destination.onChoose = onChoose
            destination.equipeIId3 = equipeIId2

            print("hhhhhhhhhhhhh")
            print(equipeIId1)

            
        }
        }
        @IBAction func BtnSelectToy(_ sender: Any) {
            performSegue(withIdentifier: "ToPopupSegue", sender: nil)
        }

//        func onChoose (_ data: String) -> () {
//            popUpChosenToy = data
//            print("chosen toy is ")
//            print(popUpChosenToy!)

            
//            var path = String(Constantes.host + popUpChosenToy!.Image!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            
//            path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
//            
//            let url = URL(string: path)!
//            IMVToyToSwapWith.af.setImage(withURL: url)
            
        }

//        @IBAction func BtnSwapDemand(_ sender: Any) {
//            if popUpChosenToy == nil {
//                self.present(Alert.makeAlert(titre: "Avertissemt", message: "popUp field is empty"), animated: true)
//
//            }else {
//                JoueurService.shareinstance.addJoueurToEquipe(_id: equipeIId1!, joueurs_id: popUpChosenToy!, completionHandler: {
//
//                    (isSuccess) in
//
//                    if isSuccess{
//                        print(self.popUpChosenToy)
//                       print("jawek behy")
//
//                        self.present(Alert.makeAlert(titre: "Sucsses", message: "mrigel"), animated: true)
//
//
//
//                    } else {
//
//                        self.present(Alert.makeAlert(titre: "Error", message: " try again"), animated: true)
//                    }
//
//                })
//            }
//
//        }

    

    

