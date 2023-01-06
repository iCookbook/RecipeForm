//
//  RecipeFormTableViewCell.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 06.01.2023.
//

import UIKit
import Resources
import Models
import Logger

final class RecipeFormTableViewCell: UITableViewCell {
    
    var recipeData: RecipeData?
    weak var delegate: RecipeFormTableViewCellDelegate?
    
    // MARK: - Private Properties
    
    /// We use `10` as control value, because it is the value where all words will be in plural form.
    private let labelsArray = [Texts.RecipeDetails.minutes(count: 10),
                               Texts.RecipeDetails.servings(count: 10),
                               Texts.RecipeDetails.calories(count: 10),
                               Texts.RecipeDetails.protein(count: 10),
                               Texts.RecipeDetails.fat(count: 10),
                               Texts.RecipeDetails.carbs(count: 10)]
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = Fonts.body()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleTextField = UITextField(keyboardType: .default, placeholder: Texts.RecipeForm.titlePlaceholder, textAlignment: .left, borderStyle: .none)
    private lazy var decimalTextField = UITextField(keyboardType: .decimalPad, placeholder: "0.0", borderStyle: .roundedRect)
    
    private lazy var notesTextView: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.font = Fonts.smallSystemBody()
        textView.text = Texts.RecipeForm.notesPlaceholder
        textView.backgroundColor = .clear
        textView.textColor = Colors.placeholderText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.resignFirstResponder()
        return textView
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
        
        label.isHidden = true
        titleTextField.isHidden = true
        decimalTextField.isHidden = true
        notesTextView.isHidden = true
    }
    
    // MARK: - Public Methods
    
    public func configure(with indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            titleTextField.isHidden = false
            titleTextField.text = recipeData?.name
        case (0, 1):
            notesTextView.isHidden = false
            
            if let notes = recipeData?.comment, notes != Texts.RecipeForm.notesPlaceholder, !notes.isEmpty {
                notesTextView.text = notes
                notesTextView.textColor = Colors.label
            }
        case (1, _):
            decimalTextField.isHidden = false
            /// Value to set in text field.
            var value: String?
            
            switch indexPath.row {
            case 0:
                if let cookingTime = recipeData?.cookingTime {
                    value = String(cookingTime)
                }
            case 1:
                if let numberOfServings = recipeData?.numberOfServings {
                    value = String(numberOfServings)
                }
            case 2:
                if let calories = recipeData?.calories {
                    value = String(calories)
                }
            case 3:
                if let proteins = recipeData?.proteins {
                    value = String(proteins)
                }
            case 4:
                if let fats = recipeData?.fats {
                    value = String(fats)
                }
            case 5:
                if let carbohydrates = recipeData?.carbohydrates {
                    value = String(carbohydrates)
                }
            default:
                Logger.log("Unexpected indexPath row was provided: \(indexPath.row)", logType: .warning)
            }
            
            decimalTextField.text = value
            label.isHidden = false
            label.text = labelsArray[indexPath.row]
        default:
            Logger.log("Unexpected indexPath was provided: \(indexPath)", logType: .warning)
            break
        }
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.backgroundColor = Colors.systemGroupedBackground
        contentView.addSubview(label)
        contentView.addSubview(titleTextField)
        titleTextField.clearButtonMode = .whileEditing
        titleTextField.addTarget(self, action: #selector(titleTextFieldChange), for: .allEditingEvents)
        contentView.addSubview(notesTextView)
        
        contentView.addSubview(decimalTextField)
        decimalTextField.addTarget(self, action: #selector(decimalTextFieldChange), for: .allEditingEvents)
        
        [titleTextField, decimalTextField].forEach {
            $0.delegate = self
        }
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleTextField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            notesTextView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: -4),
            notesTextView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            notesTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            notesTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            decimalTextField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            decimalTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            decimalTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension RecipeFormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // limiting input to 120 symbols
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 120
    }
    
    @objc private func titleTextFieldChange(_ sender: UITextField) {
        delegate?.recipeData.name = sender.text ?? ""
    }
    
    @objc private func decimalTextFieldChange(_ sender: UITextField) {
        switch indexPath {
        case [1, 0]:
            delegate?.recipeData.cookingTime = Int32(sender.text ?? "0")
        case [1, 1]:
            delegate?.recipeData.numberOfServings = Int32(sender.text ?? "0")
        case [1, 2]:
            delegate?.recipeData.calories = Double(sender.text ?? "0.0")
        case [1, 3]:
            delegate?.recipeData.proteins = Double(sender.text ?? "0.0")
        case [1, 4]:
            delegate?.recipeData.fats = Double(sender.text ?? "0.0")
        case [1, 5]:
            delegate?.recipeData.carbohydrates = Double(sender.text ?? "0.0")
        default:
            break
        }
    }
}

// MARK: - UITextViewDelegate

extension RecipeFormTableViewCell: UITextViewDelegate {
    
    /// Adds dynamic height to the TextView and provide data.
    func textViewDidChange(_ textView: UITextView) {
        if let deletate = delegate {
            deletate.updateHeightOfRow(self, textView)
            delegate?.recipeData.comment = textView.text ?? ""
        }
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
            textView.text = Texts.RecipeForm.notesPlaceholder
            textView.textColor = Colors.placeholderText
        }
    }
}
