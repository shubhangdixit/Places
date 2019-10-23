//
//  ViewController.swift
//  Places
//
//  Created by Shubhang Dixit on 21/10/19.
//  Copyright © 2019 Shubhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBarView: UIView!
    
    let controllerNames : [String] = ["MapViewController", "ListViewController", "AddListViewController"]
    let buttonTitles = ["List", "Map", "Add new place"]
    
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    var previousIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = getTabBarControllers(forIdentifiers: controllerNames)
        configureTabBar()
    }
    
    func configureTabBar() {
        
        tabBarView.layer.cornerRadius = 5
        tabBarView.layer.shadowColor = UIColor.black.cgColor
        tabBarView.layer.shadowOpacity = 0.4
        tabBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarView.layer.shadowRadius = 5
        
        for (index, button) in buttons.enumerated() {
            addLabel(toButton: button, text: buttonTitles[index])
            button.tintColor = .lightGray
            button.isHighlighted = false
        }
        didPressTab(buttons[selectedIndex])
    }
    
    @IBAction func didPressTab(_ sender: Any) {
        
        previousIndex = selectedIndex
        selectedIndex = (sender as! UIButton).tag
        setTabSelected(buttons[previousIndex], isSelected: false)
        setTabSelected(buttons[selectedIndex], isSelected: true)
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func setTabSelected(_ button : UIButton , isSelected : Bool) {
        button.isSelected = isSelected
        button.tintColor = isSelected ? UIColor.systemBlue : UIColor.lightGray
    }
    
    
    
}

extension ViewController {
    func getTabBarControllers(forIdentifiers identifiers : [String]) -> [UIViewController] {
        var list : [UIViewController] = []
        for identifier in identifiers {
            list.append(Utility.controller(forIdentifier: identifier))
        }
        return list
    }
    
    func addLabel(toButton button: UIButton, text : String) {
        
        let label = TabButtonLabel()
        label.textAlignment = .center
        label.text = text
        label.font = Utility.Fonts.avenirNextCondensedBold(withSize: 12)
        label.sizeToFit()
        let width = label.intrinsicContentSize.width
        let height = label.intrinsicContentSize.height
        let frame = CGRect(x: (button.frame.width - width)/2, y: button.frame.height + 2, width: width, height: height)
        label.frame = frame
        label.tintColor = nil
        button.addSubview(label)
    }
}

class TabButtonLabel : UILabel {
    override func tintColorDidChange() {
        self.textColor = self.tintColor
    }
}
