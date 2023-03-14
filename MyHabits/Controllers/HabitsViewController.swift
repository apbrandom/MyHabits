//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 09.03.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    //MARK: - Subviews
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        button.tintColor = .systemPurple
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    //MARK: - Action
    
    @objc func addButtonTapped() {
        print("Hello")
    }
    
    //MARK: - Private
    
    private func setupView() {
        title = "Привычки"
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .systemBackground

        tabBarItem = UITabBarItem(
            title: "Привычки",
            image: UIImage(systemName: "rectangle.grid.1x2.fill"),
            tag: 0)
        tabBarItem.selectedImage = UIImage(systemName: "rectangle.grid.1x2.fill")?.withTintColor(UIColor.systemPurple, renderingMode: .alwaysOriginal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemPurple], for: .selected)


    }
    
}

