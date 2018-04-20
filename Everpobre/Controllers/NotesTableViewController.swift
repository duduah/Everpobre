//
//  NotesTableViewController.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 12/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import UIKit

// MARK: - Custom Delegation
protocol NotesTableViewControllerDelegate: AnyObject {
    func notesTableViewController(_ vc: NotesTableViewController, didSelectNote note: Note)
}

class NotesTableViewController: UITableViewController {
    
    // MARK: - Attributes
    let notes = [Note(title: "Title 1", date: Date(), expirationDate: Date(), noteTextView: "Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1."),
                 Note(title: "Title 2", date: Date(), expirationDate: Date(), noteTextView: "Text for note 2. Text for note 2. Text for note 2. Text for note 2. Text for note 2. Text for note 2. "),
                 Note(title: "Title 3", date: Date(), expirationDate: Date(), noteTextView: "Text for note 3. Text for note 3. Text for note 3. Text for note 3.")]
    
    weak var delegate: NotesTableViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Notes"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
    }
    
    // MARK: - TableView Delegate
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        //
//    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let note = notes[indexPath.row]
        self.delegate?.notesTableViewController(self, didSelectNote: note)
        let noteVC = NoteViewController()
        noteVC.note = note
        let navigationVC = UINavigationController(rootViewController: noteVC)
        showDetailViewController(navigationVC, sender: self)
//        let navigationVC = UINavigationController(rootViewController: noteVC)

//        showDetailViewController(navigationVC, sender: self)
//        present(navigationVC, animated: true, completion: nil)
//        navigationController?.pushViewController(noteVC, animated: true)
        
        
//        present(navigationVC, animated: true, completion: nil)
//
    }
    
}
