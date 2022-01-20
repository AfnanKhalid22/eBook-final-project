//
//  ResetPassword.swift
//  eBook
//
//  Created by Fno Khalid on 24/05/1443 AH.
//

import UIKit
import Firebase
import TransitionButton

class ForgetPassword: UIViewController, UITextFieldDelegate {
    
    lazy var password: UILabel = {
        let password = UILabel()
         password.textAlignment = .center
         password.textColor = UIColor(named: "textColor")
         password.text = "Forget Password"
         password.font = UIFont(name:"Hoefler Text Italic", size: 48.0)
         password.textAlignment = NSTextAlignment.right
         password.numberOfLines = 1
         password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    var emailTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .lightGray
        tf.textAlignment = .center
        tf.keyboardType = .emailAddress
        tf.layer.cornerRadius = 8
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = UIColor(named: "textColor")
        tf.attributedPlaceholder = NSAttributedString(
            string: NSLocalizedString("email", comment: ""),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.isSecureTextEntry = false

        return tf
    }()
    
    let sendButton : TransitionButton = {
        let btn = TransitionButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Send", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        btn.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        btn.layer.cornerRadius = 15
      //  btn.tintColor = .white
        btn.addTarget(self, action: #selector(sendPassword), for: .touchUpInside)
      return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor(named: "Color")
        self.emailTF.delegate = self
        setupGradientView4()
        setupConstraint()
    }
    
    func setupConstraint() {
        view.addSubview(password)
        view.addSubview(emailTF)
        view.addSubview(sendButton)
        NSLayoutConstraint.activate([
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            emailTF.heightAnchor.constraint(equalToConstant: 50),
            emailTF.widthAnchor.constraint(equalToConstant: 300),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func sendPassword() {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailTF.text!, completion: { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                alert.addAction(
                 UIAlertAction(title: NSLocalizedString("cancel", comment: ""),
                    style: UIAlertAction.Style.default,
                          handler: { Action in print("...")
                      })
                      
                  )
                return
            }
            
            let alert = UIAlertController(title: "Done", message: "Check Your Email", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            alert.addAction(
             UIAlertAction(title: NSLocalizedString("cancel", comment: ""),
                style: UIAlertAction.Style.default,
                      handler: { Action in print("...")
                  })
                  
              )
            return
            
            
        })
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           emailTF.resignFirstResponder()
        
                  return true
          }
    private func setupGradientView4() {
        let _ = GradientView(self)
    }
}
