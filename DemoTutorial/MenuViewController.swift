//
//  MenuViewController.swift
//  DemoTutorial
//
//  Created by can.khac.nguyen on 10/8/18.
//  Copyright © 2018 can.khac.nguyen. All rights reserved.
//

import UIKit

protocol MenuContentSizeUpdateDelegate: class {
    func menuContentSizeDidChange(height: CGFloat)
}
class MenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    weak var delegate: MenuContentSizeUpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuTableView.layoutIfNeeded()
        delegate?.menuContentSizeDidChange(height: menuTableView.contentSize.height)
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.menuItemLabel.text = "Item \(indexPath.row)"
        return cell
    }
}
