//
//  Book1.swift
//  eBook
//
//  Created by Fno Khalid on 19/04/1443 AH.
//

import UIKit
import AVFoundation


class ReadArabicBook: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
     var books: Book?
    
     var oldTabbarFr: CGRect = .zero
     

    lazy var tableView1: UITableView = {
        let tablaView = UITableView()
        tablaView.translatesAutoresizingMaskIntoConstraints = false
        tablaView.delegate = self
        tablaView.dataSource = self
        tablaView.register(BookCell1.self, forCellReuseIdentifier: BookCell1.identifier)
        tablaView.backgroundColor = UIColor(named: "Color")
        return tablaView
      }()
    
    let openBook: UIButton = {
       let read = UIButton()
     //   82, 108, 154, 1
        read.translatesAutoresizingMaskIntoConstraints = false
        read.setTitleColor(.black, for: .normal)
        read.setImage(UIImage(named: "readBook"), for: .normal)
        read.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        read.layer.borderColor = UIColor.darkGray.cgColor
        read.layer.borderWidth = 3.0
        read.layer.cornerRadius = 30
        read.layer.masksToBounds = true
        read.addTarget(self, action: #selector(readBook1), for: .touchUpInside)
       
       return read
       
   }()
    
  //  rgb(240,124,124)
    
    let listenBook: UIButton = {
       let listen = UIButton()
      
        listen.translatesAutoresizingMaskIntoConstraints = false
        listen.setTitleColor(.black, for: .normal)
        listen.setImage(UIImage(named: "headphone"), for: .normal)
        listen.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        listen.layer.borderColor = UIColor.darkGray.cgColor
        listen.layer.borderWidth = 3.0
        listen.layer.cornerRadius = 35
        listen.layer.masksToBounds = true
        listen.addTarget(self, action: #selector(audioBook), for: .touchUpInside)

       return listen
       
   }()
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView1)
        view.addSubview(openBook)
        view.addSubview(listenBook)
    
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

            listenBook.widthAnchor.constraint(equalToConstant: 100),
            listenBook.heightAnchor.constraint(equalToConstant: 100),
            listenBook.topAnchor.constraint(equalTo: tableView1.bottomAnchor,constant: -200),
            listenBook.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),


        ])
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.BooksInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookCell1
        
        let b = books!.BooksInfo[indexPath.item]
        
        cell.nameLabel11.text = b.bookName
        cell.bookImage11.image = UIImage(named: b.bookImage)
        cell.auther.text = b.auther
        cell.pagesN.text = b.pageNumber
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
    
    @objc func readBook1() {

        let pdfVC = pdfBook()
        pdfVC.openedBook = books?.name
        pdfVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(pdfVC,animated: true)
   }

    @objc func audioBook() {
    
        
        let audioVC = AudioBookVC(audioBook:
                                    Book(image: books?.image ?? "",
                                    name: books?.name ?? "",
                                    by: books?.by ?? "",
                                    category: books?.category ?? "" ,
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

class BookCell1: UITableViewCell {
    
  static let identifier = "bookCell"
    
     let bookImage11: UIImageView = {
        let bookImage = UIImageView()
         bookImage.clipsToBounds = false
         bookImage.layer.shadowColor = UIColor.black.cgColor
         bookImage.layer.shadowOpacity = 25.0
         bookImage.layer.shadowRadius = 10
         bookImage.layer.cornerRadius = 20
         bookImage.contentMode = .scaleAspectFill
 
        
        return bookImage
    }()
    
     let nameLabel11: UILabel = {
          let namebook = UILabel()
            namebook.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)
            namebook.textAlignment = .center
            namebook.textColor = UIColor(named: "textColor")
            namebook.layer.masksToBounds = true
        
                     return namebook
        
    }()
    
    let auther: UILabel = {
       let auther = UILabel()

         auther.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)
         auther.textColor = UIColor(named: "textColor")
         auther.textAlignment = .center
         auther.layer.masksToBounds = true
       
            return auther
       
   }()
    
    let pagesN: UILabel = {
       let num = UILabel()
         num.text = ""
         num.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)
         num.textColor = UIColor(named: "textColor")
         num.textAlignment = .center
         num.layer.masksToBounds = true
       
             return num
       
   }()
    


 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)

             contentView.addSubview(bookImage11)
             contentView.addSubview(nameLabel11)
             contentView.addSubview(auther)
             contentView.addSubview(pagesN)
       
        
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
        
        
        bookImage11.frame = CGRect(x: 100,
                               y: 10 ,
                               width: 190,
                               height: 300)
        nameLabel11.frame = CGRect(x: 70,
                                   y: 340 ,
                               width: 250,
                               height: 40)
        auther.frame = CGRect(x: 70,
                                   y: 390 ,
                               width: 250,
                               height: 40)
        pagesN.frame = CGRect(x: 100,
                                   y: 440 ,
                               width: 200,
                               height: 40)
      
        
        
    }

}
