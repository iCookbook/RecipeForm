//
//  RecipeFormViewController.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import UIKit
import CommonUI
import Models
import Resources
import Logger

final class RecipeFormViewController: UIViewController {
    
    /// View model.
    var recipeData = RecipeData.default {
        didSet {
            presenter.checkBarButtonEnabled(recipeData)
        }
    }
    
    // MARK: - Private Properties
    
    private let presenter: RecipeFormViewOutput
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        barButton.isEnabled = false
        return barButton
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var recipeImagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        return imagePicker
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.sampleRecipeImage
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnRecipeImageView))
        imageView.addGestureRecognizer(tap)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = TableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeFormTableViewCell.self, forCellReuseIdentifier: RecipeFormTableViewCell.identifier)
        tableView.register(StepFormTableViewCell.self, forCellReuseIdentifier: StepFormTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init
    
    init(presenter: RecipeFormViewOutput) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter.viewDidLoad()
        
        /// This method allows to hide keyboard when user taps in any place. It is declared in `Extensions/UIKit/UIViewController.swift`
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterForKeyboardNotifications()
    }
    
    // MARK: - Private Methods
    
    @objc private func dismissThisModule() {
        
        defer {
            presenter.dismissThisModule()
        }
        
        if saveBarButton.isEnabled {
            let alert = UIAlertController(title: Texts.RecipeForm.unsavedChangesTitle, message: Texts.RecipeForm.unsavedChangesDescription, preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: Texts.RecipeForm.save, style: .destructive, handler: { [unowned self] _ in
                presenter.saveRecipe(with: recipeData)
            })
            let no = UIAlertAction(title: Texts.RecipeForm.cancel, style: .cancel)
            
            alert.addAction(yes)
            alert.addAction(no)
            
            /// For definition try to open declaration of this function in CommonUI.UIAlertController.swift
            alert.negativeWidthConstraint()
            present(alert, animated: true)
        }
    }
    
    @objc private func handleTapOnRecipeImageView() {
        present(recipeImagePicker, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        presenter.saveRecipe(with: recipeData)
    }
    
    private func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissThisModule))
        navigationItem.rightBarButtonItem = saveBarButton
        
        view.backgroundColor = Colors.systemGroupedBackground
        view.addSubview(scrollView)
        scrollView.addSubview(recipeImageView)
        scrollView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            recipeImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            recipeImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.38),
            recipeImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}

extension RecipeFormViewController: RecipeFormViewInput {
    
    func displayData(_ recipeData: RecipeData) {
        /// We do not need to update view if recipe was not provided for this module originally.
        let viewToUpdateFlag = recipeData != RecipeData.default
        self.recipeData = recipeData
        
        if viewToUpdateFlag {
            tableView.reloadData()
        }
    }
    
    /// Sets enabling _save_ bar button.
    ///
    /// - Parameter result: Flag representing enabling bar buttom item.
    func changeBarButtonEnabledState(_ flag: Bool) {
        saveBarButton.isEnabled = flag
    }
}

// MARK: - Table View

extension RecipeFormViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            /// _Title_ and _Notes_ fields.
            return 2
        case 1:
            /// Text fields for fats, calories etc.
            return 6
        case 2:
            /// _Steps_ section. We need to add 1 for new step.
            return recipeData.steps?.count ?? 0 + 1
        default:
            Logger.log("Unexpected section \(section)", logType: .warning)
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0...1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeFormTableViewCell.identifier, for: indexPath) as? RecipeFormTableViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: indexPath)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepFormTableViewCell.identifier, for: indexPath) as? StepFormTableViewCell else {
                fatalError()
            }
            
            guard let stepData = recipeData.steps?[indexPath.row] else {
                return cell
            }
            
            cell.configure(with: stepData)
            return cell
        default:
            Logger.log("Unexpected section \(indexPath.section)", logType: .error)
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - RecipeFormTableViewCellDelegate

extension RecipeFormViewController: RecipeFormTableViewCellDelegate {
    
    func updateHeightOfRow(_ cell: RecipeFormTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        if size.height != newSize.height {
            tableView.beginUpdates()
            tableView.endUpdates()
            /// Scrolls up to the text view.
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}

// MARK: - Helper methods

private extension RecipeFormViewController {
    /**
     Methods below easify working with keyboard input. It is very important for UX
     */
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RecipeFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        defer {
            picker.dismiss(animated: true)
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            Logger.log("Could not define edited image", logType: .error)
            return
        }
        
        recipeImageView.image = image
        recipeData.imageData = image.pngData()
    }
}
