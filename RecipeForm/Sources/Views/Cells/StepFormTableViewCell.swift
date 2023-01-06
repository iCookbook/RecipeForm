//
//  StepFormTableViewCell.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 04.01.2023.
//

import UIKit
import Resources
import Models
import Logger

final class StepFormTableViewCell: UITableViewCell {
    
    /// We need to save link to the source view to open image picker.
    weak var sourceView: RecipeFormViewController?
    
    // MARK: - Private Properties
    
    private let stepNumberBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.secondaryLabel
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stepNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = Fonts.body()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stepDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = Texts.RecipeForm.stepDescriptionPlaceholder
        textView.textColor = Colors.placeholderText
        textView.font = Fonts.smallBody()
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var recipeImagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        return imagePicker
    }()
    
    private lazy var stepImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.RecipeForm.sampleStepImage
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnRecipeImageView))
        imageView.addGestureRecognizer(tap)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stepNumberLabel.text = nil
        stepDescriptionTextView.text = Texts.RecipeForm.stepDescriptionPlaceholder
        stepDescriptionTextView.textColor = Colors.placeholderText
        stepImageView.image = Images.RecipeForm.sampleStepImage
    }
    
    // MARK: - Public Methods
    
    public func configure(with stepData: StepData, number: Int) {
        stepNumberLabel.text = String(number)
        
        if !stepData.text.isEmpty {
            stepDescriptionTextView.text = stepData.text
            stepDescriptionTextView.textColor = Colors.label
        }
        
        if let data = stepData.imageData {
            stepImageView.image = UIImage(data: data)
//            stepImageView.heightAnchor.constraint(equalToConstant: sourceView?.view.frame.height ?? 333 * 0.3).isActive = true
        }
    }
    
    // MARK: - Private Methods
    
    @objc private func handleTapOnRecipeImageView() {
        sourceView?.present(recipeImagePicker, animated: true)
    }
    
    private func setupView() {
        contentView.backgroundColor = Colors.systemGroupedBackground
        contentView.addSubview(stepNumberBackgroundView)
        stepNumberBackgroundView.addSubview(stepNumberLabel)
        contentView.addSubview(stepDescriptionTextView)
        contentView.addSubview(stepImageView)
        
        NSLayoutConstraint.activate([
            stepNumberBackgroundView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stepNumberBackgroundView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stepNumberBackgroundView.heightAnchor.constraint(equalToConstant: 32),
            stepNumberBackgroundView.widthAnchor.constraint(equalToConstant: 32),
            
            stepNumberLabel.centerXAnchor.constraint(equalTo: stepNumberBackgroundView.centerXAnchor),
            stepNumberLabel.centerYAnchor.constraint(equalTo: stepNumberBackgroundView.centerYAnchor),
            
            stepDescriptionTextView.leadingAnchor.constraint(equalTo: stepNumberBackgroundView.trailingAnchor, constant: 8),
            stepDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stepDescriptionTextView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stepDescriptionTextView.bottomAnchor.constraint(equalTo: stepImageView.topAnchor, constant: -8),
            
            stepImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stepImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stepImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width - 100),
            stepImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate

extension StepFormTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        defer {
            picker.dismiss(animated: true)
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            Logger.log("Could not define edited image", logType: .error)
            return
        }
        
        stepImageView.image = image
        
        guard let data = image.pngData() else {
            Logger.log("Could convert edited image in raw data", logType: .warning)
            return
        }
        sourceView?.updateStepData(with: data, in: indexPath?.row ?? 0)
    }
}

// MARK: - UITextViewDelegate

extension StepFormTableViewCell: UITextViewDelegate {
    
    /// Adds dynamic height to the TextView and provide data.
    func textViewDidChange(_ textView: UITextView) {
        sourceView?.updateHeightOfRow(self, textView)
        
        guard let text = textView.text,
              let row = indexPath?.row else { return } // do nothing
        
        sourceView?.updateStepData(with: text, in: row)
    }
    
    /// Adds placeholder to the TextView.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Colors.placeholderText {
            textView.text = nil
            textView.textColor = Colors.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Texts.RecipeForm.stepDescriptionPlaceholder
            textView.textColor = Colors.placeholderText
        }
    }
}
