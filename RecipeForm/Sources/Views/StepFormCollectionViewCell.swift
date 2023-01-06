//
//  StepFormCollectionViewCell.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 04.01.2023.
//

import UIKit
import Resources

final class StepFormCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let stepNumberBackgroundView: UIView = {
        let view = UIView()
//        view.backgroundColor = Colors.tertiaryLabel
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func configure() {
        
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
