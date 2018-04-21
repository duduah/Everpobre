//
//  NotebookTableViewController.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 21/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Custom Delegation
protocol NotebookTableViewControllerDelegate : AnyObject {
    func notebookTableViewController(_ vc: NotebookTableViewController, didSelectNotebook notebook: Notebook)
}


class NotebookTableViewController: CoreDataTableViewController {
    
    // MARK: - Properties
    lazy var notebooks: [Notebook] = {
        self.fetchedResultsController?.sections![0].objects
        }() as! [Notebook]

    weak var delegate: NotebookTableViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notebooks"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_NOTEBOOK_ID)
//        let notebookFetchRequest = Notebook.fetchRequest()
        let notebookFetchRequest = NSFetchRequest<Notebook>(entityName: "Notebook")
        notebookFetchRequest.fetchBatchSize = FETCH_BATCH_SIZE
        notebookFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true),
                                                NSSortDescriptor(key: "creationDate", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: notebookFetchRequest,
                                             managedObjectContext: DataManager.shared.persistantContainer.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        self.fetchedResultsController = frc as? NSFetchedResultsController<NSFetchRequestResult>

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(handleNewNotebook))
    }
    
    @objc private func handleNewNotebook() {
        let notebook = NotebookController()
//        notebook.delegate = self

        let navController = UINavigationController(rootViewController: notebook)
        showDetailViewController(navController, sender: self)
//        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - TableView delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notebook = self.fetchedResultsController?.object(at: indexPath) as! Notebook
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NOTEBOOK_ID, for: indexPath)
        
        cell.textLabel?.text = notebook.name
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notebooks.count
//    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let notebook = notebooks[indexPath.row]
        self.delegate?.notebookTableViewController(self, didSelectNotebook: notebook)
        
        let notebookVC = NotebookController()
        notebookVC.notebook = notebook
        showDetailViewController(notebookVC.wrapViewInNavigation(), sender: self)
    }
}
