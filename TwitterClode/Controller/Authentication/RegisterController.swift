//
//  RegisterController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterController: UIViewController {
    // MARK: - Properities
    
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage? = nil
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")!
        let view = Utillities().inputContainerView(withImage: image,textFeild: emailTextFeild)
     
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")!
        let view = Utillities().inputContainerView(withImage: image,textFeild: passwordTextFeild)

        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")!
        let view = Utillities().inputContainerView(withImage: image,textFeild: fullNameTextFeild)
     
        return view
    }()
    
    private lazy var userNameContainerView: UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")!
        let view = Utillities().inputContainerView(withImage: image,textFeild: userNameTextFeild)
     
        return view
    }()
    
    private let emailTextFeild: UITextField = {
        let tf = Utillities().textFeild(withPlaceHolder: "Email")
        tf.addDoneButtonOnKeyboard()
        return tf
    }()
    
    private let passwordTextFeild: UITextField = {
        let tf = Utillities().textFeild(withPlaceHolder: "Password")
        tf.addDoneButtonOnKeyboard()
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextFeild: UITextField = {
        let tf = Utillities().textFeild(withPlaceHolder: "Full Name")
        tf.addDoneButtonOnKeyboard()
        return tf
    }()
    
    private let userNameTextFeild: UITextField = {
        let tf = Utillities().textFeild(withPlaceHolder: "UserName")
        tf.addDoneButtonOnKeyboard()
        return tf
    }()
    
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(UIColor.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self , action: #selector(handleSignUP), for: .touchUpInside)
        
        return button
    }()
    
    
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utillities().attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        dismissKeyboardWhenTappedAround()
    }
    // MARK: - Selectors
    @objc func handleSignUP() {
        guard let profileImage = profileImage else {
            print("DEBUG: Please select a profile image...")
            return
        }
        guard let email = emailTextFeild.text else { return }
        guard let password = passwordTextFeild.text else { return }
        guard let fullName = fullNameTextFeild.text else { return }
        guard let userName = userNameTextFeild.text?.lowercased() else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName, userName: userName, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials) { error, ref in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            } else {
                print("DEBUG: Sign up successful")
                self.goBackToMain()
            }
        }
    }
    @objc func handleAddProfilePhoto() {
        
        present(imagePicker, animated: true) {
            
        }
    }
    
    
    @objc func handleShowLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Helpers
    
    func goBackToMain() {
        guard let window =  UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        guard let main = window.rootViewController as? MainTabController else { return }
        main.authenticateUserAndConfigureUI()
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.size.equalTo(128)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, userNameContainerView])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(260)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stack)
            make.top.equalTo(stack.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
        

        
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
                
    }
}




import SwiftUI

struct RegisterControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = RegisterController

    func makeUIViewController(context: Context) -> RegisterController {
        return RegisterController()
    }

    func updateUIViewController(_ uiViewController: RegisterController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct RegisterControllerPreview: PreviewProvider {
    static var previews: some View {
        RegisterControllerRepresentable()
    }
}
