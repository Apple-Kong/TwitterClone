//
//  FeedController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/17.
//


import UIKit

class FeedController: UIViewController {
    // MARK: - Properities
    
    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}




import SwiftUI

struct FeedControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = FeedController

    func makeUIViewController(context: Context) -> FeedController {
        return FeedController()
    }

    func updateUIViewController(_ uiViewController: FeedController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct FeedControllerPreview: PreviewProvider {
    static var previews: some View {
        FeedControllerRepresentable()
    }
}
