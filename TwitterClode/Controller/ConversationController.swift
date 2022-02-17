//
//  ConversationController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/17.
//


import UIKit

class ConversationController: UIViewController {
    // MARK: - Properities
    
    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPurple
    }
    
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        
    }
}




import SwiftUI

struct ConversationControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ConversationController

    func makeUIViewController(context: Context) -> ConversationController {
        return ConversationController()
    }

    func updateUIViewController(_ uiViewController: ConversationController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ConversationControllerPreview: PreviewProvider {
    static var previews: some View {
        ConversationControllerRepresentable()
    }
}
