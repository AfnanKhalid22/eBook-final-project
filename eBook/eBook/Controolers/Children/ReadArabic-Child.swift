//
//  ReadArabic-Child.swift
//  eBook
//
//  Created by Fno Khalid on 02/05/1443 AH.
//

import UIKit
import AVFoundation


class ReadArabicChild: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
     var childBooks: Book?
    var player2: AVAudioPlayer?
    var oldTabbarFr: CGRect = .zero
     

    lazy var tableView1: UITableView = {
        let tablaView = UITableView()
        tablaView.translatesAutoresizingMaskIntoConstraints = false
        tablaView.delegate = self
        tablaView.dataSource = self
        tablaView.register(BookChildCell1.self, forCellReuseIdentifier: "bookChildCell")
        tablaView.backgroundColor = UIColor(named: "Color")
        return tablaView
      }()
    
    let openBook: UIButton = {
       let read = UIButton()
      
        read.translatesAutoresizingMaskIntoConstraints = false
        read.setTitleColor(.black, for: .normal)
        read.setImage(UIImage(named: "readBook"), for: .normal)
        read.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        read.layer.borderColor = UIColor.darkGray.cgColor
        read.layer.borderWidth = 3.0
        read.layer.cornerRadius = 20
        read.layer.masksToBounds = true
        read.addTarget(self, action: #selector(readChildBook1), for: .touchUpInside)
       
       return read
       
   }()
    
    let shareBook: UIButton = {
       let share = UIButton()
      
        share.translatesAutoresizingMaskIntoConstraints = false
        share.setTitleColor(.black, for: .normal)
        share.setImage(UIImage(named: "headphone"), for: .normal)
       share.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        share.layer.borderColor = UIColor.darkGray.cgColor
        share.layer.borderWidth = 3.0
        share.layer.cornerRadius = 20
        share.layer.masksToBounds = true
        share.addTarget(self, action: #selector(audioBook2), for: .touchUpInside)

       return share
       
   }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView1)
        view.addSubview(openBook)
        view.addSubview(shareBook)
   
        view.backgroundColor = UIColor(named: "Color")
        
        NSLayoutConstraint.activate([
            
            // x: right and left
            // y: up and down
            
            tableView1.topAnchor.constraint(equalTo: view.topAnchor),
            tableView1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView1.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView1.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            openBook.widthAnchor.constraint(equalToConstant: 100),
            openBook.heightAnchor.constraint(equalToConstant: 100),
            openBook.bottomAnchor.constraint(equalTo: tableView1.bottomAnchor,constant: -100),
            openBook.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70),

            shareBook.widthAnchor.constraint(equalToConstant: 100),
            shareBook.heightAnchor.constraint(equalToConstant: 100),
            shareBook.topAnchor.constraint(equalTo: tableView1.bottomAnchor,constant: -200),
            shareBook.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),
            
        ])
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childBooks?.BooksInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookChildCell", for: indexPath) as! BookChildCell1
        let b = childBooks!.BooksInfo[indexPath.row]
        

        cell.childnameLabel.text = b.bookName
        cell.childbookImage.image = UIImage(named: b.bookImage)
        cell.bookAuther.text = b.auther
        cell.childPagesN.text = b.pageNumber
        cell.backgroundColor = UIColor(named: "Color")
      
        
        
        return cell
    }
    
    var selectedIndex = -1
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          if indexPath.row == selectedIndex {
            return 354
          }else {
            return 500
          }
        }
    
    @objc func readChildBook1() {
        
        let pdfVC = pdfBook()
        
        pdfVC.openedBook = childBooks?.name
        pdfVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(pdfVC,animated: true)
   }
    
    
    @objc func audioBook2 (_ sender: Any) {
        let audioVC = AudioBookVC(audioBook:
                                    Book(image: childBooks?.image ?? "",
                                    name: childBooks?.name ?? "",
                                    by: childBooks?.by ?? "",
                                    category: childBooks?.category ?? "" ,
                                    BooksInfo:
                                    [BookInformation(
                                    bookImage: "",
                                    bookName: "",
                                    auther: "",
                                    pageNumber: "")]))

        present(audioVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.frame = .zero
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.frame = oldTabbarFr
    }
}

class BookChildCell1: UITableViewCell {
    
  static let identifier = "bookChildCell"
    
     let childbookImage: UIImageView = {
        let bookImage = UIImageView()
         bookImage.clipsToBounds = false
         bookImage.layer.shadowColor = UIColor.black.cgColor
         bookImage.layer.shadowOpacity = 25.0
         bookImage.layer.shadowRadius = 10
         bookImage.layer.cornerRadius = 20
         bookImage.contentMode = .scaleAspectFill
 
        
        return bookImage
    }()
    
     let childnameLabel: UILabel = {
          let namebook = UILabel()
            namebook.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)
            namebook.textAlignment = .center
//            namebook.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
//            namebook.layer.cornerRadius = 20
//            namebook.layer.borderColor = UIColor.darkGray.cgColor
//            namebook.layer.borderWidth = 3.0
            namebook.textColor = UIColor(named: "textColor")
            namebook.layer.masksToBounds = true
        
                     return namebook
        
    }()
    
    let bookAuther: UILabel = {
       let auther = UILabel()

         auther.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)
         auther.textColor = UIColor(named: "textColor")
         auther.textAlignment = .center
//         auther.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
//         auther.layer.borderColor = UIColor.darkGray.cgColor
//         auther.layer.borderWidth = 3.0
//         auther.layer.cornerRadius = 20
         auther.layer.masksToBounds = true
       
            return auther
       
   }()
    
    let childPagesN: UILabel = {
       let num = UILabel()
         num.text = ""
         num.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)
         num.textColor = UIColor(named: "textColor")
         num.textAlignment = .center
//         num.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
//         num.layer.borderColor = UIColor.darkGray.cgColor
//         num.layer.borderWidth = 3.0
//         num.layer.cornerRadius = 20
         num.layer.masksToBounds = true
       
             return num
       
   }()
    


 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)

             contentView.addSubview(childbookImage)
             contentView.addSubview(childnameLabel)
             contentView.addSubview(bookAuther)
             contentView.addSubview(childPagesN)
       
        
              contentView.clipsToBounds = true
              contentView.backgroundColor = UIColor(named: "Color")
   
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not implement>>>")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // x: right and left
        // y: up and down
        
        childbookImage.frame = CGRect(x: 100,
                               y: 10 ,
                               width: 190,
                               height: 300)
        childnameLabel.frame = CGRect(x: 70,
                                   y: 340 ,
                               width: 250,
                               height: 40)
        bookAuther.frame = CGRect(x: 70,
                                   y: 390 ,
                               width: 250,
                               height: 40)
        childPagesN.frame = CGRect(x: 100,
                                   y: 440 ,
                               width: 200,
                               height: 40)
      
        
        
    }

}


