//
//  NoteViewController.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 12/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    var note: Note? {
        didSet {
            loadViewIfNeeded()
            titleTextField.text = note?.title
            dateLabel.text = Date.getDateString(from: (note?.date)!)
            expirationDate.text = Date.getDateString(from: (note?.expirationDate)!)
            noteTextView.text = note?.noteTextView
//            navigationItem.title = note?.title
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Note title:"
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .green
        textField.placeholder = "Write title here"
        textField.textColor = UIColor.lightGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let titleDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "99/99/9999"
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let titleExpirationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Expires"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let expirationDate: UILabel = {
        let label = UILabel()
        label.text = "99/99/9999"
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .yellow
        return image
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = note == nil ? "New note" : "Edit note"
//        navigationController?.isToolbarHidden = false
        let notesVC = NotesTableViewController()
        notesVC.delegate = self
        setupUI()
print("viewDidLoad")
        
        view.backgroundColor = .white

//        let photoBarButton = UIBarButtonItem(barButtonSystemItem: .camera,
//                                             target: self,
//                                             action: #selector(getPhoto))
//        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//                                       target: nil,
//                                       action: nil)
//
//        let mapBarButton = UIBarButtonItem(title: "Map",
//                                           style: .done,
//                                           target: self,
//                                           action: #selector(addLocation))
//        self.setToolbarItems([photoBarButton, flexible, mapBarButton], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = note == nil ? "New note" : "Edit note"
    }
    
    @objc func getPhoto() {
        
    }
    
    @objc func addLocation()
    {
        
    }

    
    // MARK: - UI Setup
    private func setupUI() {
        let navControllerHeight: CGFloat = 64
        let spaceBetweenFields: CGFloat = 8
        let labelHeight: CGFloat = 30
        let dateFieldWidth: CGFloat = 110
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: navControllerHeight).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: spaceBetweenFields).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        view.addSubview(titleTextField)
        titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: spaceBetweenFields).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(titleDateLabel)
        titleDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: navControllerHeight).isActive = true
        titleDateLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: spaceBetweenFields).isActive = true
        titleDateLabel.widthAnchor.constraint(equalToConstant: dateFieldWidth).isActive = true
        titleDateLabel.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: titleDateLabel.bottomAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: titleTextField.rightAnchor, constant: 5).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: dateFieldWidth).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: titleTextField.heightAnchor).isActive = true
        
        view.addSubview(titleExpirationDateLabel)
        titleExpirationDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: navControllerHeight).isActive = true
        titleExpirationDateLabel.leftAnchor.constraint(equalTo: titleDateLabel.rightAnchor).isActive = true
        titleExpirationDateLabel.widthAnchor.constraint(equalToConstant: dateFieldWidth).isActive = true
        titleExpirationDateLabel.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        view.addSubview(expirationDate)
        expirationDate.topAnchor.constraint(equalTo: titleExpirationDateLabel.bottomAnchor).isActive = true
        expirationDate.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 5).isActive = true
        expirationDate.widthAnchor.constraint(equalToConstant: dateFieldWidth).isActive = true
        expirationDate.heightAnchor.constraint(equalTo: titleTextField.heightAnchor).isActive = true
        
        let a = UIToolbar()
        a.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(a)
        a.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        a.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        a.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        a.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let photoBarButton = UIBarButtonItem(barButtonSystemItem: .camera,
                                             target: self,
                                             action: #selector(getPhoto))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                       target: nil,
                                       action: nil)
        
        let mapBarButton = UIBarButtonItem(title: "Map",
                                           style: .done,
                                           target: self,
                                           action: #selector(addLocation))
        a.setItems([photoBarButton, flexible, mapBarButton], animated: true)
        
        view.addSubview(noteTextView)
        noteTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: spaceBetweenFields).isActive = true
        noteTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: spaceBetweenFields).isActive = true
        noteTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -spaceBetweenFields).isActive = true
        noteTextView.bottomAnchor.constraint(equalTo: a.topAnchor, constant: -spaceBetweenFields).isActive = true
        
        noteTextView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: (imageView.superview?.topAnchor)!, constant: spaceBetweenFields).isActive = true
        imageView.leftAnchor.constraint(equalTo: (imageView.superview?.leftAnchor)!, constant: spaceBetweenFields).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        

//        navigationController?.isToolbarHidden = false
//        let photoBarButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
//        self.setToolbarItems([photoBarButton], animated: false)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Notes", style: .done, target: self, action: #selector(handleShowList))
    }
    
    @objc private func handleShowList() {
        print("show list")
    }
}

extension NoteViewController: NotesTableViewControllerDelegate {
    func notesTableViewController(_ vc: NotesTableViewController, didSelectNote note: Note) {
        self.note = note
    }
}
