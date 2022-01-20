//
//  ChildEnglish.swift
//  eBook
//
//  Created by Fno Khalid on 02/05/1443 AH.
//

import UIKit

class ChildEnglish: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var e: Book?
    var oldTabbarFr: CGRect = .zero
    
    var searchBook: Array<Book> = englishChildList

    lazy var searchBar:UISearchBar = UISearchBar()
    private var bookCV: UICollectionView?
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          if searchText.isEmpty {
              searchBook = englishChildList
          } else {
            searchBook = searchBook.filter({ oneBook in
                return oneBook.name.starts(with: searchText)
            })
          }
        collectionView.reloadData()
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Color")
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChildECell.self,
        forCellWithReuseIdentifier: "childEnglishCell")
        setupCollectionConstraints()
        
        collectionView.frame = view.bounds
        
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
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
            cv.backgroundColor = UIColor(named: "Color")
         
           return cv
       }()
    
    func setupCollectionConstraints() {
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          collectionView.layer.shadowRadius = 2.0
       
          collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
          collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
          collectionView.heightAnchor.constraint(equalToConstant: 550).isActive = true
          collectionView.widthAnchor.constraint(equalToConstant: 350).isActive = true
          collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
          collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchBook.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "childEnglishCell", for: indexPath) as! ChildECell
        
      
        _ = englishChildList[indexPath.item]
          cell.setCell(book: searchBook[indexPath.item])

           cell.backgroundColor = UIColor(named: "Color")

                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 200, height: 250)
      }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newVC = ReadEnglishChild()
        newVC.title = e?.BooksInfo[indexPath.row].bookName
        newVC.childBooks = englishChildList[indexPath.row] 

        
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

