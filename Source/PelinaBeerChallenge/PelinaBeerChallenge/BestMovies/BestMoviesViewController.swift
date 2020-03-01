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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.prefersLargeTitles = true
       }
       
    func collectionViewRxSetup() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10.0
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        moviesCollectionView.collectionViewLayout = layout
        
        moviesCollectionView.register(UINib(nibName: MoviesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MoviesCollectionViewCell.reuseId)
     
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
