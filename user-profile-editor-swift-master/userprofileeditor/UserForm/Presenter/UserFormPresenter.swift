//
//  UserFormPresenter.swift
//  userprofileeditor
//
//  Created by Ahmed Adel on 9/16/17.
//
//

import Foundation
import UIKit

/**
 UserFormPresenter is the responsibility is to get the data from the interactor
 on user actions and after getting data from the interactor, it sends it to the view to show it.
 It also asks the router/wireframe for navigation.
 **/

class UserFormPresenter: UserFormPresenterProtocol{
    
    var view: UserFormViewProtocol?
    var interactor: UserFormInteractorProtocol?
    var wireFrame: UserFormWireFrameProtocol?
    
    convenience init(view userFromView: UserFormViewProtocol){
        self.init()
        view = userFromView
        interactor = UserFormInteractor()
        wireFrame = UserFormWireFrame()
    }
    
    func showCountries() -> [String] {
        return interactor?.getListOfCountries() ?? [String]()
    }
    
    func validateUserData(validateUserFields:[UserFormFields:String]) -> Bool {
        for userField in validateUserFields{
            switch userField.key {
            case .name where userField.value.isEmpty:
                view?.showErrorMessage(userFormFields: userField.key, errorMessage: ErrorMessages.userName.rawValue)
                return false
            case .email where userField.value.isEmpty:
                view?.showErrorMessage(userFormFields: userField.key, errorMessage: ErrorMessages.email.rawValue)
                return false
            case .country where userField.value.isEmpty:
                view?.showErrorMessage(userFormFields: userField.key, errorMessage: ErrorMessages.country.rawValue)
                return false
            default:
                break
            }
        }
        return true
    }
    
    func saveUserToDatabase(saveUser: User) {
        wireFrame?.presentShowProfileScreen(from: view, user: saveUser)
    }
}
