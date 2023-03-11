//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 09.03.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //MARK: - Private
    
    private func setupView() {
        title = "Привычки"
        view.backgroundColor = .systemGray5
        
        tabBarItem = UITabBarItem(
            title: "Привычки",
            image: UIImage(systemName: "rectangle.grid.1x2.fill"),
            tag: 0)
        
    }
    
    
}
