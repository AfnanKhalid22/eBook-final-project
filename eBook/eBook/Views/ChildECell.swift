//
//  ChildECell.swift
//  eBook
//
//  Created by Fno Khalid on 02/05/1443 AH.
//

import UIKit
import FirebaseFirestore


class ChildECell: UICollectionViewCell {
    
    static let identfir = "childEnglishCell"
    
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
          namebook.font = UIFont(name: "AvenirNextCondensed-Medium", size: 23.0)
          namebook.textColor = UIColor(named: "textColor")
          namebook.textAlignment = .center
       
        return namebook
        
    }()
    
    
    let autherLabel: UILabel = {
       let auther = UILabel()
         auther.translatesAutoresizingMaskIntoConstraints = false
         auther.font = UIFont(name: "Semibold", size: 16.0)
         auther.textColor = UIColor(named: "textColor")
         auther.textAlignment = .center
      
       return auther
       
   }()
    
    
    let categoryLabel: UILabel = {
       let category = UILabel()
        category.translatesAutoresizingMaskIntoConstraints = false
        category.font = UIFont(name: "Light-Italic", size: 16.0)
        category.textColor = UIColor(named: "textColor")
        category.textAlignment = .center
      
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
        
//        bookImage.frame = CGRect(x: -70, y: 15, width: 180, height: 190)
//        nameLabel.frame = CGRect(x: 80, y: contentView.frame.size.height - 200, width: contentView.frame.size.width - 5, height: 40)
//        autherLabel.frame = CGRect(x: 80, y: contentView.frame.size.height - 150, width: contentView.frame.size.width - 5, height: 40)
//        categoryLabel.frame = CGRect(x: 100, y: contentView.frame.size.height - 100, width: 130, height: 40)
//        favButton.frame = CGRect(x: 220, y: contentView.frame.size.height - 100, width: 40, height: 40)
        
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
