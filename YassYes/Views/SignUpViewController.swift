//
//  SignUpViewController.swift
//  YassYes
//
//  Created by Mac-Mini-2021 on 13/11/2021.
//
import UIKit

class SignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var currentPhoto : UIImage?

    @IBOutlet weak var photoUser: UIImageView!
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var isProprietaireDestade: UITextField!
    @IBOutlet weak var motdepasse: UITextField!
    @IBOutlet weak var confirmermotdepasse: UITextField!
    @IBOutlet weak var addImageButton: UIButton!

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    
    /*
    @IBAction func saveBtn(_ sender: Any) {
        
        guard let photoUser = self.photoUser.image else{return}
        guard let nom = self.nom.text else{return}
        guard let prenom = self.prenom.text else{return}
        guard let email = self.email.text else{return}
        guard let motdepasse = self.motdepasse.text else{return}
        guard let isProprietaireDestade = self.isProprietaireDestade.text else{return}
        let admin = adminModel(photo: "", _id:"",nom: nom, prenom: prenom, email: email, motdepasse: motdepasse, isProprietaireDestade: isProprietaireDestade)
        if( self.nom.text!.isEmpty || self.prenom.text!.isEmpty || self.email.text!.isEmpty || self.motdepasse.text!.isEmpty || self.isProprietaireDestade.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }else
            if (!(self.confirmermotdepasse.text! == self.motdepasse.text!)){
                                         self.present(Alert.makeAlert(titre: "Error", message: "Passwords don't match, please verify and try again"), animated: true)
            return
                         }
        APIManger.shareInstence.register(photo:photoUser,admin: admin){
            (isSuccess) in
            if isSuccess{
                self.present(Alert.makeAlert(titre: "Alert", message: "User register successfully"), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Alert", message: "Please try again "), animated: true)
            }
        }

        
        
        
        
}
     */
    
    @IBAction func validation(_ sender: UIButton) {
     
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
            return
        }
        
        let user = adminModel(  nom: nom.text, prenom: prenom.text, email: email.text, motdepasse: motdepasse.text, isProprietaireDestade: isProprietaireDestade.text)
        APIManger.shareInstence.adduser(admin: user, uiImage: currentPhoto!) { success in
            if success {
                self.present(Alert.makeAlert(titre: "Success", message: "user ajouté"),animated: true)
            }else{
                self.present(Alert.makeAlert(titre: "failer", message: "Please try again "), animated: true)
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
        photoUser.image = selectedImage
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

    
    
    
    

