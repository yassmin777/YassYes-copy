//
//  addArbitreViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class addArbitreViewController: UIViewController,UIGestureRecognizerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var currentPhoto : UIImage?

    //@IBOutlet weak var imageArbitre: UIImageView!
    @IBOutlet weak var arbitrePhoto: UIImageView!
    @IBOutlet weak var nomArbitre: UITextField!
    @IBOutlet weak var ageArbitre: UITextField!
    @IBOutlet weak var numArbitre: UITextField!
    @IBOutlet weak var descArbitre: UITextField!
    
    @IBOutlet weak var addImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveArbitreBtn(_ sender: Any) {
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
            return
        }
        if( self.nomArbitre.text!.isEmpty ||   self.ageArbitre.text!.isEmpty ||   self.numArbitre.text!.isEmpty ||   self.descArbitre.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }
        /*if( (self.numArbitre.text!).lengthOfBytes(using: <#T##String.Encoding#>) != 8){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return

        }
        */
        let arbitred = arbitreModel(  nom: nomArbitre.text!,age: Int(ageArbitre.text!) ,num: Int(numArbitre.text!), discription: descArbitre.text!)
        ArbitreService.shareinstance.addarbitre(arbitre: arbitred, uiImage: currentPhoto!) { success in
            if success {
                self.present(Alert.makeAlert(titre: "Success", message: "Arbitre ajouté"),animated: true)
            }else{
                self.present(Alert.makeAlert(titre: "failed", message: " Arbitre exist try again"),animated: true)

            }
        }

    }
    @IBAction func changePhoto(_ sender: Any) {
    showActionSheet()
}
    func camera()
    {
        let myPickerControllerCamera = UIImagePickerController()
        myPickerControllerCamera.delegate = self
        myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
        myPickerControllerCamera.allowsEditing = true
        self.present(myPickerControllerCamera, animated: true, completion: nil)

    }
  
  
  func gallery()
  {

      let myPickerControllerGallery = UIImagePickerController()
      myPickerControllerGallery.delegate = self
      myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
      myPickerControllerGallery.allowsEditing = true
      self.present(myPickerControllerGallery, animated: true, completion: nil)

  }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            
            return
        }
        
        currentPhoto = selectedImage
        arbitrePhoto.image = selectedImage
        addImage.isHidden = true
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(){

        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)

        let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
        { action -> Void in
            self.camera()
        }
        actionSheetController.addAction(saveActionButton)

        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
        { action -> Void in
            self.gallery()
        }
        
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }


}
