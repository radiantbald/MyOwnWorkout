//
//  ExercisePhotosCollectionModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.12.2023.
//

import UIKit

struct ExercisePhotosCollectionModel {
    var photo: UIImage
    
    static func fetchPhoto() -> [ExercisePhotosCollectionModel] {
        let first = ExercisePhotosCollectionModel(photo: UIImage(named: "gachi1")!)
        let second = ExercisePhotosCollectionModel(photo: UIImage(named: "gachi2")!)
        let third = ExercisePhotosCollectionModel(photo: UIImage(named: "gachi3")!)
        let forth = ExercisePhotosCollectionModel(photo: UIImage(named: "gachi4")!)
        return [first, second, third, forth]
    }
}

struct Constants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let minimumLineSpacing: CGFloat = 10
    static let itemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.minimumLineSpacing / 2)) / 2
}
