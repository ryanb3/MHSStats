//
//  ViewController.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var screenWidth = Double(UIScreen.mainScreen().bounds.width) //Final
    var screenHeight = Double(UIScreen.mainScreen().bounds.height) //Final
    var ways : WaysToGoBack?
    var loading: LoadingScreen?
    
    var screen: ScreenDisplay?

    override func viewDidLoad() {
        super.viewDidLoad()
        loading = LoadingScreen(width: screenWidth, height: screenHeight)
        self.initStage1()

    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func initStage1() {
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        screen = ScreenDisplay(x: 0, y: screenHeight / 2 - FileStructure.topBarHeight / 2, width: screenWidth, height : screenHeight, mDraw: false, viewController: self)
        let redScreen = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        redScreen.backgroundColor = FileStructure.MHSColor
        self.view.addSubview(screen!)
        self.view.addSubview(redScreen)
        screen!.loadAndProcessRecords()
        UIView.animateWithDuration(1 * FileStructure.introScale, animations: {
            redScreen.frame = CGRectMake(0, CGFloat(self.screenHeight + 10), CGFloat(self.screenWidth), CGFloat(self.screenHeight))
            }, completion: {
                (value: Bool) in
                self.initStage2(self.screen!)
        })
    }
    
    func initStage2(screen: ScreenDisplay) {
        let xVertPosition = screen.frame.origin.x
        let yVertPosition = screen.frame.origin.y - CGFloat(screenHeight / 2 - FileStructure.topBarHeight / 2)
        
        let vertHeight = screen.frame.size.height
        let vertWidth = screen.frame.size.width
        
        UIView.animateWithDuration(1 * FileStructure.introScale, animations: {
            screen.frame = CGRectMake(xVertPosition, yVertPosition, vertWidth, vertHeight)
            }, completion: {
                (value: Bool) in
                self.view.addSubview(self.loading!)
                self.loading!.fadeIn(2.0)
                screen.displayRecords(0, y: 0, width: self.screenWidth, height: self.screenHeight)
                self.ways = WaysToGoBack(screen: screen)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetch(completion: () -> Void) {
        
    }

}

