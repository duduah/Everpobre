//
//  NotebookController.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 21/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import UIKit

class NotebookController: UIViewController {
    
    var notebook: Notebook? {
        didSet {
            nameTextField.text = notebook?.name
        }
    }
    
    let labelNameTextField: UILabel = {
        let label = UILabel()
        label.text = "Notebook"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Notebook name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = notebook == nil ? "New notebook" : "Edit notebook"
        
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(labelNameTextField)
        labelNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: navControllerHeight).isActive = true
        labelNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: spaceBetweenFields).isActive = true
        labelNameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        labelNameTextField.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: labelNameTextField.bottomAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: spaceBetweenFields).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    private func cleanFields() {
        nameTextField.text = ""
    }
    
    // MARK: - Actions
    @objc private func handleSave() {
        let context = DataManager.shared.persistantContainer.viewContext
        
        let _ = Notebook(name: nameTextField.text!, inContext: context)
        
        do {
            try context.save()
            cleanFields()
        } catch let saveErr {
            print("Failed saving new notebook:", saveErr)
        }
//        dismiss(animated: true, completion: nil)
    }
}

extension NotebookController: NotebookTableViewControllerDelegate {
    
    func notebookTableViewController(_ vc: NotebookTableViewController, didSelectNotebook notebook: Notebook) {
        self.notebook = notebook
    }
    
    
}
