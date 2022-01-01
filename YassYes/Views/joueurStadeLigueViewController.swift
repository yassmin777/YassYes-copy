//
//  joueurStadeLigueViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/12/2021.
//



    import UIKit
    import SwiftyJSON
    import Alamofire
    import AlamofireImage
    @available(iOS 11.0, *)

    class joueurStadeLigueViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
        var ligue_id = [String]()

        @IBOutlet weak var QRImage: UIImageView!
        var ligue_nom = [String]()
        var ligue_image = [String]()
        var ligueDescription = [String]()
        var nombreDesEquipe = [Int]()
        var stadeIId: String?
        var nom1: String?
        var lat1: Double?
        var lon1: Double?
        //let _id = self().stadeIId!

        @IBOutlet weak var ligueTv: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
          
        }
        override func viewDidAppear(_ animated: Bool) {
            let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
            AF.request("http://localhost:3000/stade/"+stadeIId!, method: .get, headers: headers ).responseJSON{ response in
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)

                    let ligues : [ligueModel]
                    self.ligue_id.removeAll()
                    self.ligue_nom.removeAll()
                    self.ligue_image.removeAll()
                    self.ligueDescription.removeAll()
                    self.nombreDesEquipe.removeAll()

                    for singleLeagueJson in myresult!["ligues_id"] {
                        //ligues.append(makeItem(makeItem(jsonItem: singleLeagueJson.1)))
                        print(singleLeagueJson.1)
                   // }
                    //for i in myresult!.arrayValue{
                        let idL = singleLeagueJson.1["_id"].stringValue
                        let nom = singleLeagueJson.1["nom"].stringValue
                        let nbE = singleLeagueJson.1["nbE"].intValue
                        let Description = singleLeagueJson.1["discription"].stringValue
                        let image = "http://localhost:3000/"+singleLeagueJson.1["image"].stringValue
                        self.ligue_id.append(idL)
                        self.ligue_nom.append(nom)
                        self.ligue_image.append(image)
                        self.ligueDescription.append(Description)
                        self.nombreDesEquipe.append(nbE)


                        
                        

                    }
                    self.ligueTv.reloadWithAnimation66()
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
            let nb_equipe = tv.viewWithTag(10) as! UILabel
            let ligueImage = tv.viewWithTag(3) as! UIImageView
            
            
            ligue_Name.text = ligue_nom[indexPath.row]
            nb_equipe.text = String(nombreDesEquipe[indexPath.row])


            var path = String(ligue_image[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

                   path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)



                    let url = URL(string: path)!

                   



                    print(url)


            ligueImage.af.setImage(withURL: url)

               

                    


            
                return cell
            
            
            
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "lesEquipe", sender: indexPath)

 }
        @IBAction func generateAction(_ sender: Any) {
            let myName = nom1
            let myLat = lat1
            let myLong = lon1
            if let name = myName{
                let combinedString = "\(name)\n\(Date())est le nom de stade\(myLat!)\n\(Date())est la latitude\(myLong!)\n\(Date())est la longitude"
                QRImage.image = GenerateQRCode(Name:combinedString)
            }
        }
        func GenerateQRCode(Name:String)->UIImage?{
            let name_data = Name.data(using:String.Encoding.ascii)
            if let filter = CIFilter(name:"CIQRCodeGenerator"){
                filter.setValue(name_data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                if let output = filter.outputImage?.transformed(by: transform){
                    return UIImage(ciImage: output)
                }
            }
            return nil
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if  segue.identifier == "lesEquipe"{
                let indexPath = sender as! IndexPath
                let destination = segue.destination as! joueurStadeLigueEquipeViewController
                destination.ligueIId = ligue_id[indexPath.row]

           
            }
        
        func makeItem(jsonItem: JSON) -> ligueModel {
        //let isoDate = jsonItem["dateNaissance"]
            ligueModel(
            _id: jsonItem["_id"].stringValue,
            image: "http://localhost:3000/"+jsonItem["image"].stringValue,
            nom: jsonItem["nom"].stringValue,
            discription: jsonItem["discription"].stringValue

        )
    }
    }
    }
extension UITableView {



    func reloadWithAnimation66() {

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
