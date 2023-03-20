//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 14.03.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    //MARK: - Subviews
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var topTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topTopStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var topCenterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topBottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var pickerColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pickerColorButton: CircleButton = {
        let button = CircleButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.addTarget(
            self,
            action: #selector(didTapButtonPickerColor),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var everyDayLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedTimeString(for: timePickerView.date)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timePickerView: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }
        timePicker.addTarget(
            self,
            action: #selector(timePickerValueChanged(_:)),
            for: .valueChanged)
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        return timePicker
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
        habitNameTextField.becomeFirstResponder()
//        habitNameTextField.inputAssistantItem.leadingBarButtonGroups = []
//        habitNameTextField.inputAssistantItem.trailingBarButtonGroups = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            habitNameTextField.becomeFirstResponder()
//            habitNameTextField.inputAssistantItem.leadingBarButtonGroups = []
//            habitNameTextField.inputAssistantItem.trailingBarButtonGroups = []
        }
    
    //MARK: - Action
    
    @objc func didTapDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSaveButton() {
        //        let newHabit = Habit(name: "Выпить стакан воды перед завтраком",
        //                             date: Date(),
        //                             color: .systemRed)
        //        let store = HabitsStore.shared
        //        store.habits.append(newHabit)
        //        print(store.habits)
    }
    
    @objc func didTapButtonPickerColor() {
        let pickerColorController = UIColorPickerViewController()
        pickerColorController.delegate = self
        present(pickerColorController, animated: true)
    }
    
    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
        everyDayLabel.attributedText = attributedTimeString(for: sender.date)
    }
    
    //MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        setupNavigation()
        
    }
    
    private func setupSubviews() {
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topView)
        mainStackView.addArrangedSubview(centerView)
        mainStackView.addArrangedSubview(bottomView)
        
        topView.addSubview(topStackView)
        topStackView.addArrangedSubview(topTopView)
        topStackView.addArrangedSubview(topCenterView)
        topStackView.addArrangedSubview(topBottomView)
        
        topTopView.addSubview(topTopStackView)
        topTopStackView.addArrangedSubview(habitNameLabel)
        topTopStackView.addArrangedSubview(habitNameTextField)
        topCenterView.addSubview(pickerColorLabel)
        topCenterView.addSubview(pickerColorButton)
        topBottomView.addSubview(topBottomStackView)
        topBottomStackView.addArrangedSubview(timeLabel)
        topBottomStackView.addArrangedSubview(everyDayLabel)
        
        centerView.addSubview(timePickerView)
    }
    
    private func setupNavigation() {
        title = "Создать"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(didTapDismissButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .done,
            target: self,
            action: #selector(didTapSaveButton))
    }
    
    private func attributedTimeString(for date: Date) -> NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let timeString = dateFormatter.string(from: date)
        
        let attributedString = NSMutableAttributedString(string: "Каждый день в \(timeString)")
        let timeStringRange = (attributedString.string as NSString).range(of: timeString)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemPurple, range: timeStringRange)
        
        return attributedString
    }
    
    //MARK: - Layout
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            topStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            topStackView.topAnchor.constraint(equalTo: topView.topAnchor),
            topStackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            topStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            
            topTopStackView.leadingAnchor.constraint(equalTo: topTopView.leadingAnchor),
            topTopStackView.topAnchor.constraint(equalTo: topTopView.topAnchor),
            topTopStackView.bottomAnchor.constraint(equalTo: topTopView.bottomAnchor),
            topTopStackView.trailingAnchor.constraint(equalTo: topTopView.trailingAnchor),
            
            topBottomStackView.leadingAnchor.constraint(equalTo: topBottomView.leadingAnchor),
            topBottomStackView.topAnchor.constraint(equalTo: topBottomView.topAnchor),
            topBottomStackView.bottomAnchor.constraint(equalTo: topBottomView.bottomAnchor),
            topBottomStackView.trailingAnchor.constraint(equalTo: topBottomView.trailingAnchor),
            
            pickerColorLabel.topAnchor.constraint(equalTo: topCenterView.topAnchor),
            pickerColorLabel.leadingAnchor.constraint(equalTo: topCenterView.leadingAnchor),
            
            pickerColorButton.leadingAnchor.constraint(equalTo: topCenterView.leadingAnchor),
            pickerColorButton.topAnchor.constraint(greaterThanOrEqualTo: pickerColorLabel.bottomAnchor, constant: 15),
            pickerColorButton.widthAnchor.constraint(equalToConstant: 30),
            pickerColorButton.heightAnchor.constraint(equalToConstant: 30),
            
            timePickerView.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            timePickerView.centerYAnchor.constraint(equalTo: centerView.centerYAnchor),
        ])
    }
}

//MARK: - Deligate

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        pickerColorButton.backgroundColor = color
        pickerColorButton.layer.borderWidth = 0
    }
}

