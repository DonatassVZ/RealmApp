//
//  Card.swift
//  RealmApp
//
//  Created by Vasiliy Munenko on 29.03.2021.
//

import Foundation
import RealmSwift

class Card: Object , Identifiable  {
    @objc dynamic var id : Int = Int(Date().timeIntervalSince1970)

    @objc dynamic var  city = ""
    @objc dynamic var street = ""
    @objc dynamic var house  = ""
    @objc dynamic var flat  = ""  
    @objc dynamic var detail = ""
    
}
