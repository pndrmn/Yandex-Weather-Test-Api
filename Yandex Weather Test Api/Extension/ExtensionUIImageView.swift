//
//  ExtensionUIImageView.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 11.08.2021.
//

import SVGKit
import UIKit

extension UIImageView {
    
    func downloadedsvg(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let receivedicon: SVGKImage = SVGKImage(data: data),
                let image = receivedicon.uiImage
            else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }
        session.resume()
    }
}
