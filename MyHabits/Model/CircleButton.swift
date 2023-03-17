//
//  CircleButton.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 16.03.2023.
//

import UIKit

class CircleButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}
