//
//  ligueViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import AlamofireImage

class ligueViewController: UIViewController {
    
    var  ligueName:String?
    var  ligueImage:String?
    var  ligueDiscription:String?
    @IBOutlet weak var imageLigue: UIImageView!
    @IBOutlet weak var nomLigue: UILabel!
    @IBOutlet weak var descLigue: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomLigue.text = ligueName
        
        var imageUrl = ligueImage!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        imageUrl = imageUrl.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)

         let url = URL(string: imageUrl)!
        
        imageLigue.af.setImage(withURL: url)
        
        descLigue.text = ligueDiscription
        





        // Do any additional setup after loading the view.
    }
    

    @IBAction func listeEquipesBtn(_ sender: Any) {
    }
    @IBAction func listeMatchsBtn(_ sender: Any) {
    }
    @IBAction func classementBtn(_ sender: Any) {
    }
    

}
