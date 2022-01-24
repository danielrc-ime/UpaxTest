//
//  RequestViewModel.swift
//  UpaxTest
//
//  Created by Daniel iOS on 21/01/22.
//

import Foundation
import UIKit

class RequestViewModel {
    //For Connection to View
    var refreshData = { () -> () in }
    //Dato a observar
    var dataArray: DataModel = DataModel(colors: [], questions: []) {
        didSet {
            refreshData()
        }
    }
    
    func getData() {
        guard let url = URL(string: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let json = data
            //Serializar data
            do {
                let decoder = JSONDecoder()
                self.dataArray = try decoder.decode(DataModel.self, from: json!)
                debugPrint(self.dataArray)

            } catch let error {
                debugPrint("Error en \(#function) = \(error.localizedDescription)")
            }
    
        }.resume()
        
    }
    
}
