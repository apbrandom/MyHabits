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
        return button
    }()
    
    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 21, left: 0, bottom: 0, right: 0)
        
        let itemWidth = UIScreen.main.bounds.width - 16 * 2
        let itemHeight = UIScreen.main.bounds.height / 5.5
        layout.itemSize = CGSize(width:  itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
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
        
        present(navigationController, animated: true, completion: nil)
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

//MARK: - 

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.indentifire, for: indexPath)
        return cell
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {}


