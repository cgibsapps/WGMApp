//
//  WalterGibsonMinistriesApp.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/2/21.
//

import SwiftUI
import Parse

@main
struct WalterGibsonMinistriesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let configuration = ParseClientConfiguration {
            
            $0.applicationId = "FQPgjy09xVCUgTrJ0uAIff3lstJ0lnKziEXGRWxY"
            $0.clientKey = "VhlkkIDQbgeU8fcQkMTL01CWGNmykI3vHz6UzE8w"
            $0.server = "https://parseapi.back4app.com/"
            
        }
        Parse.initialize(with: configuration)
        
        let query = PFQuery(className: "Outline")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                ////print(objects!.count)
                ////print("found items")
                outlines.removeAll()
                for i in 0...objects!.count - 1 {
                    let object = objects![i]
                    let title = object["title"] as! String
                    let date = object["date"] as! String
                    let scripture = object["scripture"] as! String
                    let note = object["note"] as! String
                    
                    let newOutline = Outline(title: title, headline: date, summary: scripture, fullText: note)
                    outlines.append(newOutline)
                }
            } else {
                ////print("bummer")
            }
        }
        
        return true
        
        
    }
    
}
