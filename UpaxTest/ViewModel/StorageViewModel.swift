//
//  StorageViewModel.swift
//  UpaxTest
//
//  Created by Daniel iOS on 23/01/22.
//

import Foundation
import FirebaseStorage

enum errors: String {
    case failedToUploadFile = "Error al subir el archivo"
    case failedToDownloadLink = "Error al descargar enlace"
    case failedToDownloadFile = "Error al descargar archivo"
}

class StorageViewModel {
    
    private let storage = Storage.storage().reference()
    
    //For Connection to View
    var refreshData = { () -> () in }
    //Message to User
    var refreshResult = { () -> () in }
    //Error
    var refreshErrors = { () -> () in }
    
    //Datos a observar
    var dataImage: UIImage = UIImage() {
        didSet {
            refreshData()
        }
    }
    
    var dataResult: String = "" {
        didSet {
            refreshResult()
        }
    }
    
    var errorAppear: String = "" {
        didSet {
            refreshErrors()
        }
    }
    
    func uploadSelfie(imageData: Data, userName: String){
        storage.child("selfie/\(userName).png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                self.errorAppear = errors.failedToUploadFile.rawValue
                return
            }
            
            self.storage.child("selfie/\(userName).png").downloadURL(completion: { url, error in
                guard let url = url, error == nil else {
                    self.errorAppear = errors.failedToDownloadLink.rawValue
                    return
                }
                
                let urlString = url.absoluteString
                PhotoViewModel.saveUrlSelfie(url: urlString)
                self.dataResult = "Imagen guardada en: \(urlString)"

            })
            
        }
        
    }
    
    func downloadSelfie(){
        
        
        
    }
    
}
