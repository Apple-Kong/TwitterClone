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
        
        
        tabBar.backgroundColor = .white
        uiTabBarSetting()
        configureViewControllers()
    }
    
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        let notification = NotificationController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notification)
        
        let conversation = ConversationController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversation)
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    
// 좋은 프로그래머가 되기 위해서는 중복코드를 피해야한다.
func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
    
    let nav = UINavigationController(rootViewController: rootViewController)
    nav.tabBarItem.image = image
    nav.navigationBar.barTintColor = .white
    nav.navigationBar.backgroundColor = .white
    
    if #available(iOS 15.0, *) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        
    }
    return nav
    
}
    

    
    func uiTabBarSetting() {
        if #available(iOS 15.0, *){
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
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
