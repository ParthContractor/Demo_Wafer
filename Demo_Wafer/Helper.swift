//
//  Helper.swift
//  Demo_Wafer
//
//  Created by Parth on 24/08/18.
//  Copyright © 2018 Parth. All rights reserved.
//

import Foundation

class Helper {
    
    static var swipedCellAccessibilityId:String?
    /*
     a. “name”  ->  this is Country Name
     b  “currencies” -> ”name" -> this is currency name, if more than 1 currency is present, first currency name is to be displayed
     c. “languages” -> “name”  -> this is language name, if more than 1 language is present first language is to be used
     */
    
    //filter record in tableview based on requirement(like showing/returing first currency name and first language name only in case of multiple values )
    static func returnFirstCurrencyName(_ country:Country)->String?{
        if let arrayCurrency = country.currency{
            if let firstCurrency = arrayCurrency.first{
                if let firstCurrencyName = firstCurrency.name{
                    return firstCurrencyName
                }
            }
        }
        return nil
    }
    
    static func returnFirstLanguageName(_ country:Country)->String?{
        if let arrayLanguage = country.language{
            if let firstLanguage = arrayLanguage.first{
                if let firstLanguageName = firstLanguage.name{
                    return firstLanguageName
                }
            }
        }
        return nil
    }

    
}
