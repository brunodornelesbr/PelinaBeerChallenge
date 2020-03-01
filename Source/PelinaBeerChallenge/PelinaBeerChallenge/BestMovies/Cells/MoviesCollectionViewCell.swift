//
//  MoviesCollectionViewCell.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit
import AlamofireImage
class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterLabel: UILabel!
    
        static var reuseId = "MoviesCollectionViewCell"
        static var nibName = "MoviesCollectionViewCell"
        func bindTo(movie : Movie){
            posterLabel.text = movie.original_title
            guard let posterURL = movie.getPosterURL() else {
                posterImageView.image = ImageConstants.placeholderImage
                return
            }
            posterImageView.af_setImage(withURL: posterURL, placeholderImage: ImageConstants.placeholderImage, filter: nil, imageTransition: UIImageView.ImageTransition.crossDissolve(0.2))
           }
    }

