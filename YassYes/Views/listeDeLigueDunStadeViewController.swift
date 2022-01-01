//
//  listeDeLigueDunStadeViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 13/12/2021.
//

    import UIKit
    import SwiftyJSON
    import Alamofire
    import AlamofireImage
    @available(iOS 11.0, *)

    class listeDeLigueDunStadeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
        var ligue_id = [String]()

        var ligue_nom = [String]()
        var ligue_image = [String]()
        var ligueDescription = [String]()
        var NombreDesEquipes = [Int]()
        var stadeIId: String?
        //let _id = self().stadeIId!

        @IBOutlet weak var ligueTv: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
          
        }
        override func viewDidAppear(_ animated: Bool) {
            let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
            AF.request(Host+"/stade/"+stadeIId!, method: .get, headers: headers ).responseJSON{ response in
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)

                    let ligues : [ligueModel]
                    self.ligue_nom.removeAll()
print(myresult)
                    for singleLeagueJson in myresult!["ligues_id"] {
                        //ligues.append(makeItem(makeItem(jsonItem: singleLeagueJson.1)))
                        print(singleLeagueJson.1)
                   // }
                    //for i in myresult!.arrayValue{
                        let idL = singleLeagueJson.1["_id"].stringValue
                        let nom = singleLeagueJson.1["nom"].stringValue
                        let Description = singleLeagueJson.1["discription"].stringValue
                        let nbE = singleLeagueJson.1["nbE"].intValue
                        let image = Host+"/"+singleLeagueJson.1["image"].stringValue
                        self.ligue_id.append(idL)
                        self.ligue_nom.append(nom)
                        self.ligue_image.append(image)
                        self.ligueDescription.append(Description)
                        self.NombreDesEquipes.append(nbE)
                        

                        
                        

                    }
                    self.ligueTv.reloadWithAnimation44()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ligueCelldestade" , for:indexPath)
            
            let tv = cell.contentView
            let ligue_Name = tv.viewWithTag(1) as! UILabel
            let nb_Equipe = tv.viewWithTag(10) as! UILabel
            let ligueImage = tv.viewWithTag(3) as! UIImageView
            
            
            ligue_Name.text = ligue_nom[indexPath.row]
            nb_Equipe.text = String(NombreDesEquipes[indexPath.row])


            var path = String(ligue_image[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

                   path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)



                    let url = URL(string: path)!

                   



                    print(url)


            ligueImage.af.setImage(withURL: url)

               

                    


            
                return cell
            
            
            
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        }
        
        func makeItem(jsonItem: JSON) -> ligueModel {
        //let isoDate = jsonItem["dateNaissance"]
            ligueModel(
            _id: jsonItem["_id"].stringValue,
            image: Host+"/"+jsonItem["image"].stringValue,
            nom: jsonItem["nom"].stringValue,
            discription: jsonItem["discription"].stringValue

        )
    }
    }


extension UITableView {



    func reloadWithAnimation44() {

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
