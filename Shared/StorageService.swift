//
//  StorageService.swift
//  Social Keyboard
//
//  Created by Alex Appadurai on 04/04/22.
//

import Foundation

class StorageService{
    static let shared = StorageService()
    let user : UserDefaults
    
    init() {
        user = UserDefaults.init(suiteName: "group.com.alex.colorkeyboard") ?? UserDefaults.standard
    }
    func save(_ items:[SocialProfileModel]) {
        if let data = try? JSONEncoder().encode(items){
            user.set(data, forKey: "social_profile_key")

        }
        user.synchronize()
    }
    func socialProfile() -> [SocialProfileModel]? {
        if let data = user.data(forKey: "social_profile_key"),
           let list = try? JSONDecoder().decode([SocialProfileModel].self, from: data)
        {
            return list
        }
        return nil
    }
    
    func save(launchApp:Bool){
        print("launchApp", launchApp)
        user.set(launchApp, forKey: "launch_app")
        user.synchronize()
    }
    func launchApp()->Bool{
        return user.bool(forKey: "launch_app")
    }
}
