//
//  StepFormTableViewCell.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 04.01.2023.
//

import UIKit
import Resources
import Models

final class StepFormTableViewCell: UITableViewCell {
    
    /// Data for a step that will be provided from the outside and filled from the text fields using delegate.
    var stepData: StepData?
    
    // MARK: - Private Properties
    
    private let stepNumberBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.tertiaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stepNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let stepImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.RecipeForm.sampleStepImage
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
    
    // MARK: - Public Methods
    
    public func configure(with stepData: StepData, number: Int) {
        self.stepData = stepData
        stepNumberLabel.text = String(number)
        stepDescriptionTextView.text = stepData.text
        
        if let data = stepData.imageData {
            stepImageView.image = UIImage(data: data)
        }
    }
    
    // MARK: - Private Methods
    
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
        ])
    }
}
