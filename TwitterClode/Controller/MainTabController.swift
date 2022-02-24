//
//  MainTabController.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/17.
//

import UIKit
import SnapKit
import FirebaseAuth

class MainTabController: UITabBarController {
    
    // MARK: - Properities
    //프로퍼티가 값이 할당 되었을 때 무조건 실행되어야하는 코드들은 didSet 적극활용.
    //네트워크요청이 언제 완료될지 모르기 때문에 didSet 활용하면 좋다.
    var user: User? {
        didSet {
            //viewControllers[0] 은 feedController 가 속해있는 네비게이션 컨트롤러
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            // nav.viewControllers.first 는 해당 네비게이션 컨트롤러가 보여주는 첫화면
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
//        logUserOut()
        
        authenticateUserAndConfigureUI()
    }
    // MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                // 루트 컨트롤러 위에 컨트롤러를 띄울 때에는 main 스레드를 활용
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            print("DEBUG: User is logged in..")
            // 로그인 되기 전에는 UI 구성하지 않도록 하는 것이 바람직함.
            
            tabBar.backgroundColor = .white
            uiTabBarSetting()
            configureViewControllers()
            configureUI()
            fetchUser()
            
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    // MARK: - Selectors
    @objc func actionButtonTapped() {
        guard let user = user else {
            return
        }
        
        let nav = templateNavigationController(image: nil, rootViewController: UploadTweetController(user: user))
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.addSubview(actionButton)
        let buttonSize: CGFloat = 56
        
        actionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-64)
            make.height.width.equalTo(buttonSize)
        }
        actionButton.layer.cornerRadius = buttonSize / 2
    }
    
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
        
        //변경된 네비게이션 바 외관 원래 것 사용하는 방법.
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
