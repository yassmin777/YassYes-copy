//
//  EquipeService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
class EquipeService{
    static let shareinstance = EquipeService()

    func AddJ(equipe : equipeModel)-> Int{
        var status: Int = 0
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "nom="+equipe.nom+"&discription="+equipe.discription+"&equipecapacite="+equipe.equipecapacite
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://localhost:3000/sifflet/equipe")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return status

    }
}
