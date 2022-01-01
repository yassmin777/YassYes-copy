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
    @IBOutlet weak var stadePhoto: UIImageView!
    @IBOutlet weak var nomStade: UITextField!
    @IBOutlet weak var descStade: UITextField!
   
    @IBOutlet weak var numStade: UITextField!
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addImageButton: UIButton!

    
    
    var longitudeVal : Double?
    var latitudeVal : Double?
    
    
    var myGeoCoder = CLGeocoder()
    
    var locationManager  = CLLocationManager()
    
    var braintreeClient: BTAPIClient!




      
        
        

    override func viewDidLoad() {
        super.viewDidLoad()
        braintreeClient = BTAPIClient(authorization: "sandbox_s9c6p322_9f9q8ndwsws4xcws")

        locationManager.delegate = self
        mapView.delegate = self
        let oLongTapGerture = UILongPressGestureRecognizer(target: self, action:#selector(addStadeViewController.handleLongtapGesture(gestureRecognizer:)))
        
        self.mapView.addGestureRecognizer(oLongTapGerture)
       
    }
    
    @objc func handleLongtapGesture(gestureRecognizer : UILongPressGestureRecognizer){
        if gestureRecognizer.state != UIGestureRecognizer.State.ended{
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            latitudeVal = locationCoordinate.latitude
            longitudeVal = locationCoordinate.longitude
            print("latitude: \(locationCoordinate.latitude), Longitude:  \(locationCoordinate.longitude)")
            
            let myPin = MKPointAnnotation()
            myPin.coordinate = locationCoordinate

            myPin.title = " latitude: \(locationCoordinate.latitude), Longitude\(locationCoordinate.longitude)"
            
            

            mapView.addAnnotation(myPin)
        }
        
        if gestureRecognizer.state != UIGestureRecognizer.State.began
        {
            return
        }
    }


    @IBAction func validation(_ sender: UIButton) {
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
           payPalDriver.viewControllerPresentingDelegate = self
           payPalDriver.appSwitchDelegate = self
        
        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalRequest(amount: "100")
        request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options

     
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
            return
        }
        
        if( self.nomStade.text!.isEmpty || latitudeVal == nil || longitudeVal == nil || self.descStade.text!.isEmpty || self.numStade.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "Please make sure to fill all the form and try again"), animated: true)
            return
        }
        if( Int(numStade.text!) == nil  ||  numStade.text!.count != 8){
            self.present(Alert.makeAlert(titre: "Missing info !", message: "il faut entrer 8  numero"), animated: true)
            return
        }
        payPalDriver.requestOneTimePayment(request) { [self] (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                let staded = stadeModel(  nom: nomStade.text!, lat: latitudeVal!, lon: longitudeVal!, discription: descStade.text!,num:numStade.text!)
                stadeService.shareInstence.addstade(stade: staded, uiImage: self.currentPhoto!) { success in
                    if success {
                        //self.present(Alert.makeAlert(titre: "Success", message: "stade ajouté"),animated: true)
                        self.present(Alert.makeActionAlert(titre: "Success", message: "sccore ajouté", action: UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in self.navigationController?.popViewController(animated: true)})),animated: true)

                    }else{
                        self.present(Alert.makeAlert(titre: "failed", message: "try again"),animated: true)

                    }
                }
               
                // Access additional information
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone

                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
                // Handle error here...
            } else {
                // Buyer canceled payment approval
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
extension addStadeViewController: BTViewControllerPresentingDelegate
{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}
extension addStadeViewController: BTAppSwitchDelegate
{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}
