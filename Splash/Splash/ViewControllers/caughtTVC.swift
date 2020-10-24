//
//  caughtTVC.swift
//  Splash
//
//  Created by Ben Lapidus on 11/24/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//

import UIKit

class caughtTVC: UITableViewController, UISplitViewControllerDelegate {
    var collapseDetailViewController: Bool = true
    
    var detailViewController: infoVC? = nil
    
    @IBAction func homeButton(_ sender: Any) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "home"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 150;
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        CoreDataStack.shared.update()
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    // MARK: - Table view data source
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? fishCell else {
            fatalError("Expected fishcell")
        }
        let item = CoreDataStack.shared.items[indexPath.row]
        
        var temp:Date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let myString = formatter.string(from: item.value(forKeyPath: "dateCaught") as? Date ?? Date())
        temp = formatter.date(from: myString)!
        formatter.dateFormat = "MM/dd/yyyy"
        let myStringafd = formatter.string(from: temp)
        
        cell.fishName?.text = item.value(forKeyPath: "name") as? String
        cell.fishDate?.text = myStringafd
        cell.fishImageView.image = UIImage(named: "fishLeft")
        
        // TODO: Add image connection for profile image
        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = CoreDataStack.shared.items[indexPath.row] as? Fish {
                //TODO: Convert reference from name to UUID
                deletionAlert(name: item.name!) { _ in
                    CoreDataStack.shared.deleteItem(name: item)
                    DispatchQueue.main.async { self.tableView.reloadData() }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataStack.shared.items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.collapseDetailViewController = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secview" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let vc = (segue.destination as! UINavigationController).topViewController as! infoVC
                vc.delegate = self
                vc.fish = CoreDataStack.shared.items[indexPath.row] as! Fish

                let backItem = UIBarButtonItem()
                backItem.title = NSLocalizedString("back", comment: "")
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
    func deletionAlert(name: String, completion: @escaping (UIAlertAction) -> Void) {
        
        let alertMsg = NSLocalizedString("deleteError", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("warning", comment: ""), message: alertMsg, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
}

extension caughtTVC: DetailViewDelegate {
    func updateItems() {
        tableView.reloadData()
    }
}

