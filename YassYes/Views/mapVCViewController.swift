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





class mapVCViewController: UIViewController , UISearchBarDelegate{

    

    

    var locationManager: CLLocationManager!

    var mapView: MKMapView!

    

    let centerMapButton: UIButton = {

        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)


       // button.setImage(#imageLiteral(resourceName: "location-arrow-flat").withRenderingMode(.alwaysOriginal), for: .normal)

        button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button

    }()

    

    // MARK: - Init



    
    var annotationsLocation = [[String : Any]]()

    override func viewDidAppear(_ animated: Bool) {
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).responseJSON{ response in
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                print(myresult)
                for i in myresult!.arrayValue{
                    let nom = i["nom"].stringValue
                    let lat = i["lat"].doubleValue
                    let long = i["lon"].doubleValue
                    self.annotationsLocation.append(
                        ["title": nom, "latitude": lat, "longitude": long]
                    )

                }
                print(self.annotationsLocation)
                break



            case .failure:
                print(response.error!)
                break
            }
        }
        configureLocationManager()

        configureMapView()

        enableLocationServices()

        createAnnotation(locations:annotationsLocation)


    }
    override func viewDidLoad() {

        super.viewDidLoad()

       
    }

    

    // MARK: - Selectors

    

    @objc func handleCenterLocation() {

        centerMapOnUserLocation()

        centerMapButton.alpha = 0

    }

    

    // MARK: - Helper Functions

    

    func configureLocationManager() {

        locationManager = CLLocationManager()

        locationManager.delegate = self

    }

    

    func configureMapView() {

        mapView = MKMapView()

        mapView.showsUserLocation = true

        mapView.delegate = self

        mapView.userTrackingMode = .follow

        

        view.addSubview(mapView)

        mapView.frame = view.frame

        

        view.addSubview(centerMapButton)

        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44).isActive = true

        centerMapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true

        centerMapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        centerMapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true

        centerMapButton.layer.cornerRadius = 50 / 2

        centerMapButton.alpha = 1

    }

    

    func centerMapOnUserLocation() {

        guard let coordinate = locationManager.location?.coordinate else { return }

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)

        mapView.setRegion(region, animated: true)

    }

    

    

//   let annotationsLocation = [
//["longitude": 10.689226695846768, "latitude": 34.770598137766015, "title": "Nill"], ["title": "yassine", "latitude": 36.76721868062337, "longitude": 10.190588335688258]]
//
//        ["title": "Nill", "latitude": 34.770598137766015, "longitude": 10.689226695846768],
    //    ["title": "yassine", "latitude": 36.76721868062337, "longitude": 10.190588335688258]
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276],
//
//        ["title": "California Gym CUN", "latitude": 36.85062084440735 ,  "longitude":  10.196671572375736],
//
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276],
//
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276],
//
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276],
//
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276],
//
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276],
//
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276],
//
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276],
//
//        ["title": "California Gym Ariana", "latitude": 36.86416299848621, "longitude": 10.144468421015276]
//    ]
    
    
//    for i in myresult!.arrayValue{
//        let title = i["nom"].stringValue
//        let latitude = i["lat"].doubleValue
//        let longitude = i["lon"].doubleValue
//        self.annotationsLocation.append(title,i)
//        self.annotationsLocation.append(latitude,i)
//        self.annotationsLocation.append(longitude,i)
        
        
  

    func createAnnotation(locations: [[String : Any]]) {

        for location in locations {
            print(location)

            let annotations = MKPointAnnotation()

            annotations.title = location["title"] as? String

            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"]as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)



            

        mapView.addAnnotation(annotations)

        }

    }

    }



extension mapVCViewController: MKMapViewDelegate {

    

    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {

        UIView.animate(withDuration: 0.5) {

            self.centerMapButton.alpha = 1

        }

    }

    

    

}



// MARK: - CLLocationManagerDelegate



extension mapVCViewController: CLLocationManagerDelegate {

    

    func enableLocationServices() {

        switch CLLocationManager.authorizationStatus() {

        case .notDetermined:

            print("Location auth status is NOT DETERMINED")

            locationManager.requestWhenInUseAuthorization()

        case .restricted:

            print("Location auth status is RESTRICTED")

        case .denied:

            print("Location auth status is DENIED")

        case .authorizedAlways:

            print("Location auth status is AUTHORIZED ALWAYS")

        case .authorizedWhenInUse:

            print("Location auth status is AUTHORIZED WHEN IN USE")

            locationManager.startUpdatingLocation()

            locationManager.desiredAccuracy = kCLLocationAccuracyBest

        }

    }

    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        guard locationManager.location != nil else { return }

        centerMapOnUserLocation()

    }

}
