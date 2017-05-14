//
//  DrawerViewController.swift
//  Project-Sunday-003_Slide-Menu
//
//  Created by Virata Yindeeyoungyeon on 4/30/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTransitioningDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTransitioningDelegate()
    }
    
    private func setupTransitioningDelegate() {
        self.transitioningDelegate = SlideOutMenuManager.sharedInstance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configGesture()
    }

    //MARK: Gesture
    private func configGesture() {
        let rightEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action:#selector(pan(gesture:)))
        rightEdgeGesture.edges = .right
        self.view.addGestureRecognizer(rightEdgeGesture)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        closeDrawer()
    }
    
    func closeDrawer() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func pan(gesture:UIPanGestureRecognizer) {
        let percent = fabs(gesture.translation(in: self.view).x / self.view.bounds.width)
        SlideOutMenuManager.sharedInstance.handleGesture(progress: percent, gestureState: gesture.state, gestureAction: closeDrawer)
    }
}
