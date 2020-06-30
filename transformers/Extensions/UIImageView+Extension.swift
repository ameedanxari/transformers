//
//  UIImageView+Extension.swift
//  transformers
//
//  Created by macintosh on 2020-06-29.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

extension UIImageView {
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString,
            let imageURL = URL(string: imageURLString) else {
                self.image = UIImage(named: "AppIcon")
                return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "AppIcon")
            }
        }
    }
}
