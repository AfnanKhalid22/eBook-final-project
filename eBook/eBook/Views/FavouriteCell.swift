//
//  FavouriteCell.swift
//  eBook
//
//  Created by Fno Khalid on 20/04/1443 AH.
//

import UIKit


class FavouriteCell: UITableViewCell {
    
    var fBook = [Book]()
    
    static let identfir = "Fav"
    
    
     let bookImage2: UIImageView = {
        let bookImage = UIImageView()
           
           bookImage.layer.borderWidth = 1
           bookImage.layer.borderColor = .init(red: 230/255, green: 237/255, blue: 184/255, alpha: 1)
           bookImage.clipsToBounds = false
           bookImage.layer.shadowColor = UIColor.black.cgColor
           bookImage.layer.shadowOpacity = 9.0
           bookImage.layer.shadowRadius = 10
           bookImage.layer.masksToBounds = false
        
        
              return bookImage
    }()
    
    
     let nameLabel2: UILabel = {
        let namebook = UILabel()
    
         namebook.font = UIFont(name: "AvenirNextCondensed-Medium", size: 20.0)
         namebook.textColor = UIColor(named: "textColor")
         namebook.textAlignment = .center
         namebook.layer.cornerRadius = 20
         namebook.layer.masksToBounds = true
    //     namebook.backgroundColor = UIColor(red: 230/255, green: 213/255, blue: 197/255, alpha: 0.5)
        
        return namebook
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bookImage2)
        contentView.addSubview(nameLabel2)
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // x: right and left
        // y: up and down

        nameLabel2.frame = CGRect(x: -10,
                   y: 10,
                   width: 300,
                   height: contentView.frame.size.height-20)
        bookImage2.frame = CGRect(x: 250,
                   y: 35,
                   width: 130,
                   height:155)
      }
}

