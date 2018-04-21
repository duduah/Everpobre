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
            let splitVC = window?.rootViewController as! UISplitViewController
            let notebooksVC = NotebookTableViewController(fetchedResultsController: DataManager.shared.fetchedRCNotebook() as! NSFetchedResultsController<NSFetchRequestResult>, style: .plain)
            let navVC = UINavigationController(rootViewController: notebooksVC)
            let notebookVC = NotebookController()

            splitVC.viewControllers = [navVC, notebookVC.wrapViewInNavigation()]
//            guard let splitViewController = window?.rootViewController as? UISplitViewController,
//                let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
//                let masterViewController = leftNavController.topViewController as? NotebookTableViewController,
//                let detailViewController = splitViewController.viewControllers.last as? NotebookController
//                else {
//                    fatalError()
//            }

            notebooksVC.delegate = notebookVC

        } else {
            guard let splitViewController = window?.rootViewController as? UISplitViewController,
                let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
                let masterViewController = leftNavController.topViewController as? NotesTableViewController,
                let detailViewController = splitViewController.viewControllers.last as? NoteViewController
                else {
                    fatalError()
            }

            masterViewController.delegate = detailViewController
        }

        return true
    }
}

