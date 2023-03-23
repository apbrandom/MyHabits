//
//  HabitCollectionViewCellDelegate.swift
//  MyHabits
//
//  Created by Вадим Виноградов on 22.03.2023.
//

import Foundation

protocol HabitCollectionViewCellDelegate: AnyObject {
    func habitCellDidUpdate(_ cell: HabitCollectionViewCell)
}
