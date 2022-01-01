////
////  paypalViewController.swift
////  YassYes
////
////  Created by Mac-Mini_2021 on 11/12/2021.
////
//
//import UIKit
//import Braintree
//class paypalViewController: UIViewController {
//    var braintreeClient: BTAPIClient!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        braintreeClient = BTAPIClient(authorization: "sandbox_s9c6p322_9f9q8ndwsws4xcws")
//
//
//
//
//        
//    }
//
//
//    @IBAction func payment(_ sender: Any) {
//
//        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
//           payPalDriver.viewControllerPresentingDelegate = self
//           payPalDriver.appSwitchDelegate = self
//
//        // Specify the transaction amount here. "2.32" is used in this example.
//        let request = BTPayPalRequest(amount: "100")
//        request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options
//
//        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
//            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
//                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
//
//                // Access additional information
//                let email = tokenizedPayPalAccount.email
//                let firstName = tokenizedPayPalAccount.firstName
//                let lastName = tokenizedPayPalAccount.lastName
//                let phone = tokenizedPayPalAccount.phone
//
//                // See BTPostalAddress.h for details
//                let billingAddress = tokenizedPayPalAccount.billingAddress
//                let shippingAddress = tokenizedPayPalAccount.shippingAddress
//            } else if let error = error {
//                // Handle error here...
//            } else {
//                // Buyer canceled payment approval
//            }
//        }
//
//    }
//
//
//}
