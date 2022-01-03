//
//  addLigueViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class addLigueViewController: UIViewController,UIGestureRecognizerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    var currentPhoto : UIImage?

    @IBOutlet weak var liguePhoto: UIImageView!

    @IBOutlet weak var nomLigue: UITextField!
    @IBOutlet weak var descLigue: UITextField!
    
    @IBOutlet weak var addImageButton: UIButton!

    
    @IBAction func ligueAddBtn(_ sender: Any) {
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
            return
        }
        if( self.nomLigue.text!.isEmpty ||   self.descLigue.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }
        
        let ligued = ligueModel(  nom: nomLigue.text!, discription: descLigue.text!)
        LigueService.shareinstance.addligue(ligue: ligued, uiImage: currentPhoto!) { success in
            if success {
//                self.present(Alert.makeAlert(titre: "Success", message: "equipe ajouté"),animated: true)
                self.present(Alert.makeActionAlert(titre: "Success", message: "Ligue ajouté", action: UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in self.navigationController?.popViewController(animated: true)})),animated: true)

            }else{
                self.present(Alert.makeAlert(titre: "failed", message: " Ligue exist déja again"),animated: true)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()

        // Do any additional setup after loading the view.
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
        liguePhoto.image = selectedImage
        addImageButton.isHidden = true
        
        
        
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

  


