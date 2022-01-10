//
//  BaseViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 04/01/2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, Storyboardable {
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    private lazy var blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    func showLoader(in view: UIView? = nil, blurred: Bool = false) {
        let view = view ?? self.view
        setupActivityIndicator(in: view!, blurred: blurred)
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.blurredView.removeFromSuperview()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func setupActivityIndicator(in view: UIView, blurred: Bool) {
        if blurred {
            blurredView.frame = self.view.bounds
            view.addSubview(blurredView)
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
