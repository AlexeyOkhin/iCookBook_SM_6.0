//
//  ModuleBuilder.swift
//  
//
//  Created by Djinsolobzik on 04.02.2023.
//

import UIKit

protocol Builder {
    static func createHomeModule() -> UIViewController
    //static func createDetailsModule() -> UIViewController
}

final class ModuleBuilder: Builder {
    static func createHomeModule() -> UIViewController {
        let view = HomeViewController()
        //let networkService = NetvorkService()
//        let presenter = HomePresenter(view: view, networkService: networkService)
//        view.presenter = presenter
        return view
    }

//    static func createDetailsModule() -> UIViewController {
//        let view = DetailsViewController()
//        let networkService = NetvorkService()
//        let presenter = DetailsPresenter(view: view, networkService: networkService, reciept: reciept)
//        view.presenter = presenter
//        return view
//    }
}
