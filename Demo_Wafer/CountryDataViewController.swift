//
//  CountryDataViewController.swift
//  Demo_Wafer
//
//  Created by Parth on 23/08/18.
//  Copyright © 2018 Parth. All rights reserved.
//

import UIKit

class CountryDataViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CountryDetailsCellDelegate {
   
    // MARK: - CountryDetailsCellDelegate
    func tappedOnAnyCell() {
        
        //to prevent unnecessary looping through while no cell is having swipe delete visible..hence return..
        guard let lastSwipedCellAccessibilityId = Helper.swipedCellAccessibilityId else { return }

        //here only check identifier of lastswiped cell and hence perform operation on that row only..
        let cells = self.tableViewCountriesData.visibleCells
        for cell in cells {
            if(cell.accessibilityIdentifier == lastSwipedCellAccessibilityId){
                
                UIView.animate(withDuration: 0.5) {
                    cell.transform = CGAffineTransform.identity
                    Helper.swipedCellAccessibilityId = nil
                }

            }
        }
    }
    
    func deleteButtonTapped(_ tagValue: Int) {
        self.listViewArray?.remove(at: tagValue)
        let indexPath = IndexPath.init(row: tagValue, section: 0)
        DispatchQueue.main.async {
            self.tableViewCountriesData.deleteRows(at: [indexPath], with: .automatic)
            self.tableViewCountriesData.reloadData()
        }
    }
    
    // MARK: - Viewcontroller properties
    var listViewArray: [Country]?
    @IBOutlet var tableViewCountriesData: UITableView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    // MARK: - Viewcontroller and helper methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.startLoadingIndicator()
        
        self.initialSetUp()
        
        self.loadData()
    }
    
    func startLoadingIndicator(){
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingIndicator(){
        loadingIndicator.stopAnimating()
    }
    
    func initialSetUp(){
        //estimated row height for dynamic cell before actual height gets calculated based on constraints
        tableViewCountriesData.rowHeight = UITableViewAutomaticDimension
        tableViewCountriesData.estimatedRowHeight = 135
        
        //tableview cell registeration
        tableViewCountriesData.register(UINib(nibName: "CountryDetailsCell", bundle: nil), forCellReuseIdentifier: "CountryDetailsCellId")
    }
    
    func loadData(){
        /*    2. Display json data as listview with following elements parsed from json */
        
        //call  API to get country data and do needful loading to display in tableview
        APIManager.shared.getCountries(completionHandler:{ array,error  in
            //Handle Error if any
            if let error = error{
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.stopLoadingIndicator()
                return
            }
            
            //Handle Successful data
            if let array = array{
                self.listViewArray = array
                //as data is fetched, update tableview on main thread as its UI update
                DispatchQueue.main.async {
                    self.tableViewCountriesData.reloadData()
                    self.stopLoadingIndicator()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Tableview delegate/datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = self.listViewArray{
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailsCellId") as! CountryDetailsCell
      
        //setting accessibilityIdentifier to detect last swiped cell identifier to remove on tap event of any other cell or that cell itself..
        cell.accessibilityIdentifier = "CountryDetailsCellId" + "\([indexPath.row])"
        
        //for swipe to delete operation event we will require specific indexpth row to identify which data to be removed.
        cell.tag = indexPath.row
       
        let objCountryData = self.listViewArray![indexPath.row]
        
        //setup country
        if let countryName = objCountryData.name{
            cell.lblCountryName.text = "Country: " + countryName
        }
        
        //setup currency
        let nameOfFirstCurrency = Helper.returnFirstCurrencyName(objCountryData)
        if let nameOfFirstCurrency = nameOfFirstCurrency{
            cell.lblCurrencyName.text = "Currency: " + nameOfFirstCurrency
        }
        
        //setup language
        let nameOfFirstLanguage = Helper.returnFirstLanguageName(objCountryData)
        if let nameOfFirstLanguage = nameOfFirstLanguage{
            cell.lblLanguageName.text = "Language: " + nameOfFirstLanguage
        }
        
        cell.delegate =  self
        
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //delete row and data on user initiated delete action
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.listViewArray?.remove(at: indexPath.row)
            self.tableViewCountriesData.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)

        return [deleteAction]
    }
 
 */
    
}

