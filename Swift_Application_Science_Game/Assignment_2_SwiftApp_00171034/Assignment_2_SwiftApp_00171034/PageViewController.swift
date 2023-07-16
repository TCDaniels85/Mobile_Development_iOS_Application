//
//  PageViewController.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/21/23.
//

import UIKit

class InstructionsPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource  {
    
    
    
    var pageControl = UIPageControl() //Enables page control indicator to be displayed
    //Instantiates an array with references to view controllers
    lazy var viewControllerOrder: [UIViewController] = {
        return [self.newViewController(viewController: "InstructionsA"),
                self.newViewController(viewController: "InstructionsB"),
                self.newViewController(viewController: "InstructionsC"),
                ]
    }()
    
    func newViewController(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configurePageControl()
        
        
        delegate = self
        dataSource = self
        if let firstViewController = viewControllerOrder.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    /*
     *Part of the delegate method for UIPageViewController, called when the user swipes left to display the previous view controller. Uses viewControllerOrder to
     * Determine the order of the controllers to be displayed.
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerOrder.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return viewControllerOrder.last
        }
        
        guard viewControllerOrder.count > previousIndex else {
            return nil
        }
        
        return viewControllerOrder[previousIndex]
        
    }
    
    /*
     *Part of the delegate method for UIPageViewController, called when the user swipes right to display the previous view controller
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerOrder.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let viewCount = viewControllerOrder.count
        guard viewCount != nextIndex else {
            return viewControllerOrder.first
        }
        
        guard viewCount > nextIndex else {
            return nil
        }
        return viewControllerOrder[nextIndex]
    }
    
    
    /*
     Adds dots to the bottom of the page to indicate which page the user is viewing
     */
    func configurePageControl() {
           
            pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
            self.pageControl.numberOfPages = viewControllerOrder.count
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.black
            self.pageControl.pageIndicatorTintColor = UIColor.white
            self.pageControl.currentPageIndicatorTintColor = UIColor.black
            self.view.addSubview(pageControl)
        }
    
    /*
     Ensures that the page indicator changes to the correct page as user scrolls between them
     */
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            let pageContentViewController = pageViewController.viewControllers![0]
            self.pageControl.currentPage = viewControllerOrder.firstIndex(of: pageContentViewController)!
        }
}

