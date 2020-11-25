//
//  Binder.swift
//  Xed
//
//  Created by Phuong Lam on 4/14/19.
//  Copyright © 2019 xed. All rights reserved.
//

// _ before type: mark ignore label when call methods
class Binding<T> {
    
    private let binder: Binder
    private let type: T.Type
    private var named: String = ""
    
    init(_ type: T.Type, binder: Binder) {
        self.binder = binder
        self.type = type
    }
    
    @discardableResult func to(_ any: Any) -> Binder {
        return binder.bind(type, instance: any, name: self.named)
    }
    
    func withName(_ named: String) -> Binding {
        self.named = named
        return self
    }
}

class Binder {
    private var map: [String: Any] = [:]
    
    @discardableResult func bind<T>(_ type: T.Type, instance any: Any, name: String = "") -> Binder {
        map[KeyIdentifier(type: type, name: name).mkKey()] = any
        return self
    }
    
    func bind<T>(_ type: T.Type) -> Binding<T> {
        return Binding(type, binder: self)
    }
    
    func get<T>(_ type: T.Type, name: String = "") -> T? {
        return map[KeyIdentifier(type: type, name: name).mkKey()] as? T
    }
}

struct KeyIdentifier<T> {
    
    private let type: T.Type
    private let name: String
    
    init(type: T.Type, name: String = "") {
        self.name = name
        self.type = type
    }
    
    func mkKey() -> String {
        return "\(String(UInt(bitPattern: ObjectIdentifier(self.type))))-\(self.name)"
    }
}
