//
//  Store.swift
//  RealmApp
//
//  Created by Vasiliy Munenko on 31.03.2021.
//

import Foundation
import SwiftUI

class Store: ObservableObject {
//Srore local property for ....

    @Published var activeAdressID: Int {
        didSet {
            UserDefaults.standard.set(activeAdressID, forKey: "activeAddres")
        }
    }

    init() {

        self.activeAdressID = UserDefaults.standard.integer(forKey: "activeAddres")
    }

}
