//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 09.03.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    let habits = HabitsStore.shared.habits
    
    //MARK: - Subviews
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        return button
    }()
    
    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(
            red: 242/255,
            green: 242/255,
            blue: 247/255,
            alpha: 1)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
        configureCollectionView()
    }
    
    //MARK: - Action
    
    @objc func addButtonTapped() {
        let habitViewController = HabitViewController()
        let navigationController = UINavigationController(rootViewController: habitViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
    
    //MARK: - Private
    
    private func setupSubviews() {
        view.addSubview(habitsCollectionView)
    }
    
    private func setupView() {
        title = "Сегодня"
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .secondarySystemBackground
        
        tabBarItem = UITabBarItem(
            title: "Привычки",
            image: UIImage(systemName: "rectangle.grid.1x2.fill"),
            tag: 0)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            habitsCollectionView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor),
            habitsCollectionView.topAnchor.constraint(
                equalTo: safeArea.topAnchor),
            habitsCollectionView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        habitsCollectionView.dataSource = self
        habitsCollectionView.delegate = self
        
        habitsCollectionView.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: ProgressCollectionViewCell.indentifire)
        habitsCollectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitCollectionViewCell.indentifire)
    }
}

//MARK: - DataSource

extension HabitsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.indentifire,
                for: indexPath)
            return cell
        } else {
            guard let cell =
                    collectionView.dequeueReusableCell(
                        withReuseIdentifier: HabitCollectionViewCell.indentifire,
                        for: indexPath) as? HabitCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let habit = habits[indexPath.item - 1]
            cell.update(habit)
            return cell
        }
    }
}

//MARK: - DelegateFlowLayout

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width - 16 * 2
        let habitItemHeight = UIScreen.main.bounds.height / 6
        let progressItemHeight: CGFloat = 60
        
        if indexPath.item == 0 {
            return CGSize(width: itemWidth, height: progressItemHeight)
        } else {
            return CGSize(width: itemWidth, height: habitItemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habitDetailVC = HabitDetailViewController()
        if indexPath.item != 0 {
            habitDetailVC.habit = habits[indexPath.item - 1]
        }
        navigationController?.pushViewController(habitDetailVC, animated: true)
    }
    
}



