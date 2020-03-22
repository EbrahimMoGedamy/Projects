//
//  DefaultsBuilder.swift
//  KKDefaults
//
//  Created by khaledkamal on 4/30/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation
protocol KKDefaultsBuilder  {
}

//MARK:- Check Type
private extension KKDefaultsBuilder
{
    var userDefaults : UserDefaults{return UserDefaults.standard}
    func isSwiftCodableType<T>(_ type: T.Type) -> Bool {
        switch type {
        case is String.Type, is Bool.Type, is Int.Type, is Float.Type, is Double.Type:return true
        default:return false
        }
    }
}
//MARK:- Save
extension KKDefaultsBuilder where Self : RawRepresentable
{
    func save<ValueType:Any>(_ value: ValueType)  {
        guard let key = rawValue as? String else {return
        }
        if isSwiftCodableType(ValueType.self){
            userDefaults.set(value, forKey: key)
            userDefaults.synchronize()
            return
        }
    }
    
    internal func save<ValueType : Codable>(_ value: ValueType)
    {
        guard let key = rawValue as? String else {return
        }
        if isSwiftCodableType(ValueType.self){
            userDefaults.set(value, forKey: key)
            userDefaults.synchronize()
            return
        }
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode( value)
            userDefaults.set(encoded, forKey: key)
        } catch {
            #if DEBUG
            print("Error" , error)
            #endif
        }
    }
    
    func get<ValueType>()-> ValueType?  {
        
        guard let key = rawValue as? String else {return nil
        }
        if isSwiftCodableType(ValueType.self){
            return userDefaults.value(forKey: key) as? ValueType
        }
        return nil
    }
    
    internal func get<ValueType : Codable>()-> ValueType?
    {
        guard let key = rawValue as? String else {return nil
        }
        print(key)
        if isSwiftCodableType(ValueType.self){
            let value_ = userDefaults.value(forKey: key) as? ValueType
            return value_
        }else{
            do{
                guard let dt = userDefaults.value(forKey: key) as? Data else{return nil}
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(ValueType.self, from: dt)
                return decoded
            }catch{
                #if DEBUG
                print("Error" , error)
                #endif
            }
        }
        return nil
    }
}


//MARK:- Remove
extension KKDefaultsBuilder where Self : RawRepresentable
{
    func remove()
    {
        guard let key = rawValue as? String else {return
        }
        userDefaults.set(nil, forKey: key)
    }
    
    func removeAll()
    {
        guard let bundle = Bundle.main.bundleIdentifier else {return
        }
        userDefaults.removePersistentDomain(forName: bundle)
    }
}

