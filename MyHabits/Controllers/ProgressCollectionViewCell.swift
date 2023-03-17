//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 17.03.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static let indentifire = "ProgressCell"
    
    private let customLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureCell()
        contentView.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        // Add subviews and setup constraints here, e.g.
        contentView.addSubview(customLabel)
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            customLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    
}
