//
//  MocaLockViewController.swift
//  MocaLock-Example
//
//  Created by yusuke saso on 2019/05/26.
//  Copyright © 2019 yusuke saso. All rights reserved.
//

import UIKit
import AudioToolbox
import LocalAuthentication

public protocol MocaLockUnlockDelegate: class {
    func correctPassword()
}

public protocol MocaLockRegisterDelegate: class {
    func completeRegister(password: String)
}

/// This role is Views design, Password validation.
/// When using a FaceID, append [Privacy - Face ID Usage Description] to Info.plist .
///
public class MocaLockViewController: UIViewController {
    
    public enum MocaLockType {
        case unlock
        case register
    }
    
    public var unlockPassword: String?
    public var registerPassword: String?
    public weak var unlockDelegate: MocaLockUnlockDelegate?
    public weak var registerDelegate: MocaLockRegisterDelegate?
    public private(set) var mocaLockType: MocaLockType = .unlock
    public private(set) var mocaLockView: MocaLockView = MocaLockView(passwordCount: 4)
    public private(set) var goBackButton: UIButton = UIButton()
    private var backgroundColor = UIColor(named: "Color")
    private var btnTextColor = UIColor(named: "textColor")
    private var btnBGColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    private let errorMessageColor = UIColor(red: 0.96, green: 0.34, blue: 0.21, alpha: 1.0)
  //  private let localizeTableName = "MocaLockLocalized"
    
    public convenience init(mocaLockType: MocaLockType,
                            backgroundColor argBGColor: UIColor? = nil,
                            buttonTextColor argBtnTextColor: UIColor? = nil,
                            buttonBGColor argBtnBGColor: UIColor? = nil) {
        self.init()
        self.mocaLockType = mocaLockType
        if let c = argBGColor {
            self.backgroundColor = c
        }
        if let c = argBtnTextColor {
            self.btnTextColor = c
        }
        if let c = argBtnBGColor {
            self.btnBGColor = c
        }
    }
    
    public override func loadView() {
        super.loadView()
        
        mocaLockView.delegate = self
        mocaLockView.dataSource = self
        mocaLockView.reloadViews()
        
        switch mocaLockType {
        case .register:
            mocaLockView.messageLabel.text = NSLocalizedString("enterRegisterPasswordMsg", comment: "")
        case .unlock:
            mocaLockView.messageLabel.text = NSLocalizedString("enterUnlockPasswordMsg", comment: "")
        }
        mocaLockView.messageLabel.textColor = UIColor(named: "textColor")
        
        //////////
        // Init UI
        
        view.backgroundColor = backgroundColor
        self.view.addSubview(mocaLockView)
        
        goBackButton.setTitle(NSLocalizedString("back",  comment: ""), for: .normal)
        goBackButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        goBackButton.addTarget(self, action: #selector(touchUpGoBack(_:)), for: .touchUpInside)
        self.view.addSubview(goBackButton)
        
        //////////
        // Set Layout
        
        mocaLockView.translatesAutoresizingMaskIntoConstraints = false
        mocaLockView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mocaLockView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mocaLockView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mocaLockView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        goBackButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        goBackButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 4).isActive = true
        goBackButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
    }
    
    private func shakeAnimation(view: UIView, completion: ((Bool) -> Swift.Void)? = nil) {
        AudioServicesPlaySystemSound(1102)
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                view.transform = CGAffineTransform(translationX: -10, y: 0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {
                view.transform = CGAffineTransform(translationX: 10, y: 0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2, animations: {
                view.transform = CGAffineTransform(translationX: -6, y: 0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: {
                view.transform = CGAffineTransform(translationX: 6, y: 0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                view.transform = CGAffineTransform.identity
            })
        }, completion: completion)
    }
    
    @objc func touchUpGoBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension MocaLockViewController: MocaLockViewDelegate {
    public func mocaLockView(_ mocaLockView: MocaLockView, didCompletePassword password: String) {
        switch mocaLockType {
        case .unlock:
            // number password validation.
            if password == unlockPassword {
                // successed unlock
                mocaLockView.messageLabel.text = ""
                dismiss(animated: true, completion: nil)
                unlockDelegate?.correctPassword()
                
            } else {
                // failed
                mocaLockView.messageLabel.text = NSLocalizedString("passwordIncorrectMsg", comment: "")
                mocaLockView.messageLabel.textColor = errorMessageColor
                // shake
                self.mocaLockView.isUserInteractionEnabled = false
                shakeAnimation(view: mocaLockView, completion: { finished in
                    self.mocaLockView.isUserInteractionEnabled = true
                    self.mocaLockView.clearPassword()
                })
            }
        case .register:
            // first input or confirm
            if let registerPassword = registerPassword {
                if registerPassword == password {
                    self.dismiss(animated: true, completion: nil)
                    registerDelegate?.completeRegister(password: registerPassword)
                } else {
                    // TODO: confirm failed
                    mocaLockView.messageLabel.text = NSLocalizedString("passwordNotMatchMsg",  comment: "")
                    mocaLockView.messageLabel.textColor = errorMessageColor
                    // shake
                    self.mocaLockView.isUserInteractionEnabled = false
                    shakeAnimation(view: mocaLockView, completion: { finished in
                        self.mocaLockView.isUserInteractionEnabled = true
                        self.mocaLockView.clearPassword()
                    })
                }
            } else {
                // next confirm
                registerPassword = password
                mocaLockView.messageLabel.text = NSLocalizedString("enterPasswordAgainMsg", comment: "")
                mocaLockView.messageLabel.textColor = UIColor(named: "textColor")
                mocaLockView.clearPassword()
            }
        }
    }
    
    public func didTouchUpBioAuth(_ mocaLockView: MocaLockView) {
        // biometric validation.
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: NSLocalizedString("passwordLockReason", comment: ""),
                reply: {success, evaluateError in
                if (success) {
                    // auth success.
                    print("bio auth success.")
                    DispatchQueue.main.async {
                        self.mocaLockView.messageLabel.text = ""
                        self.dismiss(animated: true, completion: nil)
                        self.unlockDelegate?.correctPassword()
                    }
                } else {
                    // auth failed.
                    DispatchQueue.main.async {
                        self.mocaLockView.messageLabel.text = NSLocalizedString("authFailedMsg",  comment: "")
                        self.mocaLockView.messageLabel.textColor = self.errorMessageColor
                        // shake
                        self.mocaLockView.isUserInteractionEnabled = false
                        self.shakeAnimation(view: mocaLockView, completion: { finished in
                            self.mocaLockView.isUserInteractionEnabled = true
                            self.mocaLockView.clearPassword()
                        })
                    }
                    print("bio auth failed")
                }
            })
        }
        if let er = error {
            print(er)
        }
    }
}

extension MocaLockViewController: MocaLockViewDataSource {
    public func mocaLockView(_ mocaLockView: MocaLockView, buttonForNumber number: UInt8) -> NumberButton {
        let button = CircleNumberButton()
        button.setTitle(String(format: "%d", number), for: .normal)
        button.setTitleColor(btnTextColor, for: .normal)
        button.fillColor = btnBGColor
        button.number = number
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return button
    }
    
    public func mocaLockView(_ mocaLockView: MocaLockView, inputSignViewForCount count: UInt8) -> InputSignView {
        let view = PointSignView()
        view.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        view.fillColor = UIColor(named: "textColor")
        view.lineColor = UIColor(named: "textColor")
        view.backgroundColor = .clear
        return view
    }
    
    public func deleteButton(_ mocaLockView: MocaLockView) -> UIButton {
        let button = UIButton()
        button.setTitle(NSLocalizedString("delete", comment: ""), for: .normal)
        button.setTitleColor(btnTextColor, for: .normal)
        button.setTitleColor(btnTextColor?.withAlphaComponent(0.6), for: .highlighted)
        button.backgroundColor = .clear
        return button
    }
    
    public func bioAuthButton(_ mocaLockView: MocaLockView) -> UIButton {
        var error: NSError?
        let lacontext = LAContext()
        if mocaLockType == .unlock &&
            lacontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            switch lacontext.biometryType {
            case .faceID:
                
                let button = UIButton()
                button.setTitle(NSLocalizedString("faceId", comment: ""), for: .normal)
                button.setTitleColor(btnTextColor, for: .normal)
                button.setTitleColor(btnTextColor?.withAlphaComponent(0.6), for: .highlighted)
                button.backgroundColor = .clear
                return button
                
            case .touchID:
                
                let button = UIButton()
                button.setTitle(NSLocalizedString("touchId", comment: ""), for: .normal)
                button.setTitleColor(btnTextColor, for: .normal)
                button.setTitleColor(btnTextColor?.withAlphaComponent(0.6), for: .highlighted)
                button.backgroundColor = .clear
                return button
            default:
                break
            }
        }
        if let er = error {
            print(er)
        }
        let button = UIButton()
        button.isEnabled = false
        return button
    }
}
