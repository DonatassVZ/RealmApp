//
//  DBViewModel.swift
//  RealmApp
//
//  Created by Vasiliy Munenko on 30.03.2021.
//

import Foundation
import SwiftUI
import RealmSwift



class DBViewModel: ObservableObject {
 //data
   // @Published var title = ""
    @Published var detail = ""
    
    
    @Published var  city = ""
    @Published var street = ""
    @Published var house  = ""
    @Published var flat  = ""
    
    @Published var openNewPage = false
    
    @Published var cards : [Card] = []
    
    @Published var updateObject : Card?
    
    init() {
        fetchData()
    }
    
    func getObject(withId : Int) -> Card?{
        var card : Card? = nil
        guard let dbRef = try? Realm() else { return  card}
        card = dbRef.objects(Card.self).filter("id == %d" , withId ).compactMap({ (car) -> Card? in
            return car
        }).first
        
        return card
    }
    
    
    func fetchData(){
        guard let dbRef = try? Realm() else { return }
        
        let result =  dbRef.objects(Card.self)
        
        self.cards = result.compactMap({ (card) -> Card? in
            return card
        })
    }
    
    //add and update data
    func addData(presentation: Binding<PresentationMode>) {
        if street == "" || city == ""  || house == "" {return}
        
        let card = Card()
        card.city = city
        card.street = street
        card.house = house
        card.flat = flat
        card.detail = detail
        
        
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write{
            
            guard let availableObject = updateObject else {
                    //add only new
                dbRef.add(card)
                return
            }
            // update object
            availableObject.city = city
            availableObject.street = street
            availableObject.house = house
            availableObject.flat = flat
            availableObject.detail = detail
        }
        fetchData()
        //Closing View
        presentation.wrappedValue.dismiss()
    }
    
    
    //delete
    func deleteData(object : Card){
        
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write{
            dbRef.delete(object)
            
            fetchData()
        }
    }
    
    func setInitialData(){
        guard let updateData = updateObject else {
            return
        }
        
        
        detail = updateData.detail
        city = updateData.city
        street = updateData.street
        house  = updateData.house
        flat  = updateData.flat
        
        
    }
    
    func deInitData(){
        updateObject = nil
       
        detail = ""
        
        city = ""
        street = ""
        house  = ""
        flat  = ""
    }
}
