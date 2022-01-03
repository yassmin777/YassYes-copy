//
//  Alert.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 29/11/2021.
//

import Foundation
import UIKit

var Host="http://localhost:3000"
//var Host="http://172.17.0.11:3000"

public class Alert {
    static func makeAlert(titre: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
        static func makeActionAlert(titre: String?, message: String?, action: UIAlertAction) -> UIAlertController {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
            
        alert.addAction(action)
        return(alert)
    }
}
extension UIViewController {
 func initializeHideKeyboard(){
 //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
 let tap: UITapGestureRecognizer = UITapGestureRecognizer(
 target: self,
 action: #selector(dismissMyKeyboard))
 //Add this tap gesture recognizer to the parent view
 view.addGestureRecognizer(tap)
 }
 @objc func dismissMyKeyboard(){
 //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
 //In short- Dismiss the active keyboard.
 view.endEditing(true)
 }
 }
