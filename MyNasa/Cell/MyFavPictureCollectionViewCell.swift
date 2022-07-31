//
//  MyFavPictureCollectionViewCell.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 31/07/22.
//

import UIKit

class MyFavPictureCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var imageVIew: UIImageView! {
        didSet {
            imageVIew.contentMode = .scaleAspectFill
        }
    }

    
}
