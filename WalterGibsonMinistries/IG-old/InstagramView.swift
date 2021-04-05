//
//  InstagramView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/3/21.
//

import SwiftUI

struct InstagramView: View {
    @State var instagramApi = InstagramApi.shared
    @State var signedIn = false
    @State var instagramImage = UIImage(imageLiteralResourceName: "WGPic copy")
    @State var presentAuth = false
    @State var testUserData = InstagramTestUser(access_token: "", user_id: 0)
    @State var instagramUser: InstagramUser? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
//                Image(uiImage: instagramImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .edgesIgnoringSafeArea(Edge.Set.all)
                
                VStack{
                    Button(action: {
                        //get instagram user data
                            if self.testUserData.user_id == 0 {
                                self.presentAuth.toggle()
                                
                            } else {
                                self.instagramApi.getInstagramUser(testUserData: self.testUserData) { (user) in
                                    self.instagramUser = user
                                    self.signedIn.toggle()
                                    
                                }
                                
                            }
                        
                    }) {
                        Image("WGPic copy")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                        
                    }
                    Button(action: {
                        //get instagram media
                        if self.instagramUser != nil {
                            self.instagramApi.getMedia(testUserData: self.testUserData) { (media) in
                                if media.media_type != MediaType.VIDEO {
                                    let media_url = media.media_url
                                    self.instagramApi.fetchImage(urlString: media_url, completion: { (fetchedImage) in
                                        if let imageData = fetchedImage {
                                            self.instagramImage = UIImage(data: imageData)!
                                            
                                        } else {
                                            //print("Didn’t fetched the data")
                                            
                                        }
                                        
                                    })
                                    //print(media_url)
                                    
                                } else {
                                    //print("Fetched media is a video")
                                    
                                }
                                
                            }
                            
                        } else {
                            //print("Not signed in")
                            
                        }
                        
                    }){
                        Text("Fetch Media to background")
                            .font(.headline)
                            .padding()
                        
                    }
                    
                }
                
            }.sheet(isPresented: self.$presentAuth) {
                WebView(presentAuth: self.$presentAuth, testUserData:   self.$testUserData, instagramApi: self.$instagramApi)
                
            }
            .actionSheet(isPresented: self.$signedIn) {
                let actionSheet = ActionSheet(title: Text("Signed in:"), message: Text("with account: @\(self.instagramUser!.username)"),buttons:   [.default(Text("OK"))])
                return actionSheet
                
            }
            
        }
    }
    
    func getUser() {
        if self.testUserData.user_id == 0 {
            self.presentAuth.toggle()
            
        } else {
            self.instagramApi.getInstagramUser(testUserData: self.testUserData) { (user) in
                self.instagramUser = user
                self.signedIn.toggle()
                
            }
            
        }
        
    }
    
    func fetchMedia() {
        if self.instagramUser != nil {
            self.instagramApi.getMedia(testUserData: self.testUserData) { (media) in
                if media.media_type != MediaType.VIDEO {
                    let media_url = media.media_url
                    self.instagramApi.fetchImage(urlString: media_url, completion: { (fetchedImage) in
                        if let imageData = fetchedImage {
                            self.instagramImage = UIImage(data: imageData)!
                            
                        } else {
                            //print("Didn’t fetched the data")
                            
                        }
                        
                    })
                    //print(media_url)
                    
                } else {
                    //print("Fetched media is a video")
                    
                }
                
            }
            
        } else {
            //print("Not signed in")
            
        }
    }
    
}

struct InstagramView_Previews: PreviewProvider {
    static var previews: some View {
        InstagramView()
    }
}
