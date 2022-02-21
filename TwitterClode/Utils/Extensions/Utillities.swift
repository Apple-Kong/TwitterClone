//
//  Utillities.swift
//  TwitterClode
//
//  Created by GOngTAE on 2022/02/21.
//

import Foundation
import UIKit
import SnapKit

class Utillities {
    func inputContainerView(withImage image: UIImage, textFeild: UITextField) -> UIView {
        let view = UIView()
        
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let iv = UIImageView()
       
        iv.image = image
        view.addSubview(iv)
        iv.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        
        view.addSubview(textFeild)
        
        textFeild.snp.makeConstraints { make in
            make.leading.equalTo(iv.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = .white
        view.addSubview(seperator)
        seperator.snp.makeConstraints { make in
            
            make.leading.equalTo(iv)
            
            make.bottom.trailing.equalToSuperview()
            make.height.equalTo(0.75)
        }
        
        
        return view
        
    }
    
    
    func textFeild(withPlaceHolder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
        
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton{
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}
