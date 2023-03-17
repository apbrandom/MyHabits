//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 17.03.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    static let indentifire = "HabitCell"
    
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemOrange
        contentView.addSubview(customLabel)
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor),
            customLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
        ])
    }
    
    
}
