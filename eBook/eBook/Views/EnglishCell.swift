//
//  EnglishCell.swift
//  eBook
//
//  Created by Fno Khalid on 19/04/1443 AH.
//

import UIKit


class EnglishCell: UICollectionViewCell {
    
    
    static let identfir = "cell2"
    
    var englishBook: Book!
    
    var isActive2: Bool = false
  
    private let bookImage: UIImageView = {
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
    
    private let nameLabel: UILabel = {
        let namebook = UILabel()
        namebook.translatesAutoresizingMaskIntoConstraints = false
        namebook.font = UIFont(name: "AvenirNextCondensed-Medium", size: 20.0)
        namebook.textAlignment = .center
        namebook.textColor = UIColor(named: "textColor")
        
        return namebook
        
    }()
    
    let autherLabel: UILabel = {
       let auther = UILabel()
        auther.translatesAutoresizingMaskIntoConstraints = false
        auther.font = UIFont(name: "AvenirNextCondensed-Medium", size: 18.0) //UIFont(name: "Semibold", size: 8.0)
         auther.textColor = UIColor(named: "textColor")
         auther.textAlignment = .center
      
       return auther
       
   }()
    
    
    let categoryLabel: UILabel = {
       let category = UILabel()
        category.translatesAutoresizingMaskIntoConstraints = false
        category.font = UIFont(name: "Light-Italic", size: 14.0)
        category.textColor = UIColor(named: "textColor")
        category.textAlignment = .center
      
       return category
       
   }()
    
    private let favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heart1"), for: .normal)
        button.addTarget(self, action: #selector(favorite2), for: .touchUpInside)

        return button
    }()
    
//    private let favButton: UIImageView = {
//        let button = UIImageView()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isUserInteractionEnabled = true
//        button.layer.cornerRadius = 20
//        button.layer.masksToBounds = true
//        let tap = UITapGestureRecognizer(target: self, action:  #selector(favorite2))
//        button.addGestureRecognizer(tap)
//
//        return button
//    }()
    
    @objc func favorite2() {

        if isActive2 {
            isActive2 = false
            favButton.setImage(UIImage(named: "heart1"), for: .normal)
        } else {
               isActive2 = true
                favButton.setImage(UIImage(named: "heart2"), for: .normal)
            
            let alertcontroller = UIAlertController(title: NSLocalizedString("Amazing", comment: "")
                , message: NSLocalizedString("The book in favorite now", comment: "")
                    , preferredStyle: UIAlertController.Style.alert
            )
   
            
            UIApplication.shared.keyWindow?.rootViewController?.present(alertcontroller, animated: true, completion: nil)
            alertcontroller.view.superview?.isUserInteractionEnabled = false
            alertcontroller.dismiss(animated: true, completion: nil)
        }
            
            let name2 = nameLabel.text ?? ""
            _ = bookImage.image ?? UIImage(systemName: "house")
            
            FavoriteService.shared.addToFavorite(favBook: Fav(image: englishBook.image, name: name2))

        }
        
//    func favouriteButtonState() {
//        if ( UserDefaults.standard.bool(forKey: "heart")) {
//            favButton.image = UIImage(named: "heart2")
//        } else {
//            favButton.image = UIImage(named: "heart1")
//        }
//    }
    
    func setCell2(book2: Book) {
        bookImage.image = UIImage(named: book2.image)
        nameLabel.text = book2.name
        autherLabel.text = book2.by
        categoryLabel.text = book2.category
        self.englishBook = book2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bookImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(autherLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(favButton)
      //  favouriteButtonState()
        contentView.clipsToBounds = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // x: right and left
        // y: up and down
        
//        bookImage2.frame = CGRect(x: -80, y: 15, width: 180, height: 190)
//        nameLabel2.frame = CGRect(x: 85, y: contentView.frame.size.height - 210, width: contentView.frame.size.width - 5, height: 40)
//        autherLabel.frame = CGRect(x: 75, y: contentView.frame.size.height - 150, width: contentView.frame.size.width - 5, height: 40)
//        categoryLabel.frame = CGRect(x: 95, y: contentView.frame.size.height - 100, width: 130, height: 40)
//        favButton2.frame = CGRect(x: 230, y: contentView.frame.size.height - 100, width: 40, height: 40)
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 16),
            bookImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -130),
            bookImage.heightAnchor.constraint(equalToConstant: 140),
            bookImage.widthAnchor.constraint(equalToConstant: 140),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 90),
       
            autherLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            autherLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 90),
            
            categoryLabel.topAnchor.constraint(equalTo: autherLabel.bottomAnchor, constant: 20),
            categoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 90),

            favButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 180),
            favButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 90),
            favButton.heightAnchor.constraint(equalToConstant: 40),
            favButton.widthAnchor.constraint(equalToConstant: 40)

        ])
      
       
    }
}


