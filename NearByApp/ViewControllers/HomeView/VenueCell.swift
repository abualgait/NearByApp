//
//  BookCell.swift
//  BokkStore


import UIKit

class VenueCell: UITableViewCell {
    
    
    @IBOutlet weak var myVenueName: UILabel!
    @IBOutlet weak var myVenueAddress: UILabel!
    @IBOutlet weak var myImage: BaseImageViewWithData!
    
    open func configureVenueCell(venue:Venue){
        myVenueName.text = venue.name
        myVenueAddress.text = venue.location?.cc
        myImage.getImageWithURL(venue.image)
    }
}
