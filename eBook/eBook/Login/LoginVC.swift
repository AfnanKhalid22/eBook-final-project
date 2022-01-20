//
//  LoginVC.swift
//  eBook
//
//  Created by Fno Khalid on 18/04/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import AVFoundation
import TransitionButton
import FirebaseFirestore
import SafariServices

class LoginVC: UIViewController {
    

// MARK: Creating (UILabels / UITextFields / UIButtons) Programmatically For our LoginViewController

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("login", comment: "")
        label.textColor = UIColor.black
        label.font = UIFont(name: "Hoefler Text Italic", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let mailTf: UITextField = {
       let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("email", comment: ""),
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        tf.borderStyle = .none
        tf.textColor = .black
        tf.backgroundColor = #colorLiteral(red: 0.9802859426, green: 0.9804533124, blue: 0.9802753329, alpha: 1)
        tf.setLeftPaddingPoints(20)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.layer.borderWidth = 1
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTf: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("password", comment: ""),
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        tf.borderStyle = .none
        tf.textColor = .black
        tf.backgroundColor = #colorLiteral(red: 0.9802859426, green: 0.9804533124, blue: 0.9802753329, alpha: 1)
        tf.isSecureTextEntry = true
        tf.setLeftPaddingPoints(20)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.layer.borderWidth = 1
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()


    let signInButton: TransitionButton = {
        let button = TransitionButton()
        button.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        return button
    }()
    
     lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("register", comment: "")
        label.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        let labelTapped = UITapGestureRecognizer(target: self, action: #selector(signUpAction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(labelTapped)
        return label
    }()
    
//    let twitterButton: UIButton = {
//       let tb = UIButton()
//        tb.translatesAutoresizingMaskIntoConstraints = false
//        tb.setImage(UIImage.init(named: "twitter"), for: .normal)
//        tb.addTarget(self, action: #selector(twitterButtonAction), for: .touchUpInside)
//        tb.imageView?.contentMode = .scaleAspectFill
//        tb.clipsToBounds = true
//        return tb
//    }()
//
//    let instagramButton: UIButton = {
//       let ib = UIButton()
//        ib.translatesAutoresizingMaskIntoConstraints = false
//        ib.setImage(UIImage.init(named: "instagram"), for: .normal)
//        ib.addTarget(self, action: #selector(instagramButtonAction), for: .touchUpInside)
//        return ib
//    }()
//
//    let githubButton: UIButton = {
//       let gb = UIButton()
//        gb.translatesAutoresizingMaskIntoConstraints = false
//        gb.setImage(UIImage.init(named: "github"), for: .normal)
//        gb.addTarget(self, action: #selector(githubButtonAction), for: .touchUpInside)
//        return gb
//    }()
    
        let forgetPassButton : TransitionButton = {
            let btn = TransitionButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle(NSLocalizedString("forget", comment: ""), for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    //        btn.tintColor = UIColor(named: "textColor")
            btn.setTitleColor(UIColor(named: "textColor"), for: .normal)
            btn.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
          return btn
        }()
    
    
    
//MARK: viewDidLoad Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sixthbackground")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        setupView()
        setupConstraints()
    }

    
    @objc func signInAction() {
        
        self.signInButton.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.signInButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 0 ) {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    let vc = TabVC()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        if let email = mailTf.text, email.isEmpty == false,
                         let password = passwordTf.text, password.isEmpty == false {
                         Auth.auth().signIn(withEmail: email, password: password) { result, error in
                           if error == nil {
                             // go to main vc
                             let vc = UINavigationController(rootViewController: TabVC())
                             vc.modalTransitionStyle = .crossDissolve
                             vc.modalPresentationStyle = .fullScreen
                             self.present(vc, animated: true, completion: nil)
                           } else {
                             print(error?.localizedDescription)
                               let alert = UIAlertController(title: "Error", message: "Wrong email or password", preferredStyle: .alert)
                               self.present(alert, animated: true, completion: nil)
                               alert.addAction(
                                UIAlertAction(title: NSLocalizedString("cancel", comment: ""),
                                   style: UIAlertAction.Style.default,
                                         handler: { Action in print("...")
                                     })
       
                                 )
                                   return
                           }
                         }
                         }
    }
    
    @objc func signUpAction() {
        print("Sign Up Button Clicked")
        let createAccountViewController = RegisterVC()
        navigationController?.pushViewController(createAccountViewController, animated: true)
    }
    
        @objc func forgetPassword() {
            let passwordVC = ForgetPassword()
            passwordVC.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(passwordVC,animated: true)
        }
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             
               mailTf.resignFirstResponder()
               passwordTf.resignFirstResponder()
    
                      return true
              }
    
//MARK: Twitter/Instagram/GitHub Links
    
//
//    @objc func twitterButtonAction() {
//        print("Twitter Button Clicked")
//        showSafariVC(for: "https://twitter.com/Corrrky")
//    }
//
//    @objc func instagramButtonAction() {
//        print("Instagram Button Clicked")
//        showSafariVC(for: "https://www.instagram.com/aidinahmadian/")
//    }
//
//    @objc func githubButtonAction() {
//        print("GitHub Button Clicked")
//        showSafariVC(for: "https://github.com/aidinahmadian")
//    }
//
//    func showSafariVC(for url: String) {
//        guard let url = URL(string: url) else {
//            return
//        }
//        let safariVC = SFSafariViewController(url: url)
//        present(safariVC, animated: true)
//    }
    
    
//MARK: SetupViews Function
    
        
    func setupView() {
        view.backgroundColor = UIColor.white
//        view.addSubview(twitterButton)
//        view.addSubview(instagramButton)
//        view.addSubview(githubButton)
        view.addSubview(titleLabel)
        view.addSubview(mailTf)
        view.addSubview(passwordTf)
        view.addSubview(signInButton)
        view.addSubview(signUpLabel)
        view.addSubview(forgetPassButton)
    }
    
// MARK: Setup Constraints Programmatically Using NSLayoutConstraint
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            mailTf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mailTf.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            mailTf.heightAnchor.constraint(equalToConstant: 50),
            mailTf.widthAnchor.constraint(equalToConstant: 350),
            
            passwordTf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTf.topAnchor.constraint(equalTo: view.topAnchor, constant: 260),
            passwordTf.heightAnchor.constraint(equalToConstant: 50),
            passwordTf.widthAnchor.constraint(equalToConstant: 350),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.widthAnchor.constraint(equalToConstant: 320),
            
            forgetPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgetPassButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 420),
            
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 470),
            
            
            //  constraint here for some buttons 
    
        ])

    }
}


