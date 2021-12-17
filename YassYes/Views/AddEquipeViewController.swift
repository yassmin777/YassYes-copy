//
//  AddEquipeViewController.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 17/12/2021.
//

import UIKit

class AddEquipeViewController: UIViewController,UIGestureRecognizerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

            var currentPhoto : UIImage?

            @IBOutlet weak var equipePhoto: UIImageView!

            @IBOutlet weak var nomEquipe: UITextField!
            @IBOutlet weak var descEquipe: UITextField!
            
            @IBOutlet weak var addImageButtonn: UIButton!
            
            
            @IBAction func EquipeAddBtn(_ sender: Any) {
                if (currentPhoto == nil){
                    self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
                    return
                }
                if( self.nomEquipe.text!.isEmpty ||   self.descEquipe.text!.isEmpty){
                    self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
                    return
                }
                
                let equiped = equipeModel(  nom: nomEquipe.text!, discription: descEquipe.text!)
                
                EquipeService.shareinstance.addequipe(equipe: equiped, uiImage: currentPhoto!) { success in
                    if success {
                        self.present(Alert.makeAlert(titre: "Success", message: "equipe ajouté"),animated: true)
                    }else{
                        self.present(Alert.makeAlert(titre: "failed", message: " Equipe exist try again"),animated: true)

                    }
                }
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()

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
                equipePhoto.image = selectedImage
                addImageButtonn.isHidden = true
                
                
                
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
