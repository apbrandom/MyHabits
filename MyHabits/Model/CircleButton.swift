//
//  CircleButton.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 16.03.2023.
//

import UIKit

class CircleButton: UIButton {
    
    private lazy var aspectFitImageView: AspectFitImageView = {
        let imageView = AspectFitImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.width / 2
        aspectFitImageView.frame = self.bounds
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        aspectFitImageView.image = image
    }
}


class AspectFitImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        if let image = self.image {
            let aspectRatio = image.size.width / image.size.height
            let height = bounds.height
            let width = height * aspectRatio
            return CGSize(width: width, height: height)
        }
        return super.intrinsicContentSize
    }
}
