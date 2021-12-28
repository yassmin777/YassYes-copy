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

        
        
        
        var toyToDemand : joueurModel?
        var myToyList : [joueurModel]?
        
        var popUpChosenToy : joueurModel?=nil
        //widgets
        @IBOutlet weak var IMVToyToSwapWith: UIImageView!
        @IBOutlet weak var equipeTv: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
        }
        override func viewDidAppear(_ animated: Bool) {
            let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
            AF.request("http://localhost:3000/equipe/"+equipeIId!, method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    
                    let equipes : [equipeModel]
                    for singleLeagueJson in myresult!["equipes_ids"] {
                        //ligues.append(makeItem(makeItem(jsonItem: singleLeagueJson.1)))
                        print(singleLeagueJson.1)
                   // }
                   
                        self.joueur_nom.removeAll()
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

        }
        }
        @IBAction func BtnSelectToy(_ sender: Any) {
            performSegue(withIdentifier: "ToPopupSegue", sender: sender)
        }
        @IBAction func BtnSwapDemand(_ sender: Any) {
            if popUpChosenToy == nil {
                print("popUp field is empty")
            }else {
                var demand = Swap()
                demand.IdClient1 = clientVM.ClientToken?._id!
                demand.IdClient2 = toyToDemand?.OwnerId!
                demand.IdToy1 = popUpChosenToy?._id!
                demand.IdToy2 = toyToDemand?._id!
                demand.Confirmed = "false"
                print("demand swap begin")
                print(demand)
                print("demand swap end")
                
                SwapVM.addSwapDemand(swapDemand: demand, successHandler:{
                    print("swap demand sucess")
                } , errorHandler: {
                    print("swap demand error")
                }, noResponseHandler: {
                    print("swap demand no response")
                })
            }
            
        }

    
        func onChoose (_ data: joueurModel) -> () {
            popUpChosenToy = data
            print("chosen toy is ")
            print(popUpChosenToy!)
            
            var path = String(Constantes.host + popUpChosenToy!.Image!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
            
            let url = URL(string: path)!
            IMVToyToSwapWith.af.setImage(withURL: url)
            
        }

    

}
