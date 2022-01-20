//
//  WelcomePageVC.swift
//  eBook
//
//  Created by Fno Khalid on 01/06/1443 AH.
//

import UIKit
import SafariServices

class WelcomePageVC: UIViewController {
    
    
// MARK: Creating (UILabels / UIButtons) Programmatically For our ViewController
    

    let titleLabel: UILabel = {
       let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.text = "eBook"
        tl.font = UIFont(name: "Hoefler Text Italic", size: 40)
        tl.textColor = UIColor(named: "textColor")
        return tl
    }()
    
    let descriptionLabel: UILabel = {
       let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.text = NSLocalizedString("descriptionLabel" , comment: "")
        dl.textAlignment = .center
        dl.numberOfLines = 0
        dl.font = UIFont(name: "GillSans-Light", size: 30)
        dl.textColor = UIColor(named: "textColor")
        return dl
    }()

    
    let logInButton: UIButton = {
        let lb = UIButton()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setTitle(NSLocalizedString("Login Now", comment: ""), for: .normal)
        lb.setTitleColor(.white, for: .normal)
        lb.addTarget(self, action: #selector(logInAction), for: .touchUpInside)
        lb.backgroundColor = .black
        lb.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        lb.layer.shadowOffset = CGSize(width: 0, height: 3)
        lb.layer.shadowOpacity = 1.0
        lb.layer.shadowRadius = 10.0
        lb.layer.masksToBounds = false
        lb.layer.cornerRadius = 10
        return lb
    }()
    
    let createAccountButton: UIButton = {
        let cab = UIButton()
        cab.translatesAutoresizingMaskIntoConstraints = false
        cab.setTitle(NSLocalizedString("Create an Account", comment: ""), for: .normal)
        cab.setTitleColor(.black, for: .normal)
        cab.addTarget(self, action: #selector(createAccountAction), for: .touchUpInside)
        cab.backgroundColor = .white
        cab.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cab.layer.shadowOffset = CGSize(width: 0, height: 3)
        cab.layer.shadowOpacity = 1.0
        cab.layer.shadowRadius = 10.0
        cab.layer.masksToBounds = false
        cab.layer.cornerRadius = 10
        return cab
    }()
    
    
//MARK: viewDidLoad Function
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Color")
        navigationController?.navigationBar.isHidden = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "firstbackground")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        setupViews()
        setupConstraints()
    }
    
    
//MARK: SetupViews Function
    
    
    func setupViews() {
        view.addSubview(logInButton)
        view.addSubview(createAccountButton)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
     
    }
    
    
// MARK: Setup Constraints Programmatically Using Anchors
    
    
    func setupConstraints() {
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        createAccountButton.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 150).isActive = true
        createAccountButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        createAccountButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        createAccountButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        logInButton.topAnchor.constraint(equalTo: createAccountButton.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        logInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 55).isActive = true

    }
    
    @objc func createAccountAction() {
        print("Create an Account Button Clicked")
        let createAccountViewController = RegisterVC()
        navigationController?.pushViewController(createAccountViewController, animated: true)
    }
    
    @objc func logInAction() {
        print("Log In Button Clicked")
        let loginViewController = LoginVC()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
//    @objc func aboutUsButtonAction() {
//        print("About Us Button Clicked")
//        showSafariVC(for: "https://github.com/aidinahmadian")
//        }
//
//        func showSafariVC(for url: String) {
//            guard let url = URL(string: url) else {
//                return
//            }
//            let safariVC = SFSafariViewController(url: url)
//            present(safariVC, animated: true)
//        }
}

