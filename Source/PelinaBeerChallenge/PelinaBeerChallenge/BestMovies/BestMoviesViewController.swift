//
//  BestMoviesViewController.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class BestMoviesViewController: UIViewController {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var bag = DisposeBag()
    let spacing: CGFloat = 10.0
    var viewModel : BestMoviesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewRxSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.prefersLargeTitles = true
       }
       
    func collectionViewRxSetup() {
        let layout = UICollectionViewFlowLayout()
       
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        moviesCollectionView.collectionViewLayout = layout
        
        moviesCollectionView.register(UINib(nibName: MoviesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MoviesCollectionViewCell.reuseId)
         moviesCollectionView.rx.setDelegate(self).disposed(by: bag)
            moviesCollectionView.rx.contentOffset.map{
                offset in
                return self.moviesCollectionView.isNearBottomEdge(edgeOffset: 30)
            }.filter{
                return $0
            }.throttle(1, latest: false, scheduler: MainScheduler.instance)
                .subscribe({[weak self] _ in
                    self?.viewModel.requestMoreItems()
                }).disposed(by: bag)
            
            viewModel.movies.bind(to: moviesCollectionView.rx.items(cellIdentifier: MoviesCollectionViewCell.reuseId,cellType: MoviesCollectionViewCell.self)){
                index,model,cell in
                cell.bindTo(movie: model)
                cell.setFavorite(self.viewModel.checkIfIsFavorite(movie: model))
                cell.favoriteButton.rx.tap.subscribe(onNext : {[weak self]
                    _ in
                    guard let self = self else {return}
                    self.viewModel.didToggleFavorite(movie: model)
                    self.moviesCollectionView.reloadItems(at: [self.viewModel.indexPathFor(movie: model)])
                }).disposed(by: self.bag)
            }.disposed(by: bag)
            
            moviesCollectionView.rx.itemSelected.subscribe(onNext: {[weak self] value in
                self?.viewModel.didSelectMovieAt(indexPath : value)
                }).disposed(by: bag)
    }

}


extension BestMoviesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = spacing
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width, height: 1.2*width)
    }
}
