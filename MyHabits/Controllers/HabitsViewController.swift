//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 09.03.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    var habits = HabitsStore.shared.habits
    
    //MARK: - Subviews
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        return button
    }()
    
    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(
            top: 22,
            left: 0,
            bottom: 0,
            right: 0
        )
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        habits = HabitsStore.shared.habits
        habitsCollectionView.reloadData()
        
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
        view.backgroundColor = .systemGray6
        
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return habits.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.indentifire,
                for: indexPath) as? ProgressCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.update()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitCollectionViewCell.indentifire,
                for: indexPath) as? HabitCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            let habit = habits[indexPath.item]
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
        
        if indexPath.section == 0 {
            return CGSize(
                width: itemWidth,
                height: progressItemHeight
            )
        } else {
            return CGSize(
                width: itemWidth,
                height: habitItemHeight
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habitDetailVC = HabitDetailViewController()
        if indexPath.section == 1 {
            habitDetailVC.habit = habits[indexPath.item]
            navigationController?.pushViewController(habitDetailVC, animated: true)
        }
    }
}

extension HabitsViewController: HabitCollectionViewCellDelegate {
    func habitCellDidUpdate(_ cell: HabitCollectionViewCell) {
        guard let progressCell = habitsCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? ProgressCollectionViewCell else { return }
        progressCell.update()
    }
}

