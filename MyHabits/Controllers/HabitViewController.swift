//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 14.03.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    //MARK: - Action
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        let newHabit = Habit(name: "Выпить стакан воды перед завтраком",
                             date: Date(),
                             color: .systemRed)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        print(store.habits)
    }
    
    //MARK: - Private
    
    private func setupView() {
        title = "Создать"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(dismissButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .done,
            target: self,
            action: #selector(saveButtonTapped))
        
    }
    
}
