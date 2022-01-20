//
//  Book2.swift
//  eBook
//
//  Created by Fno Khalid on 22/04/1443 AH.
//

import UIKit


class ReadEnglishBook: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var booksE: Book?
    var oldTabbarFr: CGRect = .zero

    lazy var tableView2: UITableView = {
        let t = UITableView()
          t.translatesAutoresizingMaskIntoConstraints = false
          t.delegate = self
          t.dataSource = self
          t.register(BookCell2.self, forCellReuseIdentifier: BookCell2.identifier)
          t.backgroundColor = UIColor(named: "Color")
        
                return t
      }()
    
    let openBook: UIButton = {
       let read = UIButton()
      
         read.translatesAutoresizingMaskIntoConstraints = false
         read.setTitleColor(.black, for: .normal)
         read.setImage(UIImage(named: "readBook"), for: .normal)
         read.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
         read.layer.borderColor = UIColor.darkGray.cgColor
         read.layer.borderWidth = 3.0
         read.layer.cornerRadius = 30
         read.layer.masksToBounds = true
         read.addTarget(self, action: #selector(readBook), for: .touchUpInside)
       
                return read
       
   }()
    
    let listenEBook: UIButton = {
       let listen = UIButton()
      
        listen.translatesAutoresizingMaskIntoConstraints = false
        listen.setTitleColor(.black, for: .normal)
        listen.setImage(UIImage(named: "headphone"), for: .normal)
        listen.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        listen.layer.borderColor = UIColor.darkGray.cgColor
        listen.layer.borderWidth = 3.0
        listen.layer.cornerRadius = 35
        listen.layer.masksToBounds = true
        listen.addTarget(self, action: #selector(audioPressed2), for: .touchUpInside)

       return listen
       
   }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView2)
        view.addSubview(openBook)
        view.addSubview(listenEBook)
        view.backgroundColor = UIColor(named: "Color")
        
        NSLayoutConstraint.activate([
            tableView2.topAnchor.constraint(equalTo: view.topAnchor),
            tableView2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView2.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView2.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            // x: right and left
            // y: up and down
            openBook.widthAnchor.constraint(equalToConstant: 100),
            openBook.heightAnchor.constraint(equalToConstant: 100),
            openBook.bottomAnchor.constraint(equalTo: tableView2.bottomAnchor,constant: -100),
            openBook.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70),

            listenEBook.widthAnchor.constraint(equalToConstant: 100),
            listenEBook.heightAnchor.constraint(equalToConstant: 100),
            listenEBook.topAnchor.constraint(equalTo: tableView2.bottomAnchor,constant: -200),
            listenEBook.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),

            
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksE?.BooksInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView2.dequeueReusableCell(withIdentifier: "EbookCell", for: indexPath) as! BookCell2
        
        let b = booksE!.BooksInfo[indexPath.item]
        
           cell.nameLabelE.text = b.bookName
           cell.bookImageE.image = UIImage(named: b.bookImage)
           cell.autherE.text = b.auther
           cell.pagesNE.text = b.pageNumber
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
    
    
    
    
    @objc func readBook() {
        
        let pdfVC = pdfBook()
        pdfVC.openedBook = booksE?.name
        pdfVC.navigationItem.largeTitleDisplayMode = .never
           navigationController?.pushViewController(pdfVC,animated: true)
      
   }
    
    //share
   @objc func audioPressed2(_ sender: Any) {
       let alertcontroller = UIAlertController(title: "Soon", message: "",
                                               preferredStyle: UIAlertController.Style.alert
       )
       alertcontroller.addAction(
        UIAlertAction(title: NSLocalizedString("cancel", comment: ""),
           style: UIAlertAction.Style.default,
                 handler: { Action in print("...")
             })
             
         )
       self.present(alertcontroller, animated: true, completion: nil)
         

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

class BookCell2: UITableViewCell {
    
  static let identifier = "EbookCell"
    
    let pdfTitle = Date()
    
     let bookImageE: UIImageView = {
        let bookImage = UIImageView()
          bookImage.clipsToBounds = false
          bookImage.layer.shadowColor = UIColor.black.cgColor
          bookImage.layer.shadowOpacity = 25.0
          bookImage.layer.shadowRadius = 10
          bookImage.layer.cornerRadius = 20
          bookImage.contentMode = .scaleAspectFill
          bookImage.backgroundColor = UIColor(named: "Color")

             return bookImage
    }()
    
     let nameLabelE: UILabel = {
        let namebook = UILabel()
           namebook.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)
           namebook.textAlignment = .center
           namebook.textColor = UIColor(named: "textColor")
           namebook.layer.masksToBounds = true
        
                 return namebook
        
    }()
    
    let autherE: UILabel = {
       let auther = UILabel()

          auther.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)
          auther.textColor = UIColor(named: "textColor")
          auther.textAlignment = .center
          auther.layer.masksToBounds = true
       
              return auther
       
   }()
    
    let pagesNE: UILabel = {
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

        contentView.addSubview(bookImageE)
        contentView.addSubview(nameLabelE)
        contentView.addSubview(autherE)
        contentView.addSubview(pagesNE)
       
        
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
        
        bookImageE.frame = CGRect(x: 100,
                               y: 10 ,
                               width: 190,
                               height: 300)
        nameLabelE.frame = CGRect(x: 25,
                                   y: 340 ,
                               width: 350,
                               height: 40)
        autherE.frame = CGRect(x: 70,
                                   y: 390 ,
                               width: 250,
                               height: 40)
        pagesNE.frame = CGRect(x: 100,
                                   y: 440 ,
                               width: 200,
                               height: 40)
      
        
        
    }

}

