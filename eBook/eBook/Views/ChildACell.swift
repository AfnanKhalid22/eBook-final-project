//
//  ChildCell.swift
//  eBook
//
//  Created by Fno Khalid on 02/05/1443 AH.
//

import UIKit
import FirebaseFirestore

    var childFavoritBook: [Book] = []

class ChildACell: UICollectionViewCell {
    
    static let identfir = "childCell"
    
     var book: Book!
    
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
          namebook.font = UIFont(name: "AvenirNextCondensed-Medium", size: 20.0)
          namebook.textColor = UIColor(named: "textColor")
          namebook.textAlignment = .left
       
        return namebook
        
    }()
    
    let autherLabel: UILabel = {
       let auther = UILabel()
        auther.translatesAutoresizingMaskIntoConstraints = false
         auther.font = UIFont(name: "Semibold", size: 16.0)
         auther.textColor = UIColor(named: "textColor")
         auther.textAlignment = .left
      
       return auther
       
   }()
    
    let categoryLabel: UILabel = {
       let category = UILabel()
        category.translatesAutoresizingMaskIntoConstraints = false
        category.font = UIFont(name: "Light-Italic", size: 16.0)
        category.textColor = UIColor(named: "textColor")
        category.textAlignment = .left
      
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
    }
    
    func setCell(book: Book) {
        bookImage.image = UIImage(named: book.image)
        nameLabel.text = book.name
        autherLabel.text = book.by
        categoryLabel.text = book.category
        self.book = book
        
        
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
