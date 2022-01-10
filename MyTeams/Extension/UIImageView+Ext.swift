//
//  UIImageView+Ext.swift
//  MyTeams
//
//  Created by Martin Bucko on 28/12/2021.
//

import UIKit

extension UIImageView {
    func load(url: URL?, placeholder: UIImage? = nil) {
        NetworkManager().loadImage(url: url) { [weak self] data in
            DispatchQueue.main.async {
                if let data = data {
                    self?.image = UIImage(data: data)
                } else {
                    self?.image = placeholder
                }
            }
        }
    }
}
