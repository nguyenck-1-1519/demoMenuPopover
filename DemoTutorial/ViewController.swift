//
//  ViewController.swift
//  DemoTutorial
//
//  Created by can.khac.nguyen on 10/8/18.
//  Copyright © 2018 can.khac.nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    var rect = CGRect.zero
    var controller: MenuViewController!
    var controllerAsPopUp: MenuViewController!
    var menuItemButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    func configView() {
        menuItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menuDidTap(_:)))
        self.navigationItem.leftBarButtonItem = menuItemButton
        // MARK: add as popover
        controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        controller.delegate = self
        controller.preferredContentSize = CGSize(width: 300, height: 200)

        // MARK: add as pop viewcontroller
//        controllerAsPopUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
//        controllerAsPopUp.delegate = self
//        controllerAsPopUp.providesPresentationContextTransitionStyle = true
//        controllerAsPopUp.definesPresentationContext = true
//        controllerAsPopUp.modalPresentationStyle = .overCurrentContext
//        controllerAsPopUp.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.6)
    }
    
    @objc func menuDidTap(_ sender: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.barButtonItem = menuItemButton
        presentationController.popoverBackgroundViewClass = MenuAppearance.self
        self.present(controller, animated: true)
//        self.present(controllerAsPopUp, animated: true, completion: nil)
    }
    
    @IBAction func menuButtonClicked(_ sender: UIButton) {
        self.present(controller, animated: true)
    }
    
}

extension ViewController: MenuContentSizeUpdateDelegate {
    func menuContentSizeDidChange(height: CGFloat) {
        controller.preferredContentSize = CGSize(width: 300, height: height)
    }
}
