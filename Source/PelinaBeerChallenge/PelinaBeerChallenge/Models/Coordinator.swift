//
//  Coordinator.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    init(navigationController : UINavigationController)
    func start()
}

extension Coordinator {
    func instantiateInitialVCFromStoryboard(storyboardName : String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        guard let existingVc = vc else {fatalError("Initial view controller not set in storyboard \(storyboardName)")
        }
        return existingVc
    }
}
