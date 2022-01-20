//
//  Data.swift
//  eBook
//
//  Created by Fno Khalid on 19/04/1443 AH.
//

import UIKit

struct Book {
    var image: String
    var name: String
    var by: String
    var category: String
    var BooksInfo: Array<BookInformation>
  
}
struct BookInformation {
    let bookImage: String
    let bookName: String
    let auther: String
    let pageNumber: String
}


struct Fav {
//    var id: String
    var image: String
    var name: String
   
}


var bookList = [
    Book(image: "3", name: "نظرية الفستق", by: "الكاتب : فهد الأحمدي", category: "التنمية البشرية",
         BooksInfo:[
            BookInformation(bookImage: "3", bookName: "نظرية الفستق",auther: " الكاتب : فهد الأحمدي", pageNumber: "عدد الصفحات : 256")]),
    Book(image: "0", name: "جدد نفسك", by: "الكاتب : ستيف تشاندلر", category: "تطوير الذات",
         BooksInfo:[
            BookInformation(bookImage: "0", bookName: "جدد نفسك",auther: " الكاتب : ستيف تشاندلر",pageNumber: "عدد الصفحات : 320")]),
    Book(image: "1", name: "كن بخير", by: "الكاتب: عائشة العمران", category: "ثقافة عامة",
         BooksInfo:[
            BookInformation(bookImage: "1", bookName: "كن بخير",auther: " الكاتب : عائشة العمران",pageNumber: "عدد الصفحات : 144")]),
    Book(image: "2", name: "الرجال من المريخ", by: "الكاتب : جون غراي", category: "العلاقات الأسرية",
         BooksInfo:[
            BookInformation(bookImage: "2", bookName: "الرجال من المريخ و النساء من الزهرة",auther: " الكاتب : جون غراي", pageNumber: "عدد الصفحات : 188")]),
    Book(image: "4", name: "مت فارغاً", by: "الكاتب : تود هنري", category: "التنمية البشرية",
         BooksInfo:[
            BookInformation(bookImage: "4", bookName: "مت فارغاً",auther: " الكاتب : تود هنري", pageNumber: "عدد الصفحات : 338")]),
    Book(image: "5", name: "لأنك الله", by: "الكاتب : علي الفيفي", category: "علوم إسلامية",
         BooksInfo:[
            BookInformation(bookImage: "5", bookName: "لأنك الله رحلة إلى السماء السابعة",auther: " الكاتب : علي الفيفي", pageNumber: "عدد الصفحات : 192")]),
    Book(image: "6", name: "فن اللامبالاة", by: "الكاتب : مارك مانسون", category: "التنمية البشرية",
         BooksInfo:[
            BookInformation(bookImage: "6", bookName: "فن اللامبالاة",auther: " الكاتب : مارك مانسون", pageNumber: "عدد الصفحات : 272")]),
    Book(image: "7", name: "أربعون 40", by: "الكاتب : أحمد الشقيري", category: "تطوير الذات",
         BooksInfo:[
            BookInformation(bookImage: "7", bookName: "أربعون 40",auther: " الكاتب : أحمد الشقيري", pageNumber: "عدد الصفحات : 273")]),
    Book(image: "8", name: "الدحيح", by: "الكاتب : طاهر المعتز بالله", category: "ثقافة عامة",
         BooksInfo:[
            BookInformation(bookImage: "8", bookName: "الدحيح ما وراء الكواليس",auther: " الكاتب : طاهر المعتز بالله", pageNumber: "عدد الصفحات : 256")]),
    Book(image: "9", name: "زحمة حكي", by: "الكاتب : علي نجم", category: "نصوص و خواطر",
         BooksInfo:[
            BookInformation(bookImage: "9",bookName: "زحمة حكي",auther: " الكاتب : علي نجم", pageNumber: "عدد الصفحات : 201")]),
    Book(image: "10", name: "أسباب للبقاء حياً", by: "الكاتب : مات ميغ", category: "التنمية البشرية",
         BooksInfo:[
            BookInformation(bookImage: "10", bookName: "أسباب للبقاء حياً",auther: " الكاتب : مات هيغ", pageNumber: "عدد الصفحات : 218")])
]

let bookList2 = [
    Book(image: "11", name: "Words That Change Minds", by: "by: Shelle Rose Charvet", category: "Business & Economics", BooksInfo: [
        BookInformation(bookImage: "11", bookName: "Words That Change Minds", auther: "by: Shelle Rose Charvet", pageNumber: "pages number: 318")]),
    
    Book(image: "12", name: "It Ends with Us", by: "by: Colleen Hoover", category: "Romance", BooksInfo: [
        BookInformation(bookImage: "12", bookName: "Words That Change Minds", auther: "by: Colleen Hoover", pageNumber: "pages number: 385")]),
    
    Book(image: "13", name: "The Power of Habit", by: "by:Charles Duhigg", category: "Business & Economics", BooksInfo: [
        BookInformation(bookImage: "13", bookName: "Words That Change Minds", auther: "by:Charles Duhigg", pageNumber: "pages number: 276")]),
    
    Book(image: "14", name: "The Question Book", by: "by:Mikael Krogerus..", category: "Relationships & Lifestyle", BooksInfo: [
        BookInformation(bookImage: "14", bookName: "The Question Book", auther: "by:Mikael Krogerus, Roman Tschäppeler", pageNumber: "pages number: 133")]),

    Book(image: "15", name: "The Power of Now ", by: "by:Eckhart Tolle", category: "human development", BooksInfo: [
        BookInformation(bookImage: "15", bookName: "The Power of Now", auther: "by:Eckhart Tolle", pageNumber: "pages number: 258")]),
  
    Book(image: "16", name: "Finish What You Start", by:"by:Peter Hollins", category: "Business & Economics", BooksInfo: [
        BookInformation(bookImage: "16", bookName: "Finish What You Start: The Art of Following Through, Taking Action, Executing, & Self-Discipline", auther: "by:Peter Hollins", pageNumber: "pages number: 133")]),
  
    Book(image: "17", name: "Think Again", by: "by: Walter Sinnott-Armstrong", category: "Politics & Philosophy ", BooksInfo: [
        BookInformation(bookImage: "17", bookName: "Think Again: How to Reason and Argue", auther: "by:Walter Sinnott-Armstrong", pageNumber: "pages number: 256")]),
   
    Book(image: "18", name: "365 Days", by: "by: Meadows, Martin", category: "Relationships & Lifestyle", BooksInfo: [
        BookInformation(bookImage: "18", bookName: "365 Days With Self-Discipline", auther: "by:Meadows, Martin", pageNumber: "pages number: 697")]),
     
]



var arabicChildList = [
    Book(image: "19", name: "البيت الجديد", by: "الكاتب : كامل كيلاني", category: " قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "19", bookName: "البيت الجديد", auther: "الكاتب : كامل كيلاني", pageNumber: "عدد الصفحات: 12")]),
    Book(image: "20", name: "السندباد البحري", by: "الكاتب: كامل كيلاني", category: "قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "20", bookName: "السندباد البحري", auther: "الكاتب: كامل كيلاني", pageNumber: "عدد الصفحات: 75")]),
    Book(image: "21", name: "الملك عجيب", by: "الكاتب: كامل كيلاني", category: "قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "21", bookName: "الملك عجيب", auther: "الكاتب: كامل كيلاني", pageNumber: "عدد الصفحات: 16")]),
    Book(image: "22", name: "النحلة العاملة", by: "الكاتب: كامل كيلاني", category: "قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "22", bookName: "النحلة العاملة", auther: "الكاتب: كامل كيلاني", pageNumber: "عدد الصفحات: 44")]),
    
    Book(image: "23", name: "سعفان الكسلان", by: "الكاتب: سماح ماضي", category: "قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "23", bookName: "سعفان الكسلان", auther: "الكاتب: سماح ماضي", pageNumber: "عدد الصفحات: 24")]),
    
    Book(image: "24", name: "لؤلؤة الصباح", by: "الكاتب: كامل كيلاني", category: "قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "24", bookName: "سعفان الكسلان", auther: "الكاتب: كامل كيلاني", pageNumber: "عدد الصفحات: 28")]),
    
    Book(image: "25", name: "ذاهب لأطمئن على صديقي", by: "الكاتب: نوران طاهر", category: "قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "25", bookName: "ذاهب لأطمئن على صديقي", auther: "الكاتب: نوران طاهر", pageNumber: "عدد الصفحات: 28")]),
    
    
    Book(image: "26", name: "شيماء تحكي", by: "الكاتب: شيماء فتاح", category: "قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "26", bookName: "شيماء تحكي", auther: "الكاتب: شيماء فتاح", pageNumber: "عدد الصفحات: 12")]),
    
    
    Book(image: "27", name: "كيف أصبح الفيل فهد", by: "الكاتب: رؤوف بوقفة", category: "قصص أطفال",
         BooksInfo: [
            BookInformation(bookImage: "27", bookName: "كيف أصبح الفيل فهد", auther: "الكاتب: رؤوف بوقفة", pageNumber: "عدد الصفحات: 11")]),
    
    ]

var englishChildList = [
    
    Book(image: "28", name: "English Grammar", by: "by: Gabriele Stobbe", category: "Euducation",
         BooksInfo: [
            BookInformation(bookImage: "28", bookName: "Just Enough English Grammar", auther: "by: Gabriele Stobbe", pageNumber: "pages number: 145")]),
    
    Book(image: "29", name: "Nature Trail", by: "", category: "Stories",
         BooksInfo: [
            BookInformation(bookImage: "29", bookName: "Nature Trail", auther: "", pageNumber: "pages number: 15")]),
    
    Book(image: "30", name: "Picture Books", by: "by: Mary Nothrup", category: "Stories",
         BooksInfo: [
            BookInformation(bookImage: "30", bookName: "Picture Books", auther: "by: Mary Nothrup", pageNumber: "pages number: 226")]),
    
    Book(image: "31", name: "Stars and Planets", by: "by: Lorraine Horsley", category: "Stories",
         BooksInfo: [
            BookInformation(bookImage: "31", bookName: "Stars and Planets", auther: "by: Lorraine Horsley", pageNumber: "pages number: 16")]),
    
    Book(image: "32", name: "Tiny Creatures", by: "", category: "Stories",
         BooksInfo: [
            BookInformation(bookImage: "32", bookName: "Tiny Creatures", auther: "", pageNumber: "pages number: 15")]),
    
    ]
  
