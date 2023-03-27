//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 17.03.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: HabitCollectionViewCellDelegate?
    
    //MARK: - Data
    
    static let indentifire = "HabitCell"
    
    var habit: Habit?
    
    //MARK: - Subviews
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var everyDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Every Day"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = UIColor.systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Couner Day"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var checkButton: CircleButton = {
        let button = CircleButton()
        var color = UIColor()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.addTarget(
            self,
            action: #selector(checkButtonDidTaped),
            for: .touchUpInside)
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureCell()
        setupSubview()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    
    func update(_ model: Habit?) {
        habit = model
        guard let habit = habit else { return }
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habit.color
        everyDayLabel.text = habit.dateString
        counterDayLabel.text = "\(habit.trackDates.count)"
        checkButton.tintColor = habit.color
        checkButton.layer.borderColor = habit.color.cgColor
        
        if habit.isAlreadyTakenToday {
            selectedButton()
        } else {
            notSelectedButton()
        }
    }
    
    @objc func checkButtonDidTaped() {
        guard let habit = habit else { return }
        
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
        }
        
        checkButton.isSelected.toggle()
        
        if checkButton.isSelected {
            selectedButton()
            update(habit)
        } else if !habit.isAlreadyTakenToday {
            notSelectedButton()
        }
        
        delegate?.habitCellDidUpdate(self)
    }
    
    //MARK: - Private
    
    private func setupSubview() {
        contentView.addSubview(habitNameLabel)
        contentView.addSubview(everyDayLabel)
        contentView.addSubview(counterDayLabel)
        contentView.addSubview(checkButton)
    }
    
    private func configureCell() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemBackground
    }
    
    private func selectedButton() {
        let checkmarkImage = UIImage(systemName: "checkmark.circle.fill")
        checkButton.setImage(checkmarkImage, for: .normal)
        checkButton.layer.borderWidth = 5
    }
    
    private func notSelectedButton() {
        checkButton.setImage(nil, for: .normal)
        checkButton.layer.borderWidth = 2
        checkButton.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            habitNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20),
            habitNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 20),
            
            everyDayLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20),
            everyDayLabel.topAnchor.constraint(
                equalTo: habitNameLabel.bottomAnchor, constant: 4),
            
            counterDayLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20),
            counterDayLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -20),
            
            checkButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -25),
            checkButton.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
            checkButton.widthAnchor.constraint(
                equalToConstant: 38),
            checkButton.heightAnchor.constraint(
                equalTo: checkButton.widthAnchor)
        ])
    }
}


