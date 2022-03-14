//
//  ProfileFilterView.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/03/02.
//

import UIKit
import SnapKit

private let reuseIdentifier = "ProfileFilterCell"

protocol ProfileFitlerViewDelegate: AnyObject {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath)
}

class ProfileFilterView: UIView {
    // MARK: - Properties
    
    weak var delegate: ProfileFitlerViewDelegate?
    
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //컬렉션뷰 자동 선택 메서드
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
}

// MARK: - UICollectionViewDataSource
extension ProfileFilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //이런식으로 하드코딩 해놓은 enum 을 사용하면 필터가 추가되어도 그에따라 수정할 코드가 적어진다.
        //게다가 View 는 최대한 View Model 을 몰라야한다.
        // View Model 에서 무언가를 추가하면 알아서 View 가 수정되도록 코드를 짜야한다는 이야기이다.
        // 유지보수 하기에 좋은 방식으로 코딩을 한다는 건 이런 의미이다.
        return ProfileFilterOPtions.allCases.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileFilterCell
        
        let option = ProfileFilterOPtions(rawValue: indexPath.row)
        cell.titleLabel.text = option?.description
        cell.option = option
        print("DEBUG: Option is \(option?.description)")
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterView(self, didSelect: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let count = CGFloat(ProfileFilterOPtions.allCases.count)
        return CGSize(width: self.frame.width / count, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  0
    }
}

