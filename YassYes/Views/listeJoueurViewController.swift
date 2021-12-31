//
//  listeJoueurViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//
import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
@available(iOS 11.0, *)

class listeJoueurViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    var joueur_id = [String]()
    var joueur_nom = [String]()
    var joueur_image = [String]()
    var joueurDescription = [String]()
    var joueurTaille = [String]()
    var joueurLongueur = [String]()
    var joueurNum = [String]()
    var joueurAge = [String]()

    //var stadeIId: String?

    @IBOutlet weak var joueurTv: UITableView!
    @IBOutlet weak var joueurTV: UITableView!
    @IBOutlet weak var nomJoueur: UILabel!
    @IBOutlet weak var imageJoueur: UIImageView!
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
                self.joueurTv.reloadWithAnimation9()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "joueurI" , for:indexPath)
        
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
        performSegue(withIdentifier: "joueurProfile", sender: indexPath)


    }
   

    @IBAction func addJoueurBtn(_ sender: Any) {
        performSegue(withIdentifier: "addJoueur", sender:nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "joueurProfile"{
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! joueurViewController
            destination.joueurId = joueur_id[indexPath.row]
         }


    }
    
    

}
extension UITableView {



    func reloadWithAnimation9() {

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
