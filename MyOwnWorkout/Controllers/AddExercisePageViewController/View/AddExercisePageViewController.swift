//
//  ExercisePageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 21.10.2023.
//

import UIKit

protocol AddExercisePageViewControllerDelegate: AnyObject {
    func addExerciseToTableView()
}

class AddExercisePageViewController: GeneralViewController {
    
    var presenter: AddExercisePagePresenter!
    
    weak var delegate: AddExercisePageViewControllerDelegate?
    
    let exerciseTitle = UITextField()
    let exerciseAbout = UITextField()
    let saveExerciseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addExercisePageDesign()
        setupSaveExerciseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
extension AddExercisePageViewController {
    
    func setupSaveExerciseButton() {
        saveExerciseButton.addTarget(self, action: #selector(setupSaveExerciseButtonAction), for: .touchUpInside)
    }
    
    @objc func setupSaveExerciseButtonAction() {
        saveExercise(exerciseTitle.text ?? "Без названия", exerciseAbout.text ?? "Порядок выполнения")
        self.dismiss(animated: true)
    }
    
    func saveExercise(_ title: String, _ about: String) {
        let exercises = ExerciseModel(title: title, about: about)
        RealmDataBase.shared.setExercisesData(exercises)
        delegate?.addExerciseToTableView()
    }
    
    func addExercisePageDesign() {
        
        exerciseTitle.placeholder = "Название упражнения"
        exerciseAbout.placeholder = "Порядок выполнения"
        saveExerciseButton.setTitle("Сохранить", for: .normal)
        saveExerciseButton.backgroundColor = .systemRed
        saveExerciseButton.layer.cornerRadius = 12
        
        view.addSubviews(exerciseTitle, exerciseAbout, saveExerciseButton)
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            exerciseTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseTitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50),
            exerciseTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseTitle.heightAnchor.constraint(equalToConstant: 50),
            
            exerciseAbout.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            exerciseAbout.topAnchor.constraint(equalTo: exerciseTitle.bottomAnchor, constant: 10),
            exerciseAbout.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            exerciseAbout.heightAnchor.constraint(equalToConstant: 50),
            
            saveExerciseButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            saveExerciseButton.topAnchor.constraint(equalTo: exerciseAbout.bottomAnchor, constant: 30),
            saveExerciseButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            saveExerciseButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
}

extension AddExercisePageViewController: AddExercisePagePresenterDelegate {
    
}
