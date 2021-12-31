//
//  popUpViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 28/12/2021.
//
    import UIKit
    import SwiftyJSON
    import Alamofire
    import AlamofireImage
    @available(iOS 11.0, *)

    class popUpViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
        var joueur_id = [String]()
        var joueur_nom = [String]()
        var joueur_image = [String]()
        var joueurDescription = [String]()
        var joueurTaille = [String]()
        var joueurLongueur = [String]()
        var joueurNum = [String]()
        var joueurAge = [String]()
        var myJoueurs : [joueurModel]?
        //variable function type specify the input and output parameters
        var onChoose : ((_ data: String) -> ())?
        //var onChoose : String?

        var equipeIId3: String?

        @IBOutlet weak var joueurTv: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
        }
        
        override func viewDidAppear(_ animated: Bool) {
            let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
            AF.request("http://localhost:3000/joueur/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
                switch response.result{
                case .success:
                    let myresult = try? JSON(data: response.data!)
                    
                    self.joueur_nom.removeAll()
                    for i in myresult!.arrayValue{
                        let idL = i["_id"].stringValue
                        let nom = i["nom"].stringValue
                        let taille = i["taille"].stringValue
                        let age = i["age"].stringValue
                        let longueur = i["longueur"].stringValue
                        let num = i["num"].stringValue
                        let Description = i["discription"].stringValue
                        let image = "http://localhost:3000/"+i["image"].stringValue
                        self.joueur_id.append(idL)
                        self.joueur_nom.append(nom)
                        self.joueur_image.append(image)
                        self.joueurDescription.append(Description)
                        self.joueurDescription.append(age)
                        self.joueurDescription.append(num)
                    }
                    self.joueurTv.reloadWithAnimation3()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "popUp" , for:indexPath)
            
            let tv = cell.contentView
            let ligue_Name = tv.viewWithTag(1) as! UILabel
            let ligueImage = tv.viewWithTag(3) as! UIImageView
            ligue_Name.text = joueur_nom[indexPath.row]
            var path = String(joueur_image[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                   path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                    let url = URL(string: path)!
                    print(url)
            ligueImage.af.setImage(withURL: url)
                return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            onChoose?( (joueur_id[indexPath.row]) )
//            //onChoose = joueur_id[indexPath.row]
//            print("toy selected from popup")
//            print((joueur_id[indexPath.row]))
            
            //dismiss(animated: true)
        }
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            // *********** EDIT ***********
            let editAction = UIContextualAction(style: .destructive, title: "Add") { [self]
                        (action, sourceView, completionHandler) in
                        print(equipeIId3)
                JoueurService.shareinstance.addJoueurToEquipe(_id:(UserDefaults.standard.string(forKey: "equipeIId3")!), joueurs_id:joueur_id[indexPath.row], completionHandler: {
                    
                    (isSuccess) in

                    if isSuccess{
                        print(joueur_id[indexPath.row])
                       print("jawek behy")

                        self.present(Alert.makeAlert(titre: "Sucsses", message: "mrigel"), animated: true)



                    } else {

                        self.present(Alert.makeAlert(titre: "Error", message: " try again"), animated: true)
                    }

                })
                completionHandler(true)
            }
                    editAction.backgroundColor = UIColor(red: 0/255, green: 209/255, blue: 45/255, alpha: 1.0)
                    // end action Edit
            
            // SWIPE TO LEFT CONFIGURATION
                    let swipeConfiguration = UISwipeActionsConfiguration(actions: [ editAction])
                    // Delete should not delete automatically
                    swipeConfiguration.performsFirstActionWithFullSwipe = false
            //dismiss(animated: true)

                    return swipeConfiguration

        
        }
        
        @IBAction func ClosePoPUp(_ sender: Any) {
            dismiss(animated: true)
        }
        

}
extension UITableView {



    func reloadWithAnimation3() {

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
