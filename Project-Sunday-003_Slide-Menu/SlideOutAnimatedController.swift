//
//  SlideOutAnimatedController.swift
//  Project-Sunday-003_Slide-Menu
//
//  Created by Virata Yindeeyoungyeon on 4/30/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

let kAnimationInterval:TimeInterval = 0.4

class SlideOutAnimatedController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting:Bool
    
    init(isPresenting:Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kAnimationInterval
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.isPresenting {
            animatePresenting(transitionContext: transitionContext)
        } else {
            animateDismissing(transitionContext: transitionContext)
        }
    }
    
    //MARK: presenting
    private func animatePresenting(transitionContext:UIViewControllerContextTransitioning) {
        guard self.isPresenting,
            let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        
        let containerView = transitionContext.containerView
        let toView = (toViewController.view)!
        let fromView = (fromViewController.view)!

        containerView.insertSubview(toView, belowSubview: fromView)
        
        let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: false)!
        snapshot.isUserInteractionEnabled = false
        snapshot.tag = 1234
        containerView.insertSubview(snapshot, aboveSubview: toView)
        fromView.isHidden = true
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            var frame = containerView.bounds
            frame.origin.x = containerView.bounds.width*0.8
            snapshot.frame = frame
        }) { (finished) in
            fromView.isHidden = false
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
        }
    }
    
    //MARK: dismissing
    private func animateDismissing(transitionContext:UIViewControllerContextTransitioning) {
        guard !self.isPresenting, let snapshot = transitionContext.containerView.viewWithTag(1234) else {return}
        
        UIView.animate(withDuration: kAnimationInterval, animations: {
            snapshot.frame = transitionContext.containerView.frame
        }) { (finished) in
            let cancelled = transitionContext.transitionWasCancelled
            if !cancelled {
                snapshot.removeFromSuperview()
            }
            transitionContext.completeTransition(!cancelled)
        }
    }
}
