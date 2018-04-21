//
//  CoreDataManager.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 20/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    // MARK: - CoreData Singleton
    static let shared = DataManager()
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EverpobreModels")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let err = error {
                fatalError("Loadin of store failed: \(err)")
            }
        })
        return container
    }()
}

extension DataManager {
    
    func fetchNotebooks() -> [Notebook] {
        
        let context = DataManager.shared.persistantContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Notebook>(entityName: "Notebook")
        
        do{
            let notebooks = try context.fetch(fetchRequest)
            
            return notebooks
        } catch let fetchErr {
            print("Failed to fetch Notebooks:" , fetchErr)
            return []
        }
    }

    func fetchNotes() -> [Note] {
        
        let context = DataManager.shared.persistantContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        
        do{
            let note = try context.fetch(fetchRequest)
            
            return note
        } catch let fetchErr {
            print("Failed to fetch Notes:" , fetchErr)
            return []
        }
    }
    
    func fetchedRCNotebook() -> NSFetchedResultsController<Notebook> {
        let notebookFetchRequest = NSFetchRequest<Notebook>(entityName: "Notebook")
        notebookFetchRequest.fetchBatchSize = FETCH_BATCH_SIZE
        notebookFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true),
                                                NSSortDescriptor(key: "creationDate", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: notebookFetchRequest,
                                             managedObjectContext: DataManager.shared.persistantContainer.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }
}
