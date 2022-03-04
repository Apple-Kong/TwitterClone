//
//  LoginController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/21.
//

import UIKit

class LoginController: UIViewController {
    
    
    // MARK: - Properities
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "TwitterLogo")
        return iv
    }()
    
    
    // MARK: 이하 두개의 뷰가 공통된 컴포넌트를 가지므로 static 한 UI 는 함수레벨로 복붙.
    // 컨테이너뷰 1
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")!
        let view = Utillities().inputContainerView(withImage: image,textFeild: emailTextFeild)
     
        return view
    }()
    
    // 컨테이너뷰 2
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")!
        let view = Utillities().inputContainerView(withImage: image,textFeild: passwordTextFeild)

        return view
    }()
    
    
    // MARK: textfield 와 같이 실제로 ViewController 와 상호작용해야하는 경우는 함수레벨 사용 불가..
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(UIColor.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self , action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = Utillities().attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        dismissKeyboardWhenTappedAround()
    }
    // MARK: - Selectors
    @objc func handleShowSignUp() {
        let controller = RegisterController()
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func handleLogin() {
        guard let email = emailTextFeild.text else { return }
        guard let password = passwordTextFeild.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Error logging in \(error.localizedDescription)")
                return
            } else {
                self.goBackToMain()
            }
        }
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
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.size.equalTo(150)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 30
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(130)
        }
        
        view.addSubview(loginButton)
       
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stack)
            make.top.equalTo(stack.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}


import SwiftUI

struct LoginControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = LoginController

    func makeUIViewController(context: Context) -> LoginController {
        return LoginController()
    }

    func updateUIViewController(_ uiViewController: LoginController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct LoginControllerPreview: PreviewProvider {
    static var previews: some View {
        LoginControllerRepresentable()
    }
}

