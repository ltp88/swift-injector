//
//  Module.swift
//
//  Created by Phuong Lam on 4/14/19.
//  Copyright © 2019 . All rights reserved.
//

protocol Module {
    func configure(binder: Binder)
}

class AbstractModule: Module {
    private var binder: Binder!
    
    public func configure() {
        
    }
    
    public func bind<T>(_ type: T.Type) -> Binding<T> {
        return self.binder.bind(type)
    }
    
    public final func configure(binder: Binder) {
        self.binder = binder
        configure()
    }
    
    public func get<T>(type: T.Type) -> T? {
        return binder?.get(type)
    }
}
