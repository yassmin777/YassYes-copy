//
//  mapVCViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 05/12/2021.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class mapVCViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    var allStadiums = [stadeModel]()
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
            switch response.result {
            case .success:
                var stadess : [stadeModel]? = []
                for singleJsonItem in JSON(response.data!)["stadess"] {
                    stadess!.append(stadeService.shareInstence.makeItem(jsonItem: singleJsonItem.1))
                    print(stadess)
                
        stadess!.forEach { stadium in
            let anno = StadiumAnnotation(stadium)
            self.map.addAnnotation(anno)
        }
        }
        case .failure:
            print(response.error!)
            break
        
        
        
    }

   /**var stadess : [stadeModel]? = []
    for singleJsonItem in JSON(response.data!)["stadess"] {
        stadess!.append(stadeService.shareInstence.makeItem(jsonItem: singleJsonItem.1))
        print(stadess)*/

            
            
            
       
    
    }
}
        }
