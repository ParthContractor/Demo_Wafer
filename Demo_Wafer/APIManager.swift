//
//  APIManager.swift
//  Demo_Wafer
//
//  Created by Parth on 24/08/18.
//  Copyright © 2018 Parth. All rights reserved.
//

/* 1. Fetches json data through endpoint https://restcountries.eu/rest/v2/all */

import Foundation

//we do not want this shared instance to be subclassed.
//Hence considered final.
//This shared manager could be used for helper to call APIS/access required response..
final class APIManager{
    static let shared = APIManager()
    
    private init(){}
    
    // MARK: - Get Countries Data
    
    //method to fetch parsed/required data in collection and return error if any
    func getCountries(completionHandler: @escaping (_ listViewArray:[Country]?,_ error:Error?) -> Void){
    
        guard let url = URL(string: str_API_URL) else { return }
        
        //data task from URLSession for fetching remote data
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(nil,error)
            }
            
            guard let jsonData = data else { return }
            
            //JSONDecoder for decoding/parsing data to our custom models having foundation objects/nested structs using decodable protocol
            let decoder = JSONDecoder()
            
            do {
                let countriesArray = try decoder.decode([Country].self, from: jsonData)
                //country array to be returned after successful decoding process..
                completionHandler(countriesArray,nil)
            } catch {
                print(error.localizedDescription)
                //error to be returned in case of failure in decoding..
                completionHandler(nil,error)
            }
            
            }.resume()
    }
    
}
