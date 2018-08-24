//
//  CountryDetailsCell.swift
//  Demo_Wafer
//
//  Created by Parth on 24/08/18.
//  Copyright © 2018 Parth. All rights reserved.
//

import UIKit

protocol CountryDetailsCellDelegate: class {
    func tappedOnAnyCell()
    func deleteButtonTapped(_ tagValue:Int)
}

class CountryDetailsCell: UITableViewCell {
    @IBOutlet var lblCountryName: UILabel!
    @IBOutlet var lblCurrencyName: UILabel!
    @IBOutlet var lblLanguageName: UILabel!
    
    @IBOutlet var btnDelete: UIButton!

    weak var delegate: CountryDetailsCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.addGestureRecognizer(swipeLeft)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        
        btnDelete.addTarget(self, action: #selector(btnDeleteTapped(_:)), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - hit test event of uiview to detect if clipped button delete is within range of points then allow operation and hence because of that btnDeleteTapped will be called .
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let translatedPoint = btnDelete.convert(point, from: self)
        
        if (btnDelete.bounds.contains(translatedPoint)) {
            print("Your button was pressed")
            return btnDelete.hitTest(translatedPoint, with: event)
        }
        return super.hitTest(point, with: event)
    }

    // MARK: - Swipe and tap gesture recognizersevent for cell.
    @objc func respondToTapGesture(gesture: UITapGestureRecognizer) {
        self.delegate?.tappedOnAnyCell()
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        //we need to call this event to remove previously swiped cell button before initiating new cell swipe gesture..
        self.delegate?.tappedOnAnyCell()
        
        //This will transform uitableview cell to left side with little animation and show delete/bomb button
        UIView.animate(withDuration: 1.0) {
            self.transform = CGAffineTransform(translationX: -100, y: 0)
            Helper.swipedCellAccessibilityId = self.accessibilityIdentifier
        }
    }
    
    // MARK: - Delete action.
    @objc private func btnDeleteTapped(_ sender: UIButton?) {
        self.delegate?.deleteButtonTapped(self.tag)
    }
}
