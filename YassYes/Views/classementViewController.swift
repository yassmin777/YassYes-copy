//
//  classementViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
@available(iOS 11.0, *)

class classementViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var ligueIId:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var equipe_id = [String]()
    var equipe_win = [Int]()
    var equipe_lose = [Int]()
    var equipe_null = [Int]()
    var equipe_point = [Int]()

    var equipe_nom = [String]()
    var equipe_image = [String]()
    var equipeDescription = [String]()

    @IBOutlet weak var matchTV: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/ligue/tri/"+ligueIId!, method: .get,headers: headers ).responseJSON{ response in
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                print(myresult)
                self.equipe_nom.removeAll()
                for i in myresult!.arrayValue{
                    let idL = i["_id"].stringValue
                    let nom = i["nom"].stringValue
                    let Description = i["discription"].stringValue
                    let win = i["win"].intValue
                    let lose = i["lose"].intValue
                    let null = i["null"].intValue
                    let point = i["point"].intValue
                    let image = "http://localhost:3000/"+i["image"].stringValue
                    self.equipe_id.append(idL)
                    self.equipe_nom.append(nom)
                    self.equipe_image.append(image)
                    self.equipeDescription.append(Description)
                    self.equipe_win.append(win)
                    self.equipe_lose.append(lose)
                    self.equipe_null.append(null)
                    self.equipe_point.append(point)


                    
                    

                }
                self.matchTV.reloadWithAnimation33()
                break


                
            case .failure:
                self.present(Alert.makeAlert(titre: "failed", message: " Nombre des equipe est insufisant"),animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "classementCell" , for:indexPath)
                let tv = cell.contentView
        let equipe_Name = tv.viewWithTag(1) as! UILabel
        let equipe_Win = tv.viewWithTag(4) as! UILabel
        let equipe_Lose = tv.viewWithTag(5) as! UILabel
        let equipe_Null = tv.viewWithTag(6) as! UILabel
        let equipe_Point = tv.viewWithTag(7) as! UILabel
        let equipeImage = tv.viewWithTag(3) as! UIImageView
        equipe_Name.text = equipe_nom[indexPath.row]
        equipe_Win.text = String(equipe_win[indexPath.row])
        equipe_Lose.text = String(equipe_lose[indexPath.row])
        equipe_Null.text = String(equipe_null[indexPath.row])
        equipe_Point.text = String(equipe_point[indexPath.row])
                var path = String(equipe_image[indexPath.row]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
               path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                let url = URL(string: path)!
                               print(url)
        equipeImage.af.setImage(withURL: url)
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }


 

}
extension UITableView {



    func reloadWithAnimation33() {

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
