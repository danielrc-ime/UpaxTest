//
//  PhotoViewModel.swift
//  UpaxTest
//
//  Created by Daniel iOS on 22/01/22.
//

import Foundation
import UIKit

struct PhotoViewModel{
    
    static func getUserPic() -> UIImage? {
        let filename = getDocumentsDirectory().appendingPathComponent("userPic.png")
        guard let image = UIImage(contentsOfFile: filename.path) else { return nil }
        
        return image
    }
    
    static func saveUserPic(selfie: UIImage) {
        if let data = selfie.pngData() {
            //Saving data to documents directory
            let filename = getDocumentsDirectory().appendingPathComponent("userPic.png")
            try? data.write(to: filename)
        }
    }
    
    static func saveUrlSelfie(url: String) {
        UserDefaults.standard.set(url, forKey: "urlSelfie")
    }
    
    static func getUrlSelfie() -> String{
        guard let url: String = UserDefaults.standard.value(forKey: "urlSelfie") as? String else {
            return ""
        }
        return url
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
