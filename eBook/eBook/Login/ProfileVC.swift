//
//  ProfileVC.swift
//  eBook
//
//  Created by Fno Khalid on 18/04/1443 AH.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth
import TransitionButton
import FirebaseStorage
import MocaLock


class ProfileVC : UIViewController, UIImagePickerControllerDelegate,UITextFieldDelegate, UINavigationControllerDelegate, MocaLockRegisterDelegate {
 
    var oldTabbarFr: CGRect = .zero
    
    let storage = Storage.storage().reference()

    lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "profile")
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        view.layer.cornerRadius = 25
        view.isUserInteractionEnabled = true
      
        return view
    }()
    
    lazy var smallImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "photo.circle")
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        image.tintColor = .black
        return image
    }()
    

    lazy var imagePicker : UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        return imagePicker
    }()
    
    let name : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = NSLocalizedString("write", comment: "")
        $0.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        $0.layer.cornerRadius = 60
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont(name: "Hoefler Text Italic", size: 20)
      
        return $0
    }(UITextField())

    
    let changeLanguage : UIButton = {
        let change = UIButton()
        change.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        change.translatesAutoresizingMaskIntoConstraints = false
        change.layer.cornerRadius = 60
        change.layer.masksToBounds = true
        change.titleLabel?.font = UIFont(name: "Hoefler Text Italic", size: 20)
        change.setTitle(NSLocalizedString("change", comment: ""), for: .normal)
        change.setTitleColor( .black, for: .normal)
        change.addTarget(self, action: #selector(btnChangeLangauge), for: .touchUpInside)
        
        return change
    }()
    
    let kidsMood : UILabel = {
        let kids = UILabel()
        kids.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        kids.translatesAutoresizingMaskIntoConstraints = false
        kids.font = UIFont(name: "Hoefler Text Italic", size: 20)
        kids.textColor = .black
        kids.layer.cornerRadius = 60
        kids.layer.masksToBounds = true
        kids.textAlignment = .center
        kids.text =  NSLocalizedString("mode", comment: "")
  
        return kids
    }()
    
    let kidsMoodButton : UISwitch = {
        let switchControl = UISwitch()
          switchControl.isOn = false
          switchControl.setOn(false, animated: true)
          switchControl.tintColor = .darkGray
          switchControl.isUserInteractionEnabled = true
          switchControl.translatesAutoresizingMaskIntoConstraints = false
          switchControl.addTarget(self, action: #selector(changeToKidsMood), for: .valueChanged)
          return switchControl

    }()
    
    let darkMood : UILabel = {
        let dark = UILabel()
        dark.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        dark.translatesAutoresizingMaskIntoConstraints = false
        dark.textColor = .black
        dark.font = UIFont(name: "Hoefler Text Italic", size: 20)
        dark.layer.cornerRadius = 60
        dark.layer.masksToBounds = true
        dark.textAlignment = .center
        dark.text =  NSLocalizedString("darkMode", comment: "")
       

        return dark
    }()
    
    let darkMoodButton : UISwitch = {
        let switchControl = UISwitch()
          switchControl.isOn = true
          switchControl.setOn(false, animated: true)
          switchControl.isUserInteractionEnabled = true
          switchControl.tintColor = .darkGray
          switchControl.translatesAutoresizingMaskIntoConstraints = false
          switchControl.addTarget(self, action: #selector(changeToDarkMood), for: .valueChanged)
          return switchControl

    }()
    
    let shareApp : UIButton = {
        let shareApp = UIButton()
        shareApp.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        shareApp.translatesAutoresizingMaskIntoConstraints = false
        shareApp.layer.cornerRadius = 60
        shareApp.titleLabel?.font = UIFont(name: "Hoefler Text Italic", size: 20)
        shareApp.setTitle(NSLocalizedString("share", comment: ""), for: .normal)
        shareApp.setTitleColor(.black, for: .normal)
        shareApp.addTarget(self, action: #selector(shareTheApp), for: .touchUpInside)
        
        return shareApp
    }()
    
    let signOutButton : TransitionButton = {
        var out = TransitionButton()
        out.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        out.setTitle(NSLocalizedString("signOut", comment: ""), for: .normal)
        out.setTitleColor(.black, for: .normal)
        out.titleLabel?.font = UIFont(name: "Hoefler Text Italic", size: 20)
        out.layer.cornerRadius = 60
        out.translatesAutoresizingMaskIntoConstraints = false
        out.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        
        return out
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraint()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
  
    
        self.name.delegate = self
        self.title = NSLocalizedString("profile", comment: "")
        view.backgroundColor = UIColor(named: "Color")
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
               profileImage.addGestureRecognizer(tapRecognizer)

        profileImage.addGestureRecognizer(tapRecognizer)
        profileImage.image = .init(systemName: "455")
        profileImage.tintColor = UIColor(ciColor: .black)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 100
        profileImage.contentMode = .scaleAspectFit
 
        
        view.addSubview(kidsMoodButton)
        kidsMoodButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 133).isActive = true
        kidsMoodButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -12).isActive = true
        view.addSubview(darkMoodButton)
        darkMoodButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 188).isActive = true
        darkMoodButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -12).isActive = true
        
        
           
       
        // firebase
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore()
            .document("users/\(currentUserID)")
            .addSnapshotListener{ doucument, error in
                if error != nil {
                    print (error as Any)
                    return
                }
                self.name.text = doucument?.data()?["name"] as? String
                self.profileImage.image = doucument?.data()?["image"] as? UIImage

            }
        
        guard let urlstring = UserDefaults.standard.value(forKey: "url") as? String,
            let url = URL (string: urlstring) else {
                return
        }
        
      let task = URLSession.shared.dataTask(with: url, completionHandler: {
            data, _, error in
                guard let data = data, error == nil else {
                    return
                }
            
          DispatchQueue.main.async {
              let image = UIImage(data: data)
              self.profileImage.image = image
          }
        })
        
        task.resume()
        
    }
    
    // upload image data
    // get download url
    // save download url to userDefaults
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image =  info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        storage.child("users/\(currentUserID)").putData(imageData,
                                                metadata: nil,
                                                completion: {_, error in
                               guard error == nil else {
                                   print("Faild to upload")
                                             return
                                    }
            
   self.storage.child("users/\(currentUserID)").downloadURL(completion: { url, error in
       guard let url = url, error == nil else {
           return
       }
       
       let urlString = url.absoluteString
       
       DispatchQueue.main.async {
           self.profileImage.image = image
       }
       
       print("Download URL: \(urlString)")
       UserDefaults.standard.set(urlString, forKey: "url")

            })
            
        })

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss (animated: true, completion: nil)
    }
    
    
    @objc func OpenImageLibrary(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    
    @objc func shareTheApp(sender:UIView){
           UIGraphicsBeginImageContext(view.frame.size)
           view.layer.render(in: UIGraphicsGetCurrentContext()!)
           let image = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

           let textToShare = "Check out my app"
                                           //Enter the link app here
           if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {
               let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

               //Excluded Activities
               activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]

               activityVC.popoverPresentationController?.sourceView = sender
               self.present(activityVC, animated: true, completion: nil)
           }    }
    
    
   @objc func btnChangeLangauge() {
       
       guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
               return
              }
              if UIApplication.shared.canOpenURL(settingsUrl) {
               UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
               })
              }
            }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name.resignFirstResponder()
        guard let currentUserID = Auth.auth().currentUser?.uid else {
          return true
        }
        Firestore.firestore().document("users/\(currentUserID)").setData([
            "name" : name.text ?? "",
        ], merge: true
        )
      
        return true
    }
    
    @objc func changeToKidsMood(_ sender: UISwitch!) {
        
        if (sender.isOn){
            print("on")
            let vc = MocaLockViewController.init(mocaLockType: .register)
            vc.registerDelegate = self
//            UserDefaults.standard.set(KidsMoodButton.isOn, forKey: "switchState")
            self.present(vc, animated: true, completion: nil)
        }
        else{
            print("off")
            sender.isOn = false
           

        }
        
    }
    
    func completeRegister(password: String) {
        let vc = ChildsBooks()
        vc.navigationItem.setHidesBackButton(true, animated: true)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc,animated: true)
    }
    
    @objc func changeToDarkMood(_ sender: UISwitch!) {
        if sender.isOn {
                let appDelegate = UIApplication.shared.windows.first
                  appDelegate?.overrideUserInterfaceStyle = .dark
                }else {
                  let appDelegate = UIApplication.shared.windows.first
                  appDelegate?.overrideUserInterfaceStyle = .light
                }
    }
    
    func setupConstraint() {
        view.addSubview(profileImage)
        view.addSubview(name)
        view.addSubview(changeLanguage)
        view.addSubview(kidsMood)
        view.addSubview(darkMood)
        view.addSubview(shareApp)
        view.addSubview(signOutButton)
        profileImage.addSubview(smallImage)
        view.addSubview(smallImage)
        
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
            
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            name.topAnchor.constraint(equalTo: view.topAnchor,constant: 430),
            name.heightAnchor.constraint(equalToConstant: 40),
            name.widthAnchor.constraint(equalToConstant: 300),
            
            changeLanguage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            changeLanguage.topAnchor.constraint(equalTo: view.topAnchor, constant: 480),
            changeLanguage.heightAnchor.constraint(equalToConstant: 40),
            changeLanguage.widthAnchor.constraint(equalToConstant: 300),
            
            kidsMood.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            kidsMood.topAnchor.constraint(equalTo: view.topAnchor, constant: 535),
            kidsMood.heightAnchor.constraint(equalToConstant: 40),
            kidsMood.widthAnchor.constraint(equalToConstant: 300),
        
            darkMood.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            darkMood.topAnchor.constraint(equalTo: view.topAnchor, constant: 590),
            darkMood.heightAnchor.constraint(equalToConstant: 40),
            darkMood.widthAnchor.constraint(equalToConstant: 300),
            
            shareApp.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            shareApp.topAnchor.constraint(equalTo: view.topAnchor, constant: 640),
            shareApp.heightAnchor.constraint(equalToConstant: 40),
            shareApp.widthAnchor.constraint(equalToConstant: 300),
            
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            signOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 690),
            signOutButton.heightAnchor.constraint(equalToConstant: 40),
            signOutButton.widthAnchor.constraint(equalToConstant: 300),
            
            smallImage.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 150),
            smallImage.leftAnchor.constraint(equalTo: profileImage.leftAnchor, constant: 135),
            smallImage.heightAnchor.constraint(equalToConstant: 50),
            smallImage.widthAnchor.constraint(equalToConstant: 50),
            
        ])

    }

    @objc func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.signOutButton.startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.signOutButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 0 ) {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        let vc = LoginVC()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
           
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
         
        }
    }
    
    @objc func imageTapped() {
        print("Image Tapped")
        present(imagePicker, animated: true)
       }
    
    
    private func setupGradientView3() {
        let _ = GradientView(self)
    }
    

}  

