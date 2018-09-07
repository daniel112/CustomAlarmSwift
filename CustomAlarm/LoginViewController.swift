//
//  LoginViewController.swift
//  CustomAlarm
//
//  Created by Daniel Yo on 9/7/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // UI
    private var username:String?
    private var password:String?
    lazy private var buttonLogin:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: UIControlState.normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(buttonLogin_touchUpInside), for: .touchUpInside)
        return button
    }()
    lazy private var userTextField:UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "username"
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.borderStyle = UITextBorderStyle.roundedRect
        textfield.autocorrectionType = UITextAutocorrectionType.no
        textfield.keyboardType = UIKeyboardType.default
        textfield.returnKeyType = UIReturnKeyType.done
        textfield.clearButtonMode = UITextFieldViewMode.whileEditing;
        textfield.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textfield.delegate = self
        return textfield
    }()
    
    lazy private var passwordTextField:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "password"
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.borderStyle = UITextBorderStyle.roundedRect
        textfield.autocorrectionType = UITextAutocorrectionType.no
        textfield.keyboardType = UIKeyboardType.default
        textfield.returnKeyType = UIReturnKeyType.done
        textfield.clearButtonMode = UITextFieldViewMode.whileEditing;
        textfield.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textfield.clearsOnBeginEditing = true
        textfield.isSecureTextEntry = true
        textfield.delegate = self
        return textfield
    }()
    
    
    lazy private var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.text = "Login"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setup() {
        self.view.addSubview(self.label)
        self.label.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        })
        
        // user textfield
        self.view.addSubview(self.userTextField)
        self.userTextField.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        })
        
        // password textfield
        self.view.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.userTextField.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(200)
        })
        
        // button
        self.view.addSubview(self.buttonLogin)
        self.buttonLogin.snp.makeConstraints({ (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        })
    }
    
    // MARK: UIResponder
    @objc func buttonLogin_touchUpInside(sender:UIButton!) {
        self.view.endEditing(true)
        self.username = self.userTextField.text
        self.password = self.passwordTextField.text
        if (self.username?.lowercased() == "admin" && self.password?.lowercased() == "admin") {
            let destinationVC:ViewController = ViewController()
            destinationVC.username = self.username
            destinationVC.password = self.password
            self.passwordTextField.text = ""
            self.navigationController?.present(destinationVC, animated: true, completion: nil)
        } else if (self.username?.lowercased() == "user" && self.password?.lowercased() == "user") {
            let destinationVC:ViewController = ViewController()
            destinationVC.username = self.username
            destinationVC.password = self.password
            self.passwordTextField.text = ""
            self.navigationController?.present(destinationVC, animated: true, completion: nil)
        }
    }
    
    // MARK: Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}
