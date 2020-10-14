//
//  StupselnSection.swift
//  p153-ios
//
//  Created by ihor-ios on 10.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

struct StupselnSection {
    var headerImage: UIImage
    var title: String
    var description: String
    var stupselnItems: [Stupslers]
}

extension StupselnSection: AnimatableSectionModelType {
    typealias Item = Stupslers
    
    typealias Identity = String
    
    var identity: String {
        return title
    }
}

extension StupselnSection: SectionModelType {
    var items: [Stupslers] {
        return stupselnItems
    }
    
    init(original: StupselnSection, items: [Stupslers]) {
        self = original
        self.stupselnItems = items
    }
}
