//
//  HabitDetailViewController.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 20.03.2023.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    //MARK: - Data
    
    var habit: Habit?
    
    //MARK: - Subview
    
    private lazy var detailsTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemGray5
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
        configureTableView()
    }
    
    //MARK: - Action
    
    @objc func didTapDismissButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapChangeButton() {
        let habitViewController = HabitViewController()
        
        habitViewController.habit = habit
        habitViewController.editScreen = true
        
        let navigationController = UINavigationController(
            rootViewController: habitViewController
        )
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
    
    //MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        setupNavigation()
    }
    
    private func setupNavigation() {
        if let habitName = habit?.name {
            titleLabel.text = habitName
        } else {
            titleLabel.text = ""
        }
        
        navigationItem.titleView = titleLabel
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(didTapDismissButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .done,
            target: self,
            action: #selector(didTapChangeButton))
    }
    
    private func setupSubviews() {
        view.addSubview(detailsTableView)
    }
    
    private func configureTableView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HabitDateCell")
    }
    
    //    private func indexOfCreationDate(for habit: Habit?) -> Int? {
    //        guard let habit = habit else { return nil }
    //        let creationDate = habit.date
    //        let dates = HabitsStore.shared.dates
    //
    //        return dates.firstIndex(where: { $0 >= creationDate })
    //    }
    //
    //    func datesFromCreationDateToToday(for habit: Habit) -> [Date] {
    //        guard let index = indexOfCreationDate(for: habit) else { return [] }
    //        let dates = HabitsStore.shared.dates + [Date()]
    //        return Array(dates[index...])
    //    }
    
    
    //MARK: - Layout
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            detailsTableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor),
            detailsTableView.topAnchor.constraint(
                equalTo: safeArea.topAnchor),
            detailsTableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor),
            detailsTableView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension HabitDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "HabitDateCell",
            for: indexPath)
        
        let date = HabitsStore.shared.dates[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        cell.textLabel?.text = dateFormatter.string(from: date)
        
        if let habit = habit, HabitsStore.shared.habit(habit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

extension HabitDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection  section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.text = "Активность"
        headerLabel.font = UIFont(name: "SF Pro Text", size: 13)
        headerLabel.textColor = .systemGray
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = UIView()
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 22),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -6.5)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
