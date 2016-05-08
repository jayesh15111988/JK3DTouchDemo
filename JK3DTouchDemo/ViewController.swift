//
//  ViewController.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/7/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var touchOperationsOptions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.title = "3D Touch Demo"
        touchOperationsOptions = ["3D Touch Preview Demo", "3D Touch force visualizer"]
        self.tableView.reloadData()
    }

    // MARK: - UITableView datasource and delegate methods.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touchOperationsOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("touchOptions", forIndexPath: indexPath)
        cell.textLabel?.text = touchOperationsOptions[indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0) {
            let touchDemoViewController = JK3DTouchPreviewViewController()
            self.navigationController?.pushViewController(touchDemoViewController, animated: true)
        } else if (indexPath.row == 1) {
            let touchesDemoViewController = JK3DTouchForceViewerViewController()
            self.navigationController?.pushViewController(touchesDemoViewController, animated: true)
        }
    }


}

