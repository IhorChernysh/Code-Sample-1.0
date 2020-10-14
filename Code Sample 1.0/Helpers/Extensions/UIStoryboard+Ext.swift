//
//  UIStoryboard+Ext.swift
//  p153-ios
//
//  Created by ihor-ios on 01.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//


import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    
    /// The uniform place where we state all the storyboard we have in our application
    
    enum Storyboard: String {
        case login
        
        var filename: String { return rawValue.firstCapitalized }
    }
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - View Controller Instantiation from Generics
    
//    func instantiateViewController<T: UIViewController>() -> T {
//        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
//            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
//        }
//        
//        return viewController
//    }
}
