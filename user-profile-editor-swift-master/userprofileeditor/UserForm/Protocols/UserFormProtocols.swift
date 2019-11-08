//
//  UserFormProtocols.swift
//  userprofileeditor
//
//  Created by Ahmed Adel on 9/16/17.
//
//

import Foundation
import UIKit

/**
 UserFormViewProtocol is a protocol class that contains all the protocols that will be
 implemented by each component : View, Presenter, Interceptor, Entity and WireFrame
**/

protocol UserFormViewProtocol: class{
    func setCountries()
    func showErrorMessage(userFormFields filed:UserFormFields, errorMessage msg:String)
    func navigateToShowProfileScreen(user:User)
}

protocol UserFormPresenterProtocol: class{
    func showCountries() -> [String]
    func validateUserData(validateUserFields:[UserFormFields:String]) -> Bool
    func saveUserToDatabase(saveUser:User)
    
}

protocol UserFormInteractorProtocol: class{
    func getListOfCountries() -> [String]
}

protocol UserFormWireFrameProtocol: class{
    func presentShowProfileScreen(from view:UserFormViewProtocol?, user:User)
}

protocol LocalDatabaseManagerUserFormProtocol: class{
    func getCountries() -> [String]
}
