//
//  AgeViewController.swift
//  animal-age
//
//  Created by Joao Matheus on 07/04/23.
//

import UIKit

class AgeViewController: UIViewController {

    lazy var viewClose: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 4
        return view
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    lazy var datePickerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Data de nascimento"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.formatterDate(date: Date())
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 200)
        textField.inputView = datePicker

        return textField
    }()
    
    lazy var calculateAge: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CALCULAR IDADE", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(calculate), for: .touchUpInside)
        return button
    }()
    
    let animalType: AnimalType
    
    init(animalType: AnimalType) {
        self.animalType = animalType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraint()
        configureTitleLabel()
        view.backgroundColor = .white
    }

    private func configureTitleLabel() {
        messageLabel.text = "Legal! O seu animal é de \(animalType.type.lowercased()). Por gentileza, informar a data de nascimento do seu animal logo abaixo."
    }
    
    private func setUpConstraint() {
        view.addSubview(viewClose)
        view.addSubview(messageLabel)
        view.addSubview(datePickerTextField)
        view.addSubview(calculateAge)
        
        NSLayoutConstraint.activate([
            viewClose.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            viewClose.widthAnchor.constraint(equalToConstant: 35),
            viewClose.heightAnchor.constraint(equalToConstant: 5),
            viewClose.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: viewClose.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            datePickerTextField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 40),
            datePickerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            datePickerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            datePickerTextField.heightAnchor.constraint(equalToConstant: 45),
            
            calculateAge.topAnchor.constraint(equalTo: datePickerTextField.bottomAnchor, constant: 20),
            calculateAge.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65),
            calculateAge.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65),
            calculateAge.heightAnchor.constraint(equalToConstant: 45),
        ])
    }

    @objc func datePickerValueChanged(sender: UIDatePicker) {
        datePickerTextField.formatterDate(date: sender.date)
    }
    
    @objc func calculate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        if let date = dateFormatter.date(from: datePickerTextField.text ?? "") {
            let year = yearsBetweenDate(startDate: date, endDate: Date())
            var message: String = ""
            switch animalType {
            case .small:
                message = "Animal tem \(year) anos e \(year * 6) anos humano."
            case .medium:
                message = "Animal tem \(year) anos e \(year * 7) anos humano."
            case .large:
                message = "Animal tem \(year) anos e \(Double(year) * 7.5) anos humano."
            }
            let alert = UIAlertController(title: "Resultado",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    func yearsBetweenDate(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: startDate, to: endDate)
        return components.year!
    }
}

extension UITextField {
    func formatterDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.text = formatter.string(from: date)
    }
}
