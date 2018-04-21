//
//  AppDelegate.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 12/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let notebooks = DataManager.shared.fetchNotebooks()
        if (notebooks.count == 0) {
            let context = DataManager.shared.persistantContainer.viewContext
            let notebook = Notebook(name: "My First Notebool", inContext: context)
            let _ = Note(title: "My First Note", noteText: "Hello, Everpobre!", notebook: notebook, Context: context)
            
            do {
                try context.save()
            } catch let saveErr {
                print("Error saving the first notebook and note:", saveErr)
            }
        }

        guard let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
            let masterViewController = leftNavController.topViewController as? NotesTableViewController,
            let detailViewController = splitViewController.viewControllers.last as? NoteViewController
            else {
                fatalError()
        }
        
        masterViewController.delegate = detailViewController


        return true
    }
}

