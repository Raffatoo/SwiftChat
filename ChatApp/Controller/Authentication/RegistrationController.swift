//
//  RegistrationController.swift
//  ChatApp
//
//  Created by Cruz Torres on 20/02/22.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        return InputContainerView(image: image,textField: emailTextField)
    }()
    
    private lazy var nameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        return InputContainerView(image: image,textField: nameTextField)
    }()
    
    private lazy var userNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        return InputContainerView(image: image,textField: userNameTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        return InputContainerView(image: image,textField: passwordTextField)
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let nameTextField = CustomTextField(placeholder: "Full Name")
    
    private let userNameTextField = CustomTextField(placeholder: "Username")
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(hue: 0.9361, saturation: 0.32, brightness: 0.97, alpha: 1.0)
        button.setHeight(height: 50)
        button.isEnabled = false
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let atributedTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                       attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                    .foregroundColor: UIColor.white])
        atributedTitle.append(NSAttributedString(string: "Log In",
                                                 attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                              .foregroundColor: UIColor.white]))
        button.setAttributedTitle(atributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
       
        return button
        
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemMint
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Selectors
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == nameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func handSelectPhoto() {
        print("Select photo here...")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @objc func handleShowRegistration() {
        //let controller = LoginControler()
        navigationController?.popViewController(animated: true)
        print("show register")
    }
    
    
    // MARK: - Helpers
    
//    func checkFormStatus() {
//        if viewModel.formIsValid{
//            signUpButton.isEnabled = true
//            signUpButton.backgroundColor = UIColor(hue: 0.9528, saturation: 1, brightness: 1, alpha: 1.0)
//        } else {
//            signUpButton.isEnabled = false
//            signUpButton.backgroundColor = UIColor(hue: 0.9361, saturation: 0.44, brightness: 0.95, alpha: 1.0)
//        }
//    }
    
    func configureUI() {
        
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plusPhotoButton.setDimensions(height: 120, width: 120)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   nameContainerView,
                                                   userNameContainerView,
                                                   passwordContainerView,
                                                   signUpButton])
            stack.axis = .vertical
            stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32 )
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor ,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32,
                                     paddingBottom: 16, paddingRight: 32)
        
    }
    
    func configureNotificationObservers() {
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 120/2
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleToFill
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationController: AuthenticationControllerProtocol {
    
    func checkFormStatus() {
        if viewModel.formIsValid{
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(hue: 0.9528, saturation: 1, brightness: 1, alpha: 1.0)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(hue: 0.9361, saturation: 0.44, brightness: 0.95, alpha: 1.0)
        }
    }

}

