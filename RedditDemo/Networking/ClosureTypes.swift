//
//  ClosureTypes.swift
//  RedditDemo
//
//  Created by Israrul on 10/23/22.
//  Copyright © 2022 Israrul. All rights reserved.
//

import Foundation

struct ClosureTypes {
    typealias ListingResponseClosure = (ListingResponseModel?) -> Void
    typealias ListingsResponseClosure = ([ListingResponseModel]?) -> Void
    typealias LoadImageDataClosure = (Data) -> Void
}
