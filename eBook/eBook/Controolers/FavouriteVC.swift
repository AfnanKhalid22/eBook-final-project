//
//  FavouriteVC.swift
//  eBook
//
//  Created by Fno Khalid on 18/04/1443 AH.
//

import UIKit
import FirebaseFirestore
import SwiftEntryKit


class FavouriteVC : UIViewController, UITableViewDelegate, UITableViewDataSource {

    var books: Book?
    
    var fBook: Array<Fav> = []
    
    var selectedIndex = -1
    
    lazy  var bookTV: UITableView = {
          let tableV = UITableView()
          tableV.translatesAutoresizingMaskIntoConstraints = false
          tableV.delegate = self
          tableV.dataSource = self
          tableV.register(FavouriteCell.self, forCellReuseIdentifier: "Fav")
          tableV.isHidden = false
          tableV.backgroundColor = UIColor(named: "Color")// UIColor(red: 230/255, green: 213/255, blue: 197/255, alpha: 0.5)
        tableV.alwaysBounceHorizontal = false
          
          return tableV
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 230/255, green: 213/255, blue: 197/255, alpha: 0.5)
        self.title = NSLocalizedString("favPage", comment: "")
        view.reloadInputViews()
        
        view.addSubview(bookTV)
        NSLayoutConstraint.activate([
            bookTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            bookTV.topAnchor.constraint(equalTo: view.topAnchor),
            bookTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            bookTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        FavoriteService.shared.listenToFavoriteBook { favBook in
                       self.fBook = favBook
                       self.bookTV.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fav", for: indexPath) as! FavouriteCell
        
        let a = fBook[indexPath.row]
        
        cell.nameLabel2.text = a.name
        cell.bookImage2.image = UIImage(named: a.image)
    
        cell.backgroundColor = UIColor(named: "Color")//UIColor(red: 230/255, green: 213/255, blue: 197/255, alpha: 0.5)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("bookname")

        let fb = fBook[indexPath.row]
        let pdfVC = pdfBook()

        pdfVC.openedBook = fb.name
        pdfVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(pdfVC,animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex {
          return 354
        }else {
          return 190
        }
      }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        
        let fb = fBook[indexPath.row]
        let alertcontroller = UIAlertController(title: NSLocalizedString("delete", comment: "")
            , message: NSLocalizedString("areYou?", comment: "")
                , preferredStyle: UIAlertController.Style.alert
        )
        
      alertcontroller.addAction(
       UIAlertAction(title: NSLocalizedString("cancel", comment: ""),
          style: UIAlertAction.Style.default,
                handler: { Action in print("...")
            })
            
        )
        
    alertcontroller.addAction(
        UIAlertAction(title: NSLocalizedString("d", comment: ""),
                style: UIAlertAction.Style.destructive,
                handler: { Action in
                if editingStyle == .delete {
                    
                    print(fb.name)
                    Firestore.firestore().collection("Favorite").document(fb.name).delete()
                    

                }
                self.bookTV.reloadData()
            })
            
        )
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }
    
}

