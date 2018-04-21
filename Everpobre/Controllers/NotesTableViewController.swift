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

class NotesTableViewController: CoreDataTableViewController {
    
    // MARK: - Attributes
//    let notes = [Note]()
    lazy var notes: [Note] = {
        self.fetchedResultsController?.sections![0].objects
    }() as! [Note]
    
    weak var delegate: NotesTableViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_NOTE_ID)

        let noteFetchRequest = NSFetchRequest<Note>(entityName: "Note")
        noteFetchRequest.fetchBatchSize = FETCH_BATCH_SIZE
        noteFetchRequest.sortDescriptors = [NSSortDescriptor(key: "notebook", ascending: true),
                                                NSSortDescriptor(key: "title", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: noteFetchRequest,
                                             managedObjectContext: DataManager.shared.persistantContainer.viewContext,
                                             sectionNameKeyPath: "notebook",
                                             cacheName: nil)
        self.fetchedResultsController = frc as? NSFetchedResultsController<NSFetchRequestResult>

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(handleNewNotebook))

//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Notebooks",
//                                                           style: .plain,
//                                                           target: self, action: #selector(handleShowNotebooks))
    }
    @objc private func handleNewNotebook() {
        let note = NoteViewController()
        //        notebook.delegate = self
        
        let navController = UINavigationController(rootViewController: note)
        showDetailViewController(navController, sender: self)
        //        present(navController, animated: true, completion: nil)
    }

    
//    @objc private func handleShowNotebooks() {
//
//        let notebooksVC = NotebookTableViewController(fetchedResultsController: DataManager.shared.fetchedRCNotebook() as! NSFetchedResultsController<NSFetchRequestResult>, style: .plain)
//        let navVC = UINavigationController(rootViewController: notebooksVC)
//        let notebookVC = NotebookController()
//        
//        splitViewController?.viewControllers = [navVC, notebookVC.wrapViewInNavigation()]
//    }
    
    // MARK: - TableView Delegate
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        //
//    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = self.fetchedResultsController?.object(at: indexPath) as! Note
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NOTE_ID, for: indexPath)
        
        cell.textLabel?.text = note.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        if let sections = self.fetchedResultsController?.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
//        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let note = notes[indexPath.row]
        self.delegate?.notesTableViewController(self, didSelectNote: note)
        let noteVC = NoteViewController()
        noteVC.note = note
        showDetailViewController(noteVC.wrapViewInNavigation(), sender: self)
    }
    
}
