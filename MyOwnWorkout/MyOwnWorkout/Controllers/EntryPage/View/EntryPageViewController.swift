//
//  EntryPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

protocol EntryPageViewControllerDelegate: AnyObject {
    func getSMSCodeAndOpenApprovePage(phoneNumber: String)
}

class EntryPageViewController: GeneralViewController {
    
    private let presenter = EntryPagePresenter()
    
    let phoneNumberTextField: UITextField = {
        let phoneNumberInput = UITextField()
        phoneNumberInput.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumberInput
    }()
    
    let getSMSCodeButton: UIButton = {
        let getSMSCodeButton = UIButton()
        getSMSCodeButton.translatesAutoresizingMaskIntoConstraints = false
        return getSMSCodeButton
    }()
    
    weak var delegate: EntryPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        phoneNumberTextField.delegate = self
        entryPageDesign()
        setupGetSMSCodeButton()
        
        let tapToHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapToHideKeyboard.delegate = self
        tapToHideKeyboard.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapToHideKeyboard)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    func setupGetSMSCodeButton() {
        getSMSCodeButton.addTarget(self, action: #selector(setupGetSMSCodeButtonAction), for: .touchUpInside)
    }
    
    
    @objc func setupGetSMSCodeButtonAction() {
        //извлекаем текст
        guard let sentPhoneNumber = phoneNumberTextField.text else {
            showAlert(title: "Номер неверный", message: "Попробуйте другой");
            return
        }
        
        //достаем только номера
        let separated = sentPhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        
        //проверка на корректность
        if separated.count != 11 {
            showAlert(title: "Номер неверный", message: "Попробуйте другой")
            return
        }
        
        navigationController?.popToRootViewController(animated: false)
        delegate?.getSMSCodeAndOpenApprovePage(phoneNumber: sentPhoneNumber)
        
    }
}

extension EntryPageViewController {
    
    private func entryPageDesign() {
        navigationItem.title = "Вход"
        
        view.addSubview(phoneNumberTextField)
        view.addSubview(getSMSCodeButton)
        
        phoneNumberTextField.placeholder = "Введите номер телефона"
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.textAlignment = .center
        phoneNumberTextField.layer.cornerRadius = 12
        
        getSMSCodeButton.setTitle("Получить код по СМС", for: .normal)
        getSMSCodeButton.backgroundColor = .systemRed
        getSMSCodeButton.layer.cornerRadius = 12
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            phoneNumberTextField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            
            getSMSCodeButton.heightAnchor.constraint(equalToConstant: 50),
            getSMSCodeButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 10),
            getSMSCodeButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            getSMSCodeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30)
        ])
    }
}

extension EntryPageViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == phoneNumberTextField {
            textField.text = text.phoneMaskRu()
        }
    }
}

extension EntryPageViewController: EntryPagePresenterDelegate {
    
}
