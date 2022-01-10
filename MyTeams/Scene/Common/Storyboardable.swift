//
//  Storyboardable.swift
//  MyTeams
//
//  Created by Martin Bucko on 19/12/2021.
//

import UIKit

protocol Storyboardable {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
        
    static func instantiate() -> Self
}

extension Storyboardable where Self: UIViewController {
    static var storyboardName: String {
        return String(describing: self)
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
        
    static func instantiate() -> Self {
        guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Unable to Instantiate View Controller With Storyboard Identifier \(storyboardIdentifier)")
        }
        return viewController
    }
}
