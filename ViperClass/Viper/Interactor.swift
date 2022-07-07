//
//  Interactor.swift
//  ViperClass
//
//  Created by Fellipe Ricciardi Chiarello on 7/4/22.
//

import Foundation

//It is an object
//Protocol to describe their properties
//Reference to presenter

//https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchErrors.failed))
                return }
            
            do {
                let entities  = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))                
            }
            catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
            
        }
        task.resume()
    }
}
