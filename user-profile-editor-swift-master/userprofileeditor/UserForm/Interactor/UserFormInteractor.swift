//
//  UserFormInteractor.swift
//  userprofileeditor
//
//  Created by Ahmed Adel on 9/16/17.
//
//

import Foundation
import UIKit

/**
 UserFormInteractorProtocol is is the backbone of an application as it contains the business logic of the user form component
 **/

class UserFormInteractor: UserFormInteractorProtocol {
    
    var countries: LocalDatabaseManagerUserFormProtocol?
    
    func getListOfCountries() -> [String] {
        countries = LocalDatabaseManager()
        return countries?.getCountries() ?? [String]()
    }
    
}
