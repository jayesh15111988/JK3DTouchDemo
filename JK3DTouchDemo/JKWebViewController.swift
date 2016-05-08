//
//  JKWebViewController.swift
//  JK3DTouchDemo
//
//  Created by Jayesh Kawli Backup on 5/8/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class JKWebViewController: UIViewController {

    var url: NSURL
    
    init(url: NSURL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(dismiss))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let topLayout = self.topLayoutGuide
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.loadRequest(NSURLRequest(URL: self.url))
        self.view.addSubview(webView)
        let views: [String: AnyObject] = ["webView": webView, "topLayout": topLayout]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayout][webView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
