//
//  Country.swift
//  Demo_Wafer
//
//  Created by Parth on 24/08/18.
//  Copyright © 2018 Parth. All rights reserved.
//

import Foundation

//Taking Country struct because we are having array of countries and its data in json response data
//Also keeping properties optional for safer side and part of good practice(for example, in given response of API there are some null values in language and currency names)
//Swift 4 decodable protocol helps us map foundation objects from json data and also gives privilege to parse required items only(for example, we have kept country model as per our required properties only and ignoring other data from response)
public struct Country : Decodable {
    let name: String?
    let currency: [Currency]?//because we expect currency and language arrays from API response
    let language: [Language]?
    
    //for different naming compared to actual json key
    enum CodingKeys: String, CodingKey {
        case currency = "currencies"
        case language = "languages"
        case name
    }
}
