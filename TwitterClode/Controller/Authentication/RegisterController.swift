//
//  RegisterController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/21.
//

import UIKit

class RegisterController: UIViewController {
    // MARK: - Properities
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Selectors
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
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
