//
//  ViewController.swift
//  Project-Sunday-003_Slide-Menu
//
//  Created by Virata Yindeeyoungyeon on 4/30/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupGestureRecognizer()
        setupInfo()
    }
    
    // MARK: NavBar
    private func setupNavBar() {
        self.title = "MainViewController"
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.setImage(UIImage.init(named: "menu"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(openDrawerTap(sender:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    // MARK: Action
    func openDrawerTap(sender:AnyObject) {
        openDrawer()
    }
    
    func openDrawer() {
        performSegue(withIdentifier: "openDrawer", sender: nil)
    }
    
    // MARK: Gesture regonizer
    private func setupGestureRecognizer() {
        let leftEdgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        leftEdgePanGesture.edges = UIRectEdge.left
        view.addGestureRecognizer(leftEdgePanGesture)
    }
    
    func pan(gesture:UIPanGestureRecognizer) {
        let point = gesture.translation(in: self.view)
        let percent = fabs(point.x/(gesture.view?.bounds.width)!)
        SlideOutMenuManager.sharedInstance.handleGesture(progress: percent, gestureState: gesture.state, gestureAction: openDrawer)
    }
    
    // MARK: Info
    private func setupInfo() {
        //FolderImageView
        let folderImageView = UIImageView(image: UIImage.init(named: "folder"))
        folderImageView.contentMode = .scaleAspectFit
        view.addSubview(folderImageView)
        //FolderImageView - constraints
        folderImageView.translatesAutoresizingMaskIntoConstraints = false
        folderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        folderImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: folderImageView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 1.0))
        
        //InfoLabel
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.text = "← Slide from left edge OR tap the left bar button to open the menu drawer.\n\n→ Slide from right edge OR tap on the right side to dismiss the menu drawer"
        view.addSubview(infoLabel)
        //InfoLabel - constraints
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: folderImageView.bottomAnchor).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.heightAnchor.constraint(equalTo: folderImageView.heightAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.8, constant: 1.0))
    }
}

