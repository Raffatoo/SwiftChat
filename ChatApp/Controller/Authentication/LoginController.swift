//
//  LoginControler.swift
//  ChatApp
//
//  Created by Cruz Torres on 20/02/22.
//

import Foundation
import UIKit

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}


class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        //let image = UIImageView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"))
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        return InputContainerView(image: image,textField: emailTextField)}()
    
//    private lazy var emailContainerView: InputContainerView = {
//        let containerView = InputContainerView(image: UIImage(systemName: "envelope")!,
//                                               textField: emailTextField)
//        return containerView
//    }()
    
//    private lazy var emailContainerView: UIView = {
//        let containerView = UIView()
//        containerView.backgroundColor = .clear
//
//        let iv = UIImageView()
//        iv.image = UIImage(systemName: "envelope")
//        iv.tintColor = .white
//
//        containerView.addSubview(iv)
//        iv.centerY(inView: containerView)
//        iv.anchor(left: containerView.leftAnchor, paddingTop: 8)
//        iv.setDimensions(height: 20, width: 24)
//
//        containerView.addSubview(emailTextField)
//        emailTextField.centerY(inView: containerView)
//        //emailTextField.textColor = UIColor.white
//        emailTextField.anchor(left: iv.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingLeft: 8, paddingBottom: -8)
//
//        containerView.setHeight(height: 50)
//        return containerView
//    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        return InputContainerView(image: image,textField: passwordTextField)}()
        
//        return InputContainerView(image: UIImage(systemName: "lock"),
//                                               textField: passwordTextField)
//    }()
        
//containerView.backgroundColor = .clear
        
//        let iv = UIImageView()
//        iv.image = UIImage(systemName: "lock")
//        iv.tintColor = .white
        
//        containerView.addSubview(iv)
//        iv.centerY(inView: containerView)
//        iv.anchor(left: containerView.leftAnchor, paddingTop: 8)
//        iv.setDimensions(height: 24, width: 28)
        
//        containerView.addSubview(passwordTextField)
//        passwordTextField.centerY(inView: containerView)
//        //passwordTextField.textColor = UIColor.white
//        passwordTextField.anchor(left: iv.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingLeft: 8, paddingBottom: -8)
        
//        containerView.setHeight(height: 50)
//        return containerView
//    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(hue: 0.9361, saturation: 0.32, brightness: 0.97, alpha: 1.0)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let atributedTitle = NSMutableAttributedString(string: "Dont have an account? ",
                                                       attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                    .foregroundColor: UIColor.white])
        atributedTitle.append(NSAttributedString(string: "Sign UP",
                                                 attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                              .foregroundColor: UIColor.white]))
        button.setAttributedTitle(atributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
       
        return button
        
    }()
    
    
    
    
//    private let emailTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Email"
//        tf.textColor = .white
//        return tf
//    }()
    

//    private let passwordTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Email"
//        tf.textColor = .white
//        return tf
//    }()
//
    
//    private let passwordTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Password"
//        tf.isSecureTextEntry = true
//        tf.textColor = .white
//
//        return tf
//    }()
    
    
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
                        
        print("show sign up age...")
    }
    
    @objc func textDidChange(sender: UITextField) {
        //print("DEBUG: Sender text is \(sender.text)")
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleLogin() {
        print("DEBUG: Handle login here..")
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                  passwordContainerView,
                                                  loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32 )
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor ,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32,
                                     paddingBottom: 16, paddingRight: 32)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

    }
//  Movi este codigo a Extensions de UIViewController 
//    func configureGradientLayer() {
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
//        gradient.locations = [0, 1]
//        view.layer.addSublayer(gradient)
//        gradient.frame = view.frame
//    }
//
    
}

extension LoginController: AuthenticationControllerProtocol {
    
    func checkFormStatus() {
        if viewModel.formIsValid{
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(hue: 0.9528, saturation: 1, brightness: 1, alpha: 1.0)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(hue: 0.9361, saturation: 0.44, brightness: 0.95, alpha: 1.0)
        }
    }

}
