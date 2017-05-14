//
//  SlideOutMenuManager.swift
//  Project-Sunday-003_Slide-Menu
//
//  Created by Virata Yindeeyoungyeon on 5/13/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

class SlideOutMenuManager: NSObject,UIViewControllerTransitioningDelegate {
    static let sharedInstance = SlideOutMenuManager()
    var isInteract:Bool?
    var percentDrivenInteractive:UIPercentDrivenInteractiveTransition?
    
    private override init() {
        super.init()
        isInteract = false
        percentDrivenInteractive = nil
    }
    
    func handleGesture(progress:CGFloat,gestureState:UIGestureRecognizerState,gestureAction:()->()) {
        switch gestureState {
        case .began:
            isInteract = true
            percentDrivenInteractive = UIPercentDrivenInteractiveTransition()
            gestureAction()
        case .changed:
            percentDrivenInteractive?.update(progress)
        case .ended:
            if progress > 0.5 {
                percentDrivenInteractive?.finish()
            } else {
                percentDrivenInteractive?.cancel()
            }
            isInteract = false
        case .cancelled:
            percentDrivenInteractive?.cancel()
            isInteract = false
        default:
            break
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOutAnimatedController(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOutAnimatedController(isPresenting: false)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (isInteract)! ? percentDrivenInteractive : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (isInteract)! ? percentDrivenInteractive : nil
    }
}
