//
//  NotesTableViewController.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 12/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Custom Delegation
protocol NotesTableViewControllerDelegate: AnyObject {
    func notesTableViewController(_ vc: NotesTableViewController, didSelectNote note: Note)
}

class NotesTableViewController: UITableViewController {
    
    // MARK: - Attributes
    let notes = [Note]()
//        [Note(title: "Title 1", creationDate: Date(), expirationDate: Date(), noteTextView: "Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1. Text for note 1."),
//                 Note(title: "Title 2", creationDate: Date(), expirationDate: Date(), noteTextView: "Text for note 2. Text for note 2. Text for note 2. Text for note 2. Text for note 2. Text for note 2. "),
//                 Note(title: "Title 3", creationDate: Date(), expirationDate: Date(), noteTextView: "Text for note 3. Text for note 3. Text for note 3. Text for note 3.")]
    
    weak var delegate: NotesTableViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_NOTE_ID)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Notebooks",
                                                           style: .plain,
                                                           target: self, action: #selector(handleShowNotebooks))
    }
    
    @objc private func handleShowNotebooks() {

        let notebooksVC = NotebookTableViewController(fetchedResultsController: DataManager.shared.fetchedRCNotebook() as! NSFetchedResultsController<NSFetchRequestResult>, style: .plain)
        let navVC = UINavigationController(rootViewController: notebooksVC)
        let notebookVC = NotebookController()
        
        splitViewController?.viewControllers = [navVC, notebookVC.wrapViewInNavigation()]
    }
    
    // MARK: - TableView Delegate
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        //
//    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NOTE_ID, for: indexPath)

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
        showDetailViewController(noteVC.wrapViewInNavigation(), sender: self)

//        showDetailViewController(navigationVC, sender: self)
//        present(navigationVC, animated: true, completion: nil)
//        navigationController?.pushViewController(noteVC, animated: true)
        
        
//        present(navigationVC, animated: true, completion: nil)
//
    }
    
}
