//
//  ExploreController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/17.
//

import UIKit

class ExploreController: UIViewController {
    // MARK: - Properities
    
    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .systemBlue
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
}




import SwiftUI

struct ExploreControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ExploreController

    func makeUIViewController(context: Context) -> ExploreController {
        return ExploreController()
    }

    func updateUIViewController(_ uiViewController: ExploreController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ExploreControllerPreview: PreviewProvider {
    static var previews: some View {
        ExploreControllerRepresentable()
    }
}
