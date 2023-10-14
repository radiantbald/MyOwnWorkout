//
//  ScheduleViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 24.05.2023.
//

import UIKit

class PersonPageViewController: GeneralViewController {

    var presenter: PersonPagePresenter!
    
    private var menu = UIMenu()
    
    private lazy var imagePicker = UIImagePickerController()
    
    var personPageAvatar: UIImageView = {
        let personPageAvatar = UIImageView()
        personPageAvatar.translatesAutoresizingMaskIntoConstraints = false
        return personPageAvatar
    }()
    var personPageName: UILabel = {
        let personPageName = UILabel()
        personPageName.translatesAutoresizingMaskIntoConstraints = false
        return personPageName
    }()
    var personPageNickname: UILabel = {
        let personPageNickname = UILabel()
        personPageNickname.translatesAutoresizingMaskIntoConstraints = false
        return personPageNickname
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuAction()
        personPageDesign()
        setupAvatarAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

extension PersonPageViewController {
    
    func saveUserAvatarImageAction(_ image: UIImage) {
        personPageAvatar.image = image
        avatarImage = image
    }
    
    private func setupAvatarAction() {
        presenter.setupAvatar()
    }
    
    @objc private func avatarTapAction() {
        presenter.avatarTap()
    }
    
    private func setupMenuAction() {
        presenter.setupMenu()
    }
    
    private func openTrainingProgramsPageAction() {
        presenter.openTrainingProgramsPage()
    }
    
    private func openMyWorkoutsPageAction() {
        presenter.openMyWorkoutsPage()
    }
    
    private func openMyExercisesPageAction() {
        presenter.openMyExercisesPage()
    }
    
    private func openMyAchievmentsPageAction() {
        presenter.openMyAchievmentsPage()
    }
    
    private func openPersonalAccountPageAction() {
        presenter.openPersonalAccountPage()
    }
    
    private func openSettingsPageAction() {
        presenter.openSettingsPage()
    }
    
    private func openAboutPagePageAction() {
        presenter.openAboutAppPage()
    }
    
    private func exitAction() {
        presenter.exit()
    }
    
}

extension PersonPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveUserAvatarImageAction(pickedImage)
            dismiss(animated: true)
        }
    }
}

extension PersonPageViewController {
    
    func personPageDesign() {
        view.backgroundColor = .white
        
        navigationItem.backButtonTitle = "Назад"
        navigationItem.title = "Мой кабинет"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), menu: menu)
        
        view.addSubview(personPageAvatar)
        view.addSubview(personPageName)
        view.addSubview(personPageNickname)
        
        personPageAvatar.frame.size.width = 75
        personPageAvatar.frame.size.height = personPageAvatar.frame.size.width
        
        personPageName.text = "Имя пользователя"
        personPageName.baselineAdjustment = .alignCenters
        
        personPageNickname.text = "Никнейм пользователя"
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            personPageAvatar.heightAnchor.constraint(equalToConstant: personPageAvatar.frame.size.width),
            personPageAvatar.widthAnchor.constraint(equalToConstant: personPageAvatar.frame.size.height),
            personPageAvatar.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            personPageAvatar.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
            
            personPageName.heightAnchor.constraint(equalToConstant: 30),
            personPageName.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            personPageName.leadingAnchor.constraint(equalTo: personPageAvatar.trailingAnchor, constant: 10),
            personPageName.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            
            personPageNickname.heightAnchor.constraint(equalToConstant: 30),
            personPageNickname.topAnchor.constraint(equalTo: personPageName.bottomAnchor, constant: 10),
            personPageNickname.leadingAnchor.constraint(equalTo: personPageAvatar.trailingAnchor, constant: 10),
            personPageNickname.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10)
        ])
    }
}
//MARK: - Делегаты презентера

extension PersonPageViewController: PersonPagePresenterDelegate {

    func setupAvatar() {
        
        personPageAvatar.image = avatarImage
        setupAvatarBounds(avatar: personPageAvatar)
        
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapAction))
        tapGesture.delegate = self
        personPageAvatar.isUserInteractionEnabled = true
        personPageAvatar.addGestureRecognizer(tapGesture)        
    }
    
    func avatarTap() {
        
        let actionImage = UIAlertController(title: "Сменить аватарку", message: nil, preferredStyle: .actionSheet)
        
//        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
//            self.imagePicker.sourceType = .camera
//            self.imagePicker.cameraDevice = .front
//            self.imagePicker.allowsEditing = true
//            self.navigationController?.present(self.imagePicker, animated: true)
//        }
        
        let photoLibrary = UIAlertAction(title: "Фотоальбом", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.navigationController?.present(self.imagePicker, animated:true)
        }
        
//        let buffer = UIAlertAction(title: "Вставить из буфера", style: .default) { _ in
//            if let image = UIPasteboard.general.image {
//                self.saveUserAvatarImageAction(image)
//            }
//        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
//        actionImage.addAction(camera)
        actionImage.addAction(photoLibrary)
//        actionImage.addAction(buffer)
        actionImage.addAction(cancel)
        
        if let popover = actionImage.popoverPresentationController {
            popover.sourceView = self.view
            let frame = view.frame
            popover.sourceRect = CGRect(x: frame.midX, y: frame.maxY, width: 1.0, height: 1.0)
        }
        self.present(actionImage, animated: true)
    }
    
    func setupMenu() {
        
        let trainingPrograms = UIAction(title: "Программы тренировок", handler: { _ in self.openTrainingProgramsPageAction()})
        
        let myWorkouts = UIAction(title: "Мои тренировки", handler: { _ in self.openMyWorkoutsPageAction()})
     
        let myExercises = UIAction(title: "Мои упражнения", handler: { _ in self.openMyExercisesPageAction()})
        
        let myAchievments = UIAction(title: "Мои достижения", image: UIImage(systemName: "star"), handler: { _ in self.openMyAchievmentsPageAction()})
        
        let personalAccount = UIAction(title: "Лицевой счет",image: UIImage(systemName: "banknote"), handler: { _ in self.openPersonalAccountPageAction()})
        
        let settings = UIAction(title: "Настройки", image: UIImage(systemName: "gear"), handler: { _ in self.openSettingsPageAction()})
        
        let aboutApp = UIAction(title: "О приложении",image: UIImage(systemName: "apple.logo"), handler: { _ in self.openAboutPagePageAction()})
        
        let exit = UIAction(title: "Выход", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), attributes: .destructive, handler: { _ in self.exitAction()})
        
        menu = UIMenu(title: "Меню", children: [trainingPrograms, myWorkouts, myExercises, myAchievments, personalAccount, settings, aboutApp, exit])
    }
    
    func openTrainingProgramsPage() {
        let viewController = Assembler.controllers.trainingProgramsPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyWorkoutsPage() {
        let viewController = Assembler.controllers.myWorkoutsPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyExercisesPage() {
        let viewController = Assembler.controllers.myExercisesPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyAchievmentsPage() {
        let viewController = Assembler.controllers.myAchievmentsPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openPersonalAccountPage() {
        let viewController = Assembler.controllers.personalAccountPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openSettingsPage() {
        let viewController = Assembler.controllers.settingsPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openAboutAppPage() {
        let viewController = Assembler.controllers.aboutAppPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func exit() {
        navigationController?.popToRootViewController(animated: true)
    }
}

