//
//  addJoueurViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class addJoueurViewController: UIViewController,UIGestureRecognizerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var currentPhoto : UIImage?

    @IBOutlet weak var joueurPhoto: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!

    @IBOutlet weak var nomJoueur: UITextField!
    @IBOutlet weak var prenomJoueur: UITextField!
    @IBOutlet weak var ageJoueur: UITextField!
    @IBOutlet weak var longueurJoueur: UITextField!
    @IBOutlet weak var poidsJoueur: UITextField!
    
    @IBOutlet weak var numJoueur: UITextField!
    @IBOutlet weak var discriptionJoueur: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //Style Email TestField
        nomJoueur.layer.cornerRadius = 10.0
        nomJoueur.layer.borderWidth = 1.0
        nomJoueur.layer.masksToBounds = true
        
        //Style Password TestField
        prenomJoueur.layer.cornerRadius = 10.0
        prenomJoueur.layer.borderWidth = 1.0
        prenomJoueur.layer.masksToBounds = true //Style Password TestField
        
        ageJoueur.layer.cornerRadius = 10.0
        ageJoueur.layer.borderWidth = 1.0
        ageJoueur.layer.masksToBounds = true //Style Password TestField
        
        longueurJoueur.layer.cornerRadius = 10.0
        longueurJoueur.layer.borderWidth = 1.0
        longueurJoueur.layer.masksToBounds = true //Style Password TestField
        
        poidsJoueur.layer.cornerRadius = 10.0
        poidsJoueur.layer.borderWidth = 1.0
        poidsJoueur.layer.masksToBounds = true //Style Password TestField
        
        numJoueur.layer.cornerRadius = 10.0
        numJoueur.layer.borderWidth = 1.0
        numJoueur.layer.masksToBounds = true //Style Password TestField
        
        discriptionJoueur.layer.cornerRadius = 10.0
        discriptionJoueur.layer.borderWidth = 1.0
        discriptionJoueur.layer.masksToBounds = true //Style Password TestField
        
        
        
        // Do any additional setup after loading the view.
    }
    
/*
    @IBAction func addJoueurBtn(_ sender: Any) {
        let joueur = joueurModel(nom: nomJoueur.text!, prenom: prenomJoueur.text!,  age: ageJoueur.text!,  taille: poidsJoueur.text!,longueur: longJoueur.text!, num: numJoueur.text!, discription: descJoueur.text!)

        let status = JoueurService.shareinstance.AddJ(joueur: joueur)
        if status == 201{
                                 
                                 let alert = UIAlertController(title: "Success", message: "Joueur ajouter avec sucsses",preferredStyle: .alert)
                                 let action = UIAlertAction(title:"ok", style: .cancel, handler: { action in self.performSegue(withIdentifier: "GOOD!", sender: self) })
                                 alert.addAction(action)
                                 self.present(alert, animated: true, completion: nil)

    }
    

}
 */
    @IBAction func ajoutEquipeBtn(_ sender: Any) {
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
            return
        }
        if( self.nomJoueur.text!.isEmpty ||   self.prenomJoueur.text!.isEmpty ||   self.ageJoueur.text!.isEmpty ||   self.longueurJoueur.text!.isEmpty ||   self.discriptionJoueur.text!.isEmpty   ||   self.poidsJoueur.text!.isEmpty   ||   self.numJoueur.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }
        if( Int(ageJoueur.text!) == nil || Int(longueurJoueur.text!) == nil || Int(poidsJoueur.text!) == nil || Int(numJoueur.text!) == nil){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "il faut entre un numero"), animated: true)
            return
        }
        if(  numJoueur.text!.count != 8){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "il faut entrer 8  numero"), animated: true)
            return
        }


        
        let joueurd = joueurModel(  nom: nomJoueur.text!,prenom: prenomJoueur.text!,age: ageJoueur.text!,taille: poidsJoueur.text!,longueur: longueurJoueur.text!, num:numJoueur.text!, discription: discriptionJoueur.text!)
        JoueurService.shareinstance.addjoueurHH(joueur: joueurd, uiImage: currentPhoto!) { success in
            if success {
                self.present(Alert.makeAlert(titre: "Success", message: "joueur ajouté"),animated: true)
            }else{
                self.present(Alert.makeAlert(titre: "failed", message: " Joueur exist try again"),animated: true)

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
        joueurPhoto.image = selectedImage
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
