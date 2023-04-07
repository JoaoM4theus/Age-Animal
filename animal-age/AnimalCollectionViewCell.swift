//
//  AnimalCollectionViewCell.swift
//  animal-age
//
//  Created by Joao Matheus on 07/04/23.
//

import UIKit

class AnimalCollectionViewCell: UICollectionViewCell {
    static let identifier = "AnimalCollectionViewCell"

    lazy var animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    lazy var animalTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(type: AnimalType) {
        setUpShadows()
        setUpConstraint()
        animalTypeLabel.text = type.type
        animalImageView.image = UIImage(named: type.image)
    }
    
    private func setUpConstraint() {
        contentView.addSubview(animalImageView)
        contentView.addSubview(animalTypeLabel)
        
        NSLayoutConstraint.activate([
            animalImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            animalImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            animalImageView.heightAnchor.constraint(equalToConstant: 235),
            
            animalTypeLabel.topAnchor.constraint(equalTo: animalImageView.bottomAnchor, constant: 8),
            animalTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setUpShadows() {
        let shadows = UIView()
        shadows.frame = contentView.frame
        shadows.clipsToBounds = false
        contentView.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 12)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        let shapes = UIView()
        shapes.backgroundColor = .white
        shapes.frame = contentView.frame
        shapes.clipsToBounds = true
        contentView.addSubview(shapes)
        
        shapes.clipsToBounds = true
        shapes.layer.cornerRadius = 12
    }
}
