//
//  DatabaseViewModel.swift
//  UpaxTest
//
//  Created by Daniel iOS on 23/01/22.
//

import Foundation
import UIKit
import FirebaseDatabase

class DatabaseViewModel {
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
        observeData()
    }
    
    //For Connection to View
    var refreshData = { () -> () in }
    //Dato a observar
    var dataColor: UIColor = UIColor() {
        didSet {
            refreshData()
        }
    }
    
    //Referencia Firebase Database
    func sendData(color: String) {
        ref.child("Colors").setValue(color)
    }
    
    //Observando para cambio de color
    func observeData() {
        ref.child("Colors").observe(.value, with: { snapshot in
            if let value = snapshot.value as? String {
                switch value {
                case "Naranja":
                    self.dataColor = .systemOrange
                case "Rosa":
                    self.dataColor = .systemPink
                case "Morado":
                    self.dataColor = .systemPurple
                case "Verde":
                    self.dataColor = .systemTeal
                    
                default:
                    break
                }
            }
        })
    }
    
}
