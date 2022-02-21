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
    
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        
        
        view.backgroundColor = .red
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let iv = UIImageView()
        iv.image = UIImage(named: "mail")
        iv.tintColor = .white
        view.addSubview(iv)
        iv.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(24)
        }
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemPink
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(150)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
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

