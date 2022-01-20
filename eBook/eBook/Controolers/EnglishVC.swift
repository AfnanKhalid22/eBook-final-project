//
//  EnglishVC.swift
//  eBook
//
//  Created by Fno Khalid on 18/04/1443 AH.
//

import UIKit

class EnglishVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    var oldTabbarFr: CGRect = .zero
    let cellId = "PeopleCell"
    var bookEE: Book?
    var english: [Book] = []
    lazy var searchBar:UISearchBar = UISearchBar()

    var searchBook: Array<Book> = bookList2
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          if searchText.isEmpty {
              searchBook = bookList2
          } else {
            searchBook = searchBook.filter({ oneBook in
              return oneBook.name.starts(with: searchText)
            })
          }
        collectionView.reloadData()
        }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color")
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EnglishCell.self,
        forCellWithReuseIdentifier: "cell2")
        setupCollectionConstraints()
        collectionView.frame = view.bounds
        
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        oldTabbarFr = self.tabBarController?.tabBar.frame ?? .zero
        
        
      
    }
    
    let collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
              layout.minimumLineSpacing = 0
              layout.minimumInteritemSpacing = 0
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
               cv.backgroundColor = UIColor(named: "Color")
         
           return cv
       }()
    
    
    func setupCollectionConstraints() {
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
          collectionView.heightAnchor.constraint(equalToConstant: 550).isActive = true
          collectionView.widthAnchor.constraint(equalToConstant: 350).isActive = true
          collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
          collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchBook.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! EnglishCell
        cell.setCell2(book2: bookList2[indexPath.row] )
        
        cell.backgroundColor = UIColor(named: "Color")

                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 200, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newVC = ReadEnglishBook()
        newVC.title = bookEE?.BooksInfo[indexPath.row].bookName
        newVC.booksE = bookList2[indexPath.row] 
    
        newVC.navigationItem.largeTitleDisplayMode = .never
           navigationController?.pushViewController(newVC,animated: true)
        
        print("Done")
        
        
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
