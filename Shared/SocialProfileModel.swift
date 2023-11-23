//
//  SocialProfileModel.swift
//  Social Keyboard
//
//  Created by Alex Appadurai on 04/04/22.
//

import Foundation

enum SocialProfileType:Int,Codable {
    case facebook,instagram,phone,twitter,youtube,linkedIn,whatsapp
    var icon:String{
        switch self {
        case .facebook:
            return "facebook"
        case .instagram:
            return "instagram"
        case .phone:
            return "phone"
        case .twitter:
            return "twitter"
        case .youtube:
            return "youtube"
        case .linkedIn:
            return "linkedin"
        case .whatsapp:
            return "whatsapp"
        }
    }
    var schema:String{
        switch self {
        case .facebook:
            return "fb://"
        case .instagram:
            return "instagram://"
        case .phone:
            return "tel://"
        case .twitter:
            return "twitter://"
        case .youtube:
            return "youtube://"
        case .linkedIn:
            return "linkedin://"
        case .whatsapp:
            return "whatsapp://send?text="
        }
    }
}
struct SocialProfileModel:Codable,Identifiable{
    var id: String{
        return "\(type)"
    }
    
    let type: SocialProfileType
    var value: String?
    
    var openAppURL: String?{
        if let v = value{
            return  "\(type.schema)\(v)".replacingOccurrences(of: " ", with: "%20")
        }
        return nil
    }
}
