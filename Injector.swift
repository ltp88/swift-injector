//
//  Injector.swift
//  Xed
//
//  Created by Phuong Lam on 4/14/19.
//  Copyright © 2019 xed. All rights reserved.
//

class Injector {
    private var binder: Binder
    init(binder: Binder) {
        self.binder = binder
    }
    
    func get<T>(_ type: T.Type, name: String = "") -> T? {
        return binder.get(type, name: name)
    }
    
    static func  builder() -> InjectorBuilder {
        return InjectorBuilder()
    }
}

class InjectorBuilder {
    
    private var binder: Binder!
    private var modules: [Module] = []
    
    func withBinder(binder: Binder) -> InjectorBuilder {
        self.binder = binder
        return self
    }
    
    func withModule(_ modules: [Module]) -> InjectorBuilder {
        self.modules = modules
        return self
    }
    
    func build() -> Injector {
        for module in modules {
            module.configure(binder: binder)
        }
        return Injector(binder: binder)
    }
}
