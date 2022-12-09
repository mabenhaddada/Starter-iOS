//
//  OnlyLatestDisposable.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import RxSwift

@propertyWrapper
class OnlyLatestDisposable {
    var wrappedValue: Disposable? {
        willSet { wrappedValue?.dispose() }
    }
    
    deinit {
        wrappedValue?.dispose()
    }
}
