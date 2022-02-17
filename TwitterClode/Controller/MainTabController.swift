//
//  MainTabController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/17.
//

import UIKit

class MainTabController: UITabBarController {
    
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

struct MainTabControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MainTabController

    func makeUIViewController(context: Context) -> MainTabController {
        return MainTabController()
    }

    func updateUIViewController(_ uiViewController: MainTabController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct MainTabControllerPreview: PreviewProvider {
    static var previews: some View {
        MainTabControllerRepresentable()
    }
}
