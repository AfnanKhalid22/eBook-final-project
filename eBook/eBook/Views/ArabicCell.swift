//
//  ArabicCell.swift
//  eBook
//
//  Created by Fno Khalid on 19/04/1443 AH.
//

import UIKit
import FirebaseFirestore
import SwiftEntryKit


class ArabicCell: UICollectionViewCell {
    
    static let identfir = "cell"
    
     var book: Book!
     var fav: Fav!
     var isActive: Bool = false
  
     let bookImage: UIImageView = {
        let bookImage = UIImageView()
         bookImage.translatesAutoresizingMaskIntoConstraints = false
         bookImage.clipsToBounds = false
         bookImage.layer.shadowColor = UIColor.black.cgColor
         bookImage.layer.shadowOpacity = 9.0
         bookImage.layer.shadowRadius = 10
         bookImage.contentMode = .scaleAspectFit
         bookImage.layer.cornerRadius = 20
        
                return bookImage
    }()
    
     let nameLabel: UILabel = {
        let namebook = UILabel()
         namebook.translatesAutoresizingMaskIntoConstraints = false
          namebook.font = UIFont(name: "AvenirNextCondensed-Medium", size: 23.0)
          namebook.textColor = UIColor(named: "textColor")
          namebook.textAlignment = .right
       
        return namebook
        
    }()
    
    let autherLabel: UILabel = {
       let auther = UILabel()
        auther.translatesAutoresizingMaskIntoConstraints = false
         auther.font = UIFont(name: "Semibold", size: 16.0)
         auther.textColor = UIColor(named: "textColor")
         auther.textAlignment = .right
      
       return auther
       
   }()
    
    
    let categoryLabel: UILabel = {
       let category = UILabel()
        category.translatesAutoresizingMaskIntoConstraints = false
        category.font = UIFont(name: "Light-Italic", size: 14.0)
        category.textColor = UIColor(named: "textColor")
        category.textAlignment = .right
      
       return category
       
   }()
    
    private let favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "heart1"), for: .normal)
        button.addTarget(self, action: #selector(addfavoriteBook), for: .touchUpInside)
    
        return button
    }()
    
    @objc func addfavoriteBook() {
        print("hi")
        if isActive {
            isActive = false
            favButton.setImage(UIImage(named: "heart1"), for: .normal)
    

        } else {

               isActive = true
                favButton.setImage(UIImage(named: "heart2"), for: .normal)
            
            let alertcontroller = UIAlertController(title: NSLocalizedString("Amazing", comment: "")
                , message: NSLocalizedString("The book in favorite now", comment: "")
                    , preferredStyle: UIAlertController.Style.alert
            )
   
            
            UIApplication.shared.keyWindow?.rootViewController?.present(alertcontroller, animated: true, completion: nil)
            alertcontroller.view.superview?.isUserInteractionEnabled = false
            alertcontroller.dismiss(animated: true, completion: nil)
        }
        
        let bookname = nameLabel.text ?? ""
        _ = bookImage.image ?? UIImage(systemName: "house")
        FavoriteService.shared.addToFavorite(favBook: Fav(image: book.image, name: bookname))
        
//        let alertcontroller = UIAlertController(title: NSLocalizedString("Amazing", comment: "")
//            , message: NSLocalizedString("The book in favorite now", comment: "")
//                , preferredStyle: UIAlertController.Style.alert
//        )
//
//      alertcontroller.addAction(
//       UIAlertAction(title: NSLocalizedString("OK", comment: ""),
//          style: UIAlertAction.Style.default,
//                handler: { Action in print("...")
//            })
//
//        )
//
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertcontroller, animated: true, completion: nil)
//        alertcontroller.view.superview?.isUserInteractionEnabled = true
      //  alertcontroller.dismiss(animated: false, completion: nil)
//        alertcontroller.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        
    }
    
    func addAlert() {
        // Create a basic toast that appears at the top
        var attributes = EKAttributes.topToast
        let title = EKProperty.LabelContent(text: "Amazing", style: .init(font: UIFont(), color: .clear, alignment: .center, displayMode: .dark, numberOfLines: 1), accessibilityIdentifier: "")
//        (text: "the book is deleted", style: .init(font: UIFont(name: "Light-Italic", size: 20) ?? "", color: .clear))
        let description =  EKProperty.LabelContent(text: "the book in favourite now", style: .init(font: UIFont(), color: .clear, alignment: .center, displayMode: .light, numberOfLines: 1), accessibilityIdentifier: "")
//        (text: "descText", style: .init(font: UIFont(name: "Light-Italic", size: 20)!, color: .clear))
//        let image = EKProperty.ImageContent(image: UIImage(named: "imageName")!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)


        // Set its background to white
        attributes.entryBackground = .color(color: .white)
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor(.red), EKColor(.green)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: CGFloat(UIScreen.main.maximumFramesPerSecond)), height: .intrinsic)
        


        // Animate in and out using default translation
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation

        let customView = UIView()
        /*
        ... Customize the view as you like ...
        */

        // Display the view with the configuration
        SwiftEntryKit.display(entry: customView, using: attributes)
        
        SwiftEntryKit.dismiss()
    
    }
    
    
    func checkFavoriteBook(bookname: String) -> Bool {
        return book?.name.contains(bookname) ?? false
    }
    
     func setCell(book: Book) {
        
         bookImage.image = UIImage(named: book.image)
         nameLabel.text = book.name
         autherLabel.text = book.by
         categoryLabel.text = book.category
              self.book = book
//
//        let isBookFavorite = checkFavoriteBook(bookname: book.name)
//        if isBookFavorite {
//            favButton.setImage(UIImage(named: "heart2"), for: .normal)
//        }else {
//            favButton.setImage(UIImage(named: "heart1"), for: .normal)
//        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
        contentView.addSubview(bookImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(autherLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(favButton)
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // x: right and left
        // y: up and down
        
//        bookImage.frame = CGRect(x: 120, y: 15, width: 180, height: 190)
//        nameLabel.frame = CGRect(x: -80, y: contentView.frame.size.height - 210, width: contentView.frame.size.width - 5, height: 40)
//        autherLabel.frame = CGRect(x: -75, y: contentView.frame.size.height - 150, width: contentView.frame.size.width - 5, height: 40)
//        categoryLabel.frame = CGRect(x: -15, y: contentView.frame.size.height - 100, width: 130, height: 40)
//        favButton.frame = CGRect(x: -50, y: contentView.frame.size.height - 100, width: 45, height: 45)
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 16),
            bookImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 140),
            bookImage.heightAnchor.constraint(equalToConstant: 140),
            bookImage.widthAnchor.constraint(equalToConstant: 140),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -80),
       
            autherLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            autherLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -80),
            
            categoryLabel.topAnchor.constraint(equalTo: autherLabel.bottomAnchor, constant: 20),
            categoryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -80),

            favButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 180),
            favButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -80),
            favButton.heightAnchor.constraint(equalToConstant: 40),
            favButton.widthAnchor.constraint(equalToConstant: 40)

        ])
       
    }
    
}
