//
//  ReadBookVC.swift
//  eBook
//
//  Created by Fno Khalid on 22/04/1443 AH.
//

import UIKit
import PDFKit


var bookmarkDict: [String: Int] = [:]

class pdfBook: UIViewController, PDFViewDelegate {
    
    var oldTabbarFr: CGRect = .zero
    var openedBook: String?
    var isSave: Bool = false
    
    
    //pdf View
    private var pdfView: PDFView?
    
    //pdf document
    private var pdfDocument: PDFDocument?
    
    private var totalPageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // add pdfView to viewController
        pdfView = PDFView(frame: self.view.bounds)
        self.view.addSubview(pdfView!)
        
        
        
        //configure pdf properties
        pdfView?.autoScales = true
        pdfView?.displayMode = .singlePage
        pdfView?.displayDirection = .horizontal
        pdfView?.usePageViewController(true)
    
        
        
        
        // pdf path, place pdf file:
        
        print("This is sth:", openedBook ?? "")
        
        guard let path = Bundle.main.url(forResource: openedBook ?? "" , withExtension: "pdf") else {
            print("unable to locate file")
            
            return
        }
        
        // load pdf
        pdfDocument = PDFDocument(url: path)
        pdfView!.document = pdfDocument
        
        //get totalnumber of pages in pdf
        if let total = pdfView?.document?.pageCount {
            totalPageCount = total
        }
        
        //page change
        NotificationCenter.default.addObserver(self, selector: #selector(handlePageChange), name: Notification.Name.PDFViewPageChanged, object: nil)
        
        oldTabbarFr = self.tabBarController?.tabBar.frame ?? .zero
        
        if let openedBook = openedBook,
           let lastBookmarkPageNumber = bookmarkDict[openedBook],
           let bookMarkedPage = pdfDocument?.page(at: lastBookmarkPageNumber - 1) {
                pdfView?.go(to: bookMarkedPage)
            }
    }

    
    @objc func handlePageChange() {
        
        // get current page number
        let currentPageNum = pdfDocument!.index(for: (pdfView?.currentPage)!) + 1
        let pageTotalAndCurrentNumber = "\(currentPageNum)/\(totalPageCount)"
        
        // cahnge Title
        title = " [\(pageTotalAndCurrentNumber)]"
        updateBookmarkIcon()
    }
    
    func updateBookmarkIcon() {
        guard
            let openedBook = openedBook else {
                return
            }
        
        
        let currentPageNum = pdfDocument!.index(for: (pdfView?.currentPage)!) + 1
        let lastBookmarkPageNumber = bookmarkDict[openedBook]
        
        if currentPageNum == lastBookmarkPageNumber {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .done, target: self, action: #selector(savePageNumber))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action:  #selector(savePageNumber))
        }
    }
    
    @objc func savePageNumber() {
        guard let openedBook = openedBook else { return }
        
        let currentPageNum = pdfDocument!.index(for: (pdfView?.currentPage)!) + 1
        let lastBookmarkPageNumber = bookmarkDict[openedBook]
        
        if currentPageNum == lastBookmarkPageNumber {
            bookmarkDict.removeValue(forKey: openedBook)
        } else {
            bookmarkDict[openedBook] = currentPageNum
        }
        
        updateBookmarkIcon()
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

