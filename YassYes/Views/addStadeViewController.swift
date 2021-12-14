//
//  addStadeViewController.swift
//  YassYes
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import MapKit
import Braintree

class addStadeViewController: UIViewController,MKMapViewDelegate,UIGestureRecognizerDelegate,CLLocationManagerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    
    
    var currentPhoto : UIImage?
    var braintreeClient:BTAPIClient!
    
    @IBOutlet weak var stadePhoto: UIImageView!
    @IBOutlet weak var nomStade: UITextField!
    @IBOutlet weak var descStade: UITextField!
   
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addImageButton: UIButton!

    
    
    var longitudeVal : Double?
    var latitudeVal : Double?
    
    
    var myGeoCoder = CLGeocoder()
    
    var locationManager  = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        /*
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if(CLLocationManager.locationServicesEnabled())
        {
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
        */
        mapView.delegate = self
        let oLongTapGerture = UILongPressGestureRecognizer(target: self, action:#selector(addStadeViewController.handleLongtapGesture(gestureRecognizer:)))
        
        self.mapView.addGestureRecognizer(oLongTapGerture)
       
        // Do any additional setup after loading the view.
    }
    
    @objc func handleLongtapGesture(gestureRecognizer : UILongPressGestureRecognizer){
        if gestureRecognizer.state != UIGestureRecognizer.State.ended{
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            latitudeVal = locationCoordinate.latitude
            longitudeVal = locationCoordinate.longitude
            print("Cliker sur latitude: \(locationCoordinate.latitude), Longitude\(locationCoordinate.longitude)")
            
            let myPin = MKPointAnnotation()
            myPin.coordinate = locationCoordinate

            myPin.title = "Cliker sur latitude: \(locationCoordinate.latitude), Longitude\(locationCoordinate.longitude)"
            
            

            mapView.addAnnotation(myPin)
        }
        
        if gestureRecognizer.state != UIGestureRecognizer.State.began
        {
            return
        }
    }


        @IBAction func saveStadeBtn(_ sender: Any) {
            /*
        guard let nom = self.nomStade.text else{return}
        guard let descStade = self.descStade.text else{return}

            let admin = adminModel(photo:"",_id:"",nom: "", prenom: "", email: "", motdepasse: "", isProprietaireDestade: "")
        
        if( self.nomStade.text!.isEmpty || latitudeVal! == 0 || longitudeVal! == 0 || self.descStade.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }
            let stade = stadeModel(_id:"",admin :admin,nom: nom, lat: latitudeVal!, lon: longitudeVal!, discription: descStade)
        stadeService.shareInstence.addStade(stade: stade){
            (isSuccess) in
            if isSuccess{
                self.present(Alert.makeAlert(titre: "Alert", message: "Stade register successfully"), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Alert", message: "Please try again "), animated: true)
            }
        }


        
        
        */

    }
    /*func mapView(mapV:MKMapView, rendererFor overlay: MKOverlay) ->MKOverlayRenderer {
        let render = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        
        renderer.strokeColor = .bluerendrer
    }
*/
    @IBAction func validation(_ sender: UIButton) {
     
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
            return
        }
        
        if( self.nomStade.text!.isEmpty || latitudeVal == nil || longitudeVal == nil || self.descStade.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }
        
        let staded = stadeModel(  nom: nomStade.text!, lat: latitudeVal!, lon: longitudeVal!, discription: descStade.text!)
        stadeService.shareInstence.addstade(stade: staded, uiImage: currentPhoto!) { success in
            if success {
                //self.present(Alert.makeAlert(titre: "Success", message: "stade ajouté"),animated: true)
                self.performSegue(withIdentifier: "payer", sender: nil)

            }else{
                self.present(Alert.makeAlert(titre: "failed", message: "try again"),animated: true)

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
        stadePhoto.image = selectedImage
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
    
    
    @IBAction func payAction(_ sender: Any) {
        
       
    
}
}
