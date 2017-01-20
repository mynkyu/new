//
//  PagingView.swift
//  TestSwift
//
//  Created by Stefan Lage on 09/01/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import FirebaseAuth

public enum SLNavigationSideItemsStyle: Int {
    case slNavigationSideItemsStyleOnBounds = 40
    case slNavigationSideItemsStyleClose = 30
    case slNavigationSideItemsStyleNormal = 20
    case slNavigationSideItemsStyleFar = 10
    case slNavigationSideItemsStyleDefault = 0
    case slNavigationSideItemsStyleCloseToEachOne = -40
}

public typealias SLPagingViewMoving = ((_ subviews: [UIView])-> ())
public typealias SLPagingViewMovingRedefine = ((_ scrollView: UIScrollView, _ subviews: NSArray)-> ())
public typealias SLPagingViewDidChanged = ((_ currentPage: Int)-> ())

open class SLPagingViewSwift: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    var control : BetterSegmentedControl = BetterSegmentedControl()
    
    // MARK: - Public properties
    var views = [Int : UIView]()
    open var currentPageControlColor: UIColor?
    open var tintPageControlColor: UIColor?
    open var pagingViewMoving: SLPagingViewMoving?
    open var pagingViewMovingRedefine: SLPagingViewMovingRedefine?
    open var didChangedPage: SLPagingViewDidChanged?
    open var navigationSideItemsStyle: SLNavigationSideItemsStyle = .slNavigationSideItemsStyleClose
    var scrollViewControl = scrollViewController()
    var chatnav : chattingNav!
    
    
    // MARK: - Private properties
    fileprivate var SCREENSIZE: CGSize {
        return UIScreen.main.bounds.size
    }
    var scrollView: UIScrollView!
    fileprivate var pageControl: UIPageControl!
    fileprivate var navigationBarView: UIView   = UIView()
    fileprivate var navItems: [UIView]          = []
    fileprivate var needToShowPageControl: Bool = false
    fileprivate var isUserInteraction: Bool     = false
    fileprivate var indexSelected: Int          = 0
    
    // MARK: - Constructors
    public required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Here you can init your properties
    }
    
    // MARK: - Constructors with items & views
    public convenience init(items: [UIView], views: [UIView]) {
        self.init(items: items, views: views, showPageControl:false, navBarBackground:UIColor.white)
    }
    
    public convenience init(items: [UIView], views: [UIView], showPageControl: Bool){
        self.init(items: items, views: views, showPageControl:showPageControl, navBarBackground:UIColor.white)
    }
    
    /*
    *  SLPagingViewController's constructor
    *
    *  @param items should contain all subviews of the navigation bar
    *  @param navBarBackground navigation bar's background color
    *  @param views all subviews corresponding to each page
    *  @param showPageControl inform if we need to display the page control in the navigation bar
    *
    *  @return Instance of SLPagingViewController
    */
    public init(items: [UIView], views: [UIView], showPageControl: Bool, navBarBackground: UIColor) {
        super.init(nibName: nil, bundle: nil)
        needToShowPageControl             = showPageControl
        navigationBarView.backgroundColor = UIColor.clear
        isUserInteraction                 = true
        for (i, v) in items.enumerated() {
            let vSize: CGSize = (v as? UILabel)?._slpGetSize() ?? v.frame.size
            let originX       = (self.SCREENSIZE.width/2.0 - vSize.width/2.0) + CGFloat(i * 100)
            //let yPosition = self.view.frame.height / 2
            v.frame           = CGRect.init(x: originX, y: 21, width: vSize.width * 1.2 , height: vSize.height * 1.2)
            v.tag             = i
            //let tap           = UITapGestureRecognizer(target: self, action: #selector(SLPagingViewSwift.tapOnHeader(_:)))
            //v.addGestureRecognizer(tap)
            //print(" frame:  " ,navigationBarView.frame.height)
            v.isUserInteractionEnabled = true
            self.navigationBarView.addSubview(v)
            self.navItems.append(v)
        }
        
        for (i, view) in views.enumerated(){
            view.tag = i
            self.views[i] = view
        }
    }
    
    // MARK: - Constructors with controllers
    public convenience init(controllers: [UIViewController]){
        self.init(controllers: controllers, showPageControl: true, navBarBackground: UIColor.white)
    }
    
    public convenience init(controllers: [UIViewController], showPageControl: Bool){
        self.init(controllers: controllers, showPageControl: true, navBarBackground: UIColor.white)
    }
    
    /*
    *  SLPagingViewController's constructor
    *
    *  Use controller's title as a navigation item
    *
    *  @param controllers view controllers containing sall subviews corresponding to each page
    *  @param navBarBackground navigation bar's background color
    *  @param showPageControl inform if we need to display the page control in the navigation bar
    *
    *  @return Instance of SLPagingViewController
    */
    public convenience init(controllers: [UIViewController], showPageControl: Bool, navBarBackground: UIColor){
        var views = [UIView]()
        var items = [UILabel]()
        for ctr in controllers {
            let item  = UILabel()
            item.text = ctr.title
            views.append(ctr.view)
            items.append(item)
        }
        self.init(items: items, views: views, showPageControl:showPageControl, navBarBackground:navBarBackground)
    }
    
    // MARK: - Constructors with items & controllers
    public convenience init(items: [UIView], controllers: [UIViewController]){
        self.init(items: items, controllers: controllers, showPageControl: true, navBarBackground: UIColor.white)
    }
    public convenience init(items: [UIView], controllers: [UIViewController], showPageControl: Bool){
        
        
        
        self.init(items: items, controllers: controllers, showPageControl: showPageControl, navBarBackground: UIColor.clear)
        self.chatnav = controllers[2] as! chattingNav
        chatnav.slPaging = self
        print("체크1")
                
        self.addChildViewController(controllers[1])
        controllers[1].didMove(toParentViewController: self)
        self.addChildViewController(controllers[0])
        controllers[0].didMove(toParentViewController: self)
        self.scrollViewControl = controllers[0] as! scrollViewController
        self.addChildViewController(controllers[2])
        controllers[2].didMove(toParentViewController: self)
        
        
        
    }
  
    /*
    *  SLPagingViewController's constructor
    *
    *  @param items should contain all subviews of the navigation bar
    *  @param navBarBackground navigation bar's background color
    *  @param controllers view controllers containing sall subviews corresponding to each page
    *  @param showPageControl inform if we need to display the page control in the navigation bar
    *
    *  @return Instance of SLPagingViewController
    */
    public convenience init(items: [UIView], controllers: [UIViewController], showPageControl: Bool, navBarBackground: UIColor){
        var views = [UIView]()
        for ctr in controllers {
            views.append(ctr.view)
        }
        self.init(items: items, views: views, showPageControl:showPageControl, navBarBackground:navBarBackground)
    }
    
    // MARK: - Life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(handleLogout), with: nil, afterDelay: 0)

        /*
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }*/
        
        // Do any additional setup after loading the view, typically from a nib.
        self.setupPagingProcess()
        self.setCurrentIndex(self.indexSelected, animated: false)
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width, y: 0), animated: false)
        setControl()
    }
    
    func handleLogout() {
        print("logging out process")
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = loginViewController()
        present(loginController, animated: true, completion: nil)
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationBarView.frame = CGRect(x: 0, y: 0 , width: self.SCREENSIZE.width, height: 100)
        
        
        
        
        
        //let rightSwipe = UISwipeGestureRecognizerDirection.right
        
    }
    
    // MARK: - Public methods
    
    /*
    *  Update the state of the UserInteraction on the navigation bar
    *
    *  @param activate state you want to set to UserInteraction
    */
    open func updateUserInteractionOnNavigation(_ active: Bool){
        self.isUserInteraction = active
    }
    
    /*
    *  Set the current index page and scroll to its position
    *
    *  @param index of the wanted page
    *  @param animated animate the moving
    */
    open func setCurrentIndex(_ index: Int, animated: Bool){
        // Be sure we got an existing index
        if(index < 0 || index > self.navigationBarView.subviews.count-1){
            let exc = NSException(name: NSExceptionName(rawValue: "Index out of range"), reason: "The index is out of range of subviews's countsd!", userInfo: nil)
            exc.raise()
        }
        self.indexSelected = index
        // Get the right position and update it
        let xOffset = CGFloat(index) * self.SCREENSIZE.width
        self.scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: animated)
    }
    
    // MARK: - Internal methods
    fileprivate func setupPagingProcess() {
        let frame: CGRect                              = CGRect(x: 0, y: 0, width: SCREENSIZE.width, height: self.view.frame.height)
        
        self.scrollView                                = UIScrollView(frame: frame)
        self.scrollView.backgroundColor                = UIColor.clear
        self.scrollView.isPagingEnabled                = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator   = false
        self.scrollView.delegate                       = self
        self.scrollView.bounces                        = true
        //self.scrollView.contentInset                   = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.view.addSubview(self.scrollView)
        
        // Adds all views
        self.addViews()
        
        if(self.needToShowPageControl){
            // Make the page control
            self.pageControl               = UIPageControl(frame: CGRect(x: 0, y: 35, width: 0, height: 0))
            self.pageControl.numberOfPages = self.navigationBarView.subviews.count
            self.pageControl.currentPage   = 0
            if self.currentPageControlColor != nil {
                self.pageControl.currentPageIndicatorTintColor = self.currentPageControlColor
            }
            if self.tintPageControlColor != nil {
                self.pageControl.pageIndicatorTintColor = self.tintPageControlColor
            }
            self.navigationBarView.addSubview(self.pageControl)
        }
        //self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        //self.navigationController?.navigationBar.addSubview(self.navigationBarView)
        self.scrollView.addSubview(self.navigationBarView) /////
        
        let backView = UIView()
        backView.frame = CGRect.init(x: 0, y: 0, width: self.scrollView.frame.width/6, height: self.scrollView.frame.height/10)
        backView.backgroundColor = UIColor.clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(firstTapAction))
        backView.addGestureRecognizer(tapGesture)
        self.view.addSubview(backView)
        
        
        let nextView = UIView()
        nextView.frame = CGRect.init(x: self.scrollView.frame.width * (5/6) , y: 0, width: self.scrollView.frame.width/6, height: scrollView.frame.height/10)
        let nextTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondTapAction))
        nextView.addGestureRecognizer(nextTapGesture)
        nextView.backgroundColor = UIColor.clear
        self.view.addSubview(nextView)

        
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationBarView.backgroundColor = UIColor.clear
        
        
    }
    
    // Loads all views
    fileprivate func addViews() {
        print("체크2")
        if self.views.count > 0 {
            let width                   = SCREENSIZE.width * CGFloat(self.views.count)
            let height                  = self.view.frame.height
            self.scrollView.contentSize = CGSize(width: width, height: height)
            var i: Int                  = 0
            while let v = views[i] {
                v.frame          = CGRect(x: self.SCREENSIZE.width * CGFloat(i), y: 0, width: self.SCREENSIZE.width, height: self.SCREENSIZE.height)
                self.scrollView.addSubview(v)
                i += 1
            }
        }
    }
    
    fileprivate func sendNewIndex(_ scrollView: UIScrollView){
        let xOffset      = Float(scrollView.contentOffset.x)
        let currentIndex = (Int(roundf(xOffset)) % (self.navigationBarView.subviews.count * Int(self.SCREENSIZE.width))) / Int(self.SCREENSIZE.width)
        if self.needToShowPageControl && self.pageControl.currentPage != currentIndex {
            self.pageControl.currentPage = currentIndex
            self.didChangedPage?(currentIndex)
        }
    }
    
    func getOriginX(_ vSize: CGSize, idx: CGFloat, distance: CGFloat, xOffset: CGFloat) -> CGFloat{
        var result = self.view.frame.width / 2.0 - vSize.width/2.0
        result += (idx * distance)
        result -= xOffset / (self.view.frame.width / distance)
        return result
    }
    
    // Scroll to the view tapped
    /*
    func tapOnHeader(_ recognizer: UITapGestureRecognizer){
        if let key = recognizer.view?.tag, let view = self.views[key] , self.isUserInteraction {
            print("tapped")
            self.scrollView.scrollRectToVisible(view.frame, animated: true)
        }
    }*/
    
    // MARK: - UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x,",",scrollView.contentOffset.y)
        scrollView.contentOffset.y = 0
        //print(self.view.frame.height)
        let xOffset = scrollView.contentOffset.x * (-1.45)
        let distance = CGFloat(100 + self.navigationSideItemsStyle.rawValue) * (self.view.frame.width / 320)
        for (i, v) in (self.navItems).enumerated() {
            //print(v.tag)
            let vSize    = v.frame.size
            let originX  = self.getOriginX(vSize, idx: CGFloat(i), distance: CGFloat(distance), xOffset: xOffset)
            //let yPosition = self.view.frame.height / 2
            v.frame      = CGRect.init(x: originX, y: 21 , width: vSize.width  , height: vSize.height)
            //print(i, "번째 originX : ", originX)
            
            
        }
        self.pagingViewMovingRedefine?(scrollView, self.navItems as NSArray)
        self.pagingViewMoving?(self.navItems)
        if(self.scrollView.contentOffset.x < self.scrollView.frame.width / 4){
            UIView.animate(withDuration: 0.5, animations: {
                self.control.alpha = 1.0
                self.navItems[0].alpha = 0.0
            })
            
        }
        else{
            UIView.animate(withDuration: 0.2, animations: {
                self.control.alpha = 0.0
                
            })
        }
        if(self.scrollView.contentOffset.x < self.scrollView.frame.width * 0.9 ){
            UIView.animate(withDuration: 0.2, animations: {
                self.navItems[0].alpha = 0.0
            })
        }
        else{
            UIView.animate(withDuration: 0.2, animations: {
                self.navItems[0].alpha = 1.0
            })
        }
        
        ///////////////////////////////////////////////////////////////////
        if(chatnav.viewControllers.count > 1){
            scrollView.contentOffset.x = self.scrollView.frame.width * 2
            self.scrollView.isScrollEnabled = false
        }
        else{
            self.scrollView.isScrollEnabled = true
        }
        ///////////////////////////////////////////////////////////////////
       
        
    }
    func firstTapAction(){
        print("1 gesture recognized")
        if(scrollView.contentOffset.x > self.scrollView.frame.width / 2){
            scrollView.setContentOffset(CGPoint.init(x: self.scrollView.contentOffset.x-self.scrollView.frame.width, y: 0), animated: true)
        }
        
        //present( cardStoryViewController() , animated: true, completion: nil)
        
    }
    func secondTapAction(){
        print("2 gesture recognized")
        if(scrollView.contentOffset.x < self.scrollView.frame.width * (1.5) ){
            scrollView.setContentOffset(CGPoint.init(x: self.scrollView.contentOffset.x+self.scrollView.frame.width, y: 0), animated: true)
            scrollView.isScrollEnabled = true
        }
        
        //present( cardStoryViewController() , animated: true, completion: nil)
        
    }
    func setControl(){
        control = BetterSegmentedControl(
            frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width * (1/3) , y: 20, width: view.bounds.width * (4/6), height: 34.0),
            titles: ["User", "Setting"],
            index: 0,
            backgroundColor: UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0),
            titleColor: .white,
            indicatorViewBackgroundColor: UIColor(red: 255/255, green: 69.0/255, blue: 50/255, alpha: 1.0),
            selectedTitleColor: .black)
        control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)!
        control.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
        control.layer.cornerRadius = 15
        control.cornerRadius = 15
        control.alpha = 0.0
        control.addTarget(self, action: #selector(self.controlValueChanged(_:)), for: .valueChanged)
        //control.alpha = 0.0
        view.addSubview(control)
        
    }
    func controlValueChanged(_ sender : BetterSegmentedControl ){
        if(sender.index == 0){
            self.scrollViewControl.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            self.scrollView.isScrollEnabled = true
            print("0")
        }
        else{
            self.scrollViewControl.scrollView.setContentOffset(CGPoint.init(x: self.scrollViewControl.scrollView.frame.width, y: 0), animated: true)
            self.scrollView.isScrollEnabled = false
            print("1")
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.sendNewIndex(scrollView)
    }
    
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.sendNewIndex(scrollView)
    }
    
   }

extension UILabel {
    func _slpGetSize() -> CGSize? {
        return (text as NSString?)?.size(attributes: [NSFontAttributeName: font])
    }
}