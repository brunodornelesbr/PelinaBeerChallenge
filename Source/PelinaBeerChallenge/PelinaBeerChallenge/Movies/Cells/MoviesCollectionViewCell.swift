//
//  MoviesCollectionViewCell.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit
import AlamofireImage
import RxSwift
class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
         disposeBag = DisposeBag()
    }
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
    
    func setFavorite(_ value : Bool) {
        let buttonImage = value ? #imageLiteral(resourceName: "baseline_favorite_black_24pt") :  #imageLiteral(resourceName: "baseline_favorite_border_black_24pt")
        favoriteButton.setImage(buttonImage, for: .normal)
    }
    }

