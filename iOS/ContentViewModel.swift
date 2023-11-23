//
//  ContentViewModel.swift
//  Social Keyboard (iOS)
//
//  Created by Alex Appadurai on 04/04/22.
//

import Foundation

class ContentViewModel: ObservableObject{
    @Published var launchApp: Bool{
        didSet{
            if doNotlaunchApp == launchApp {
                doNotlaunchApp.toggle()
            }
            StorageService.shared.save(launchApp: launchApp)
        }
    }
    @Published var doNotlaunchApp: Bool{
        didSet{
            if launchApp == doNotlaunchApp {
                launchApp.toggle()
            }
            StorageService.shared.save(launchApp: !doNotlaunchApp)
        }
    }
    @Published var profiles: [SocialProfileModel]
    
    init() {
        launchApp = StorageService.shared.launchApp()
        doNotlaunchApp = !StorageService.shared.launchApp()
        if let items = StorageService.shared.socialProfile(){
            profiles = items 
        }else{
            profiles = []
            defaultValues()
        }
    }
    private func defaultValues(){
        profiles.append(SocialProfileModel(type: .facebook, value: nil))
        profiles.append(SocialProfileModel(type: .instagram, value: nil))
        profiles.append(SocialProfileModel(type: .phone, value: nil))
        profiles.append(SocialProfileModel(type: .twitter, value: nil))
        profiles.append(SocialProfileModel(type: .youtube, value: nil))
        profiles.append(SocialProfileModel(type: .linkedIn, value: nil))
        profiles.append(SocialProfileModel(type: .whatsapp, value: nil))
        StorageService.shared.save(profiles)
    }
    
    func save(text:String, profile:SocialProfileModel){
        guard let index = profiles.firstIndex(where: {$0.type == profile.type}) else {
            return
        }
        var updateProfile = profile;
        updateProfile.value = text
        profiles[index] = updateProfile
        StorageService.shared.save(profiles)
    }
}
