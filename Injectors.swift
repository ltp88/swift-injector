//
//  Injectors.swift
//
//  Created by Phuong Lam on 4/14/19.
//  Copyright © 2019 . All rights reserved.
//

class Injectors {
    private static var injector: Injector!
    
    static func initialize(modules: Module...) {
        self.injector = Injector.builder()
            .withBinder(binder: Binder())
            .withModule(modules)
            .build()
    }
    
    static func get<T>(_ type: T.Type, name: String = "") -> T {
        guard let instance = injector.get(type, name: name) else {
            fatalError("\(type) has no instance provided")
        }
        return instance
    }
}