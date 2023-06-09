//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 17.03.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Data
    
    static let indentifire = "ProgressCell"
    
    var habit: Habit?
    
    //MARK: - Subviews
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var procentProgressLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitsProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.transform = CGAffineTransform(scaleX: 1, y: 2)
        progressView.progress = HabitsStore.shared.todayProgress
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureCell()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    
    func update() {
        guard !HabitsStore.shared.habits.isEmpty else {
            progressLabel.text = "Добавте свою первую привычку"
            return
        }
        
        progressLabel.text = "Все получится!"
        habitsProgressView.progress = HabitsStore.shared.todayProgress
        let progressInPercent = Int(HabitsStore.shared.todayProgress * 100)
        procentProgressLabel.text = "\(progressInPercent)%"
        
    }
    
    //MARK: - Private
    
    private func configureCell() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 10
    }
    
    private func addSubviews() {
        contentView.addSubview(progressLabel)
        contentView.addSubview(procentProgressLabel)
        contentView.addSubview(habitsProgressView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 12),
            progressLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 10),
            
            procentProgressLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 10),
            procentProgressLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -12),
            
            habitsProgressView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 12),
            habitsProgressView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -12),
            habitsProgressView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
