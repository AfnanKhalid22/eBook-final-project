//
//  GradientView.swift
//  eBook
//
//  Created by Fno Khalid on 18/04/1443 AH.
//

import UIKit

class GradientView: UIView {
    
    var controller: UIViewController!
    
    init(_ controller: UIViewController) {
        super.init(frame: .zero)
        self.controller = controller
        setupGradientView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupGradientView() {
        controller.view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 50
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        let constraints = [
            topAnchor.constraint(equalTo: controller.view.topAnchor),
            leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            bottomAnchor.constraint(equalTo: controller.view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        let gradient = setupGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: controller.view.frame.width, height: controller.view.frame.height/2)
        layer.insertSublayer(gradient, at: 5)
    }
    
  //  rgba(216,198,174,255)
 //  rgba(230,213,197,255)
//    let topColor = UIColor(red: 230/255, green: 237/255, blue: 184/255, alpha: 1).cgColor
//    let bottomColor = UIColor(red: 240/255, green: 244/255, blue: 212/255, alpha: 0.5).cgColor

    private func setupGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        let topColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1).cgColor
        let bottomColor = UIColor(red: 230/255, green: 213/255, blue: 197/255, alpha: 0.5).cgColor
        gradient.colors = [topColor, bottomColor]
        gradient.locations = [0, 1]
        return gradient
    }
}

