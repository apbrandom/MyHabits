//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 09.03.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - Data
    
    let infoText = InfoText.text
    
    //MARK: - Subviews
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerLabel: UILabel = {
        let textView = UILabel()
        textView.text = "Привычка за 21 день"
        textView.font = .systemFont(ofSize: 20, weight: .semibold)
        textView.backgroundColor = .systemBackground
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var infoTextView: UILabel = {
        let textView = UILabel()
        textView.text = infoText
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.lineBreakMode = .byWordWrapping
        textView.numberOfLines = 100
        textView.backgroundColor = .systemBackground
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstrains()
    }
    
    //MARK: - Private
    
    private func setupView() {
        title = "Информация"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        tabBarItem = UITabBarItem(
            title: "Информация",
            image: UIImage(systemName: "info.circle.fill"),
            tag: 0)
        tabBarItem.selectedImage = UIImage(systemName: "info.circle.fill")?.withTintColor(UIColor.systemPurple, renderingMode: .alwaysOriginal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemPurple], for: .selected)
    }
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(infoTextView)
        
    }
    
    private func setupConstrains() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            infoTextView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            infoTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
