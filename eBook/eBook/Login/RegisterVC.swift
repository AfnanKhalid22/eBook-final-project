//
//  RegisterVC.swift
//  eBook
//
//  Created by Fno Khalid on 01/06/1443 AH.
//

import UIKit
import SafariServices
import FirebaseAuth
import Firebase
import AVFoundation
import FirebaseFirestore
import TransitionButton


class RegisterVC: UIViewController {
    
    
// MARK: Creating (UILabels / UITextFields / UIButtons) Programmatically For our CreateAccountViewController

    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Register", comment: "")
        label.textColor = UIColor.black
        label.font = UIFont(name: "Hoefler Text Italic", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let fullNameTf: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("name", comment: ""),
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("email", comment: ""),
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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
        
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("password", comment: ""),
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        tf.borderStyle = .none
        tf.textColor = .black
        tf.isSecureTextEntry = true
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
    
    
    let signUpButton: TransitionButton = {
        let button = TransitionButton()
        button.setTitle(NSLocalizedString("Sign Up", comment: ""), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return button
    }()
    
    
    lazy var SignInLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Already a Member? Sign In", comment: "")
        label.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        let labelTapped = UITapGestureRecognizer(target: self, action: #selector(signInAction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(labelTapped)
        return label
    }()
//
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
//
    
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
    
    @objc func signUpAction() {
        
        self.signUpButton.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.signUpButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 0 ) {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    let vc = TabVC()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        
        if let email = emailTF.text, email.isEmpty == false,
              let password = passwordTF.text, password.isEmpty == false {
              Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                  // go to main vc
                  let vc = UINavigationController(rootViewController: TabVC())
                  vc.modalTransitionStyle = .crossDissolve
                  vc.modalPresentationStyle = .fullScreen
                  self.present(vc, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription )
                    let alert = UIAlertController(title: "Error", message: "Wrong information", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    alert.addAction(
                     UIAlertAction(title: NSLocalizedString("cancel", comment: ""),
                        style: UIAlertAction.Style.default,
                              handler: { Action in print("...")
                          })
                      )
                            return
                }
                  
                guard let currentUserID = Auth.auth().currentUser?.uid else {return}
                Firestore.firestore().document("users/\(currentUserID)").setData([
                  "id" : currentUserID,
                  "name" : self.fullNameTf.text as Any,
                  "email" : self.emailTF.text as Any,
                  "password" : self.passwordTF.text as Any
                ])
              }
        }
    }
    
    @objc func signInAction() {
        print("Sign In Button Clicked")
        let loginViewController = LoginVC()
        navigationController?.pushViewController(loginViewController, animated: true)
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
    
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               fullNameTf.resignFirstResponder()
               emailTF.resignFirstResponder()
               passwordTF.resignFirstResponder()
            
            guard let currentUserID = Auth.auth().currentUser?.uid else {
              return true
            }
            Firestore.firestore().document("users/\(currentUserID)").setData([
                "name" : fullNameTf.text ?? "",
                
            ], merge: true
            )
          
            return true
    
              }
    
    
//MARK: SetupViews Function
        
    
    func setupView() {
        view.backgroundColor = UIColor(named: "Color")
        view.addSubview(titleLabel)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(fullNameTf)
     //   view.addSubview(phoneTf)
        view.addSubview(signUpButton)
        view.addSubview(SignInLabel)
//        view.addSubview(twitterButton)
//        view.addSubview(instagramButton)
//        view.addSubview(githubButton)
    }
    
    
// MARK: Setup Constraints Programmatically Using NSLayoutConstraint
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            fullNameTf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullNameTf.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            fullNameTf.heightAnchor.constraint(equalToConstant: 50),
            fullNameTf.widthAnchor.constraint(equalToConstant: 350),
            
            emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 260),
            emailTF.heightAnchor.constraint(equalToConstant: 50),
            emailTF.widthAnchor.constraint(equalToConstant: 350),
            
            passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            passwordTF.heightAnchor.constraint(equalToConstant: 50),
            passwordTF.widthAnchor.constraint(equalToConstant: 350),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.widthAnchor.constraint(equalToConstant: 320),
            
            SignInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            SignInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 480),
            
            // constraint here for some buttons

            
        ])
    }
}



// MARK: (LoginViewController/CreateAccountViewController) UITextField Left Padding Extension

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

// MARK: Hidding Software Keyboard

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
