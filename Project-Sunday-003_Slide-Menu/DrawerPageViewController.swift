//
//  DrawerPageViewController.swift
//  Project-Sunday-003_Slide-Menu
//
//  Created by Virata Yindeeyoungyeon on 5/13/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

//MARK: DrawerPageViewController
class DrawerPageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        self.dataSource = self
        self.delegate = self
        
        let page1 = ExampleViewController(title: "Page 1")
        page1.view.backgroundColor = UIColor.yellow
        pages.append(page1)
        
        let page2 = ExampleViewController(title: "Page 2")
        page2.view.backgroundColor = UIColor.cyan
        pages.append(page2)
        
        let page3 = ExampleViewController(title: "Page 3")
        page3.view.backgroundColor = UIColor.green
        pages.append(page3)
        
        self.setViewControllers([page1], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currIndex = pages.index(of: viewController)!
        return (currIndex == 0) ? nil : pages[currIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currIndex = pages.index(of: viewController)!
        return (currIndex == pages.count-1) ? nil : pages[currIndex+1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

//MARK: ExampleViewController
class ExampleViewController : UIViewController {
    var pageTitle:String = "Title"
    
    init(title:String) {
        pageTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        let label = UILabel()
        label.text = pageTitle
        label.textAlignment = .center
        label.font = UIFont(name: "futura", size: 50)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.backgroundColor = UIColor.clear
        view.addSubview(label)
        
        //constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.2, constant: 1.0))
    }
}
