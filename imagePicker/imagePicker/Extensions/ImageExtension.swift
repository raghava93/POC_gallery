//
//  ImageExtension.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 23/12/21.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
        func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
            
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
        func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    
    
    func loadImageFromUrl(urlString: String)   {
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        guard let url = URL(string: urlString) else {
            return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                    
                }
            }
        }
        
    }
    
}
