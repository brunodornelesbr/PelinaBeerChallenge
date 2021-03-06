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
    var segmentControl = UISegmentedControl()
    var bag = DisposeBag()
    let spacing: CGFloat = 10.0
    var viewModel : BestMoviesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout()
        segmentControlSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.resetMovies()
    }
    
    func segmentControlSetup() {
        let titles = viewModel.options.value.map{ value in
            return value.rawValue
        }
        
        segmentControl = UISegmentedControl(items: titles)
        segmentControl.sizeToFit()
        segmentControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentControl
        segmentControlRx()
    }
    
    func segmentControlRx() {
        segmentControl.rx.selectedSegmentIndex.asDriver().drive(onNext : {[weak self] value in
            guard let self = self else {return}
            self.viewModel.didSelect(segmentControlIndex: value)
        }).disposed(by: bag)
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
               layout.minimumLineSpacing = spacing
               layout.minimumInteritemSpacing = spacing
               moviesCollectionView.collectionViewLayout = layout
        
        moviesCollectionView.register(UINib(nibName: MoviesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MoviesCollectionViewCell.reuseId)
        moviesCollectionView.rx.setDelegate(self).disposed(by: bag)
        
         collectionViewRxSetup()
    }
    
    func collectionViewRxSetup() {
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
            cell.favoriteButton.rx.tap.asDriver().drive(onNext : {[weak self]
                value in
                guard let self = self else {return}
                self.viewModel.didToggleFavorite(movie: model)
                self.moviesCollectionView.reloadItems(at: [self.viewModel.indexPathFor(movie: model)])
            }).disposed(by: cell.disposeBag)
        }
        
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
