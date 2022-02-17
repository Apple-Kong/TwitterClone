//
//  NotificationController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/17.

import UIKit

class NotificationController: UIViewController {
    // MARK: - Properities
    
    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        
    }
    
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        
    }
}




import SwiftUI

struct NotificationControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = NotificationController

    func makeUIViewController(context: Context) -> NotificationController {
        return NotificationController()
    }

    func updateUIViewController(_ uiViewController: NotificationController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct NotificationControllerPreview: PreviewProvider {
    static var previews: some View {
        NotificationControllerRepresentable()
    }
}
