//
//  CaptionTextView.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/24.
//

import UIKit
import SnapKit

//기본 텍스트 필드에는 플레이스 홀더가 지원이 안되기 때문에 커스텀 클래스를 정의해서 사용
//만들어 놓고 재사용 가능한 View 프레임이완성됨!
class CaptionTextView: UITextView {
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "What's happening?"
        return label
    }()
    
    // MARK: - Selectors
    
    @objc func handleTextInputChange() {
        //이 구문을 사용하면 한줄로 쓸 수 있다.
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("did not implemented init(coder:)")
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = .systemFont(ofSize: 16)
        isScrollEnabled = false

        
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(4)
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
}
