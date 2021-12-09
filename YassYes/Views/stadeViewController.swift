//
//  stadeViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import AlamofireImage

class stadeViewController: UIViewController {
    
    
    var stadeName: String?
    var stadeImage: String?
    var stadeDescription: String?

    @IBOutlet weak var imageStade: UIImageView!
    @IBOutlet weak var nomStade: UILabel!
    @IBOutlet weak var descStade: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print(stadeImage)
        nomStade.text = stadeName
        var imageUrl = stadeImage!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              imageUrl = imageUrl.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)

               let url = URL(string: imageUrl)!


        imageStade.af.setImage(withURL: url)
        descStade.text = stadeDescription

        // Do any additional setup after loading the view.
    }
    

    @IBAction func listeLigueBtn(_ sender: Any) {
    }
    

}
