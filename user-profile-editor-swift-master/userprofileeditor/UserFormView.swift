//
//  ViewController.swift
//  userprofileeditor
//
//  Created by Ahmed Adel on 9/16/17.
//
//

import UIKit

/**
 UserFormView is the responsibility of the view is to send the user actions to
 the presenter and shows whatever the presenter tells it.
 **/

class UserFormView: UIViewController, UserFormViewProtocol, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var ageDatePicker: UIDatePicker!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var showNameSwitch: UISwitch!
    
    var presenter: UserFormPresenterProtocol?
    var countries = [String]()
    var selectedCountry: String?
    var selectedAge: Int?
    var selectedGender: Gender = Gender.male
    var isShowProfileName: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
        presenter = UserFormPresenter(view: self)
        setCountries()
    }
    
    /**
     Implement the unimplement functions of UserFormViewProtocol
     **/
    
    func setCountries() {
        countries = (presenter?.showCountries())!
    }
    
    func showErrorMessage(userFormFields filed: UserFormFields, errorMessage msg: String) {
        switch filed {
        case .name:
            nameTextField.placeholder = msg
        case .email:
            emailTextField.placeholder = msg
        default:
            print("showErrorMessage")
            break
        }
    }
    
    func navigateToShowProfileScreen(user: User) {
        presenter?.saveUserToDatabase(saveUser: user)
    }
    
    /** -------------------------------------------------------------------------------- **/
    
    /**
     Implement the unimplemented functions of UIPickerViewDelegate and UIPickerViewDataSource
     that are related to the UIPickerView
     **/
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.isEmpty ? 0 : countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return selectedCountry = countries[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /** -------------------------------------------------------------------------------- **/
    
    // submitUserDataButtonTabbed is the UIButton triggered function for submit button
    @IBAction func submitUserDataButtonTabbed(_ sender: UIButton) {
        closeKeyboard()
        afterValidateUserData()
    }
    
    // userAgeTabbed is the UIDatePicker triggered function for user age
    @IBAction func userAgeTabbed(_ sender: UIDatePicker) {
        closeKeyboard()
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        selectedAge = componenets.year
    }
    
    // userGenderTabbed is the UISegmentedControl triggered function for user gender
    @IBAction func userGenderTabbed(_ sender: UISegmentedControl) {
        closeKeyboard()
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            selectedGender = Gender.male
        case 1:
            selectedGender = Gender.female
        default:
            print("userGenderTabbed")
            break
        }
    }
    
    // showNameUserTabbed is the UISwitch triggered function for show user name profile
    @IBAction func showNameUserTabbed(_ sender: UISwitch) {
        closeKeyboard()
        if sender.isOn{
            isShowProfileName = true
        } else {
            isShowProfileName = false
        }
    }
    
    // afterValidateUserData is the function that is called after user success user validation data
    func afterValidateUserData(){
        var userFields = [UserFormFields:String]()
        userFields[.name] = nameTextField.text
        userFields[.email] = emailTextField.text
        userFields[.country] = selectedCountry
        if presenter?.validateUserData(validateUserFields: userFields) ?? false {
            navigateToShowProfileScreen(user: User(name: nameTextField.text,email: emailTextField.text,country: selectedCountry,age: getUserAge(year: selectedAge!),gender: selectedGender,showProfileName: isShowProfileName))
        }
    }
    
    // getUserAge is the function that is return the user age by giving it the choosen year
    func getUserAge(year: Int?) -> Int {
        return returnCurrentYear() - (year ?? 0)
    }
    
    // returnCurrentYear is the function that return the current year to compare it with the choosen year
    func returnCurrentYear() -> Int {
        let date = Date()
        let calender = Calendar.current
        return calender.component(.year, from: date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboard()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
    }
    
    // close keyboard
    func closeKeyboard() {
        self.view.endEditing(true)
    }
}

