//
//  FavoriteService.swift
//  eBook
//
//  Created by Fno Khalid on 24/04/1443 AH.
//

import UIKit
import FirebaseFirestore


class FavoriteService {


  static let shared = FavoriteService()
    
  let favoriteCollection = Firestore.firestore().collection("Favorite")


  func addToFavorite(favBook: Fav) {
      favoriteCollection.document(favBook.name).setData([
        "image": favBook.image ,
        "name": favBook.name

    ])
  }

  func listenToFavoriteBook(completion: @escaping (([Fav]) -> Void)) {
      favoriteCollection.addSnapshotListener { snapshot, error in
      if error != nil {
        return
      }
      guard let documents = snapshot?.documents else { return }
      var favorite: Array<Fav> = []
      for document in documents {
        let data = document.data()
        let fBook = Fav(
            image:(data["image"] as? String) ?? "No Image" ,
            name:(data["name"] as? String) ?? "No Name"

        )
          favorite.append(fBook)
      }
      completion(favorite)
    }
  }
}
