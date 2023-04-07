//
//  ViewController.swift
//  animal-age
//
//  Created by Joao Matheus on 05/04/23.
//

import UIKit

enum AnimalType: CaseIterable {
    case small
    case medium
    case large
    
    var type: String {
        switch self {
        case .small:
            return "Pequeno porte"
        case .medium:
            return "Médio porte"
        case .large:
            return "Grande porte"
        }
    }
    
    var image: String {
        switch self {
        case .small:
            return "pequeno-porte"
        case .medium:
            return "medio-porte"
        case .large:
            return "grande-porte"
        }
    }
}

class HomeViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AnimalCollectionViewCell.self,
                                forCellWithReuseIdentifier: AnimalCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione o porte do seu animal"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let animalsType: [AnimalType] = AnimalType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Idade do animal"
        view.backgroundColor = .white
        setUpConstraint()
    }

    private func setUpConstraint() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCollectionViewCell", for: indexPath) as? AnimalCollectionViewCell
        cell?.configure(type: animalsType[indexPath.row])
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 350, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = AgeViewController(animalType: animalsType[indexPath.row])
        viewController.modalPresentationStyle = .pageSheet
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(viewController, animated: true)
    }
}
