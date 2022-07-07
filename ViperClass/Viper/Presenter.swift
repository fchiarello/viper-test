//
//  Presenter.swift
//  ViperClass
//
//  Created by Fellipe Ricciardi Chiarello on 7/4/22.
//

import Foundation
//It is an object
//protocol
//Reference to Interactor, Router, View

enum FetchErrors: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var view: AnyView?
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure(let error):
            view?.update(with: "Something went wrong!")
        }
    }
    
    
}
