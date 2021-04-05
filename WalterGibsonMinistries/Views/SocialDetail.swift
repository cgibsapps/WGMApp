//
//  SocialList.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/8/21.
//

import SwiftUI

struct SocialDetail: View {

   var body: some View {
      return VStack(alignment: .leading) {
        
        
        SocialCircle(link: "https://www.facebook.com/profile.php?id=100025420964995", imageName: "fb-icon", linkName: "Facebook")
        SocialCircle(link: "https://www.instagram.com/dr.waltergibsonjr/", imageName: "ig-icon", linkName: "Instagram")
        SocialCircle(link: "https://twitter.com/waltergibsonjr", imageName: "t-icon", linkName: "Twitter")
        SocialCircle(link: "https://open.spotify.com/album/1XgojdUcQXthe0tesWc4wH?si=SueEqWStQwaDXTmMjo_YtQ", imageName: "sp-icon", linkName: "Spotify")
        SocialCircle(link: "https://www.youtube.com/user/waltergibsonministri", imageName: "yt-icon", linkName: "YouTube")
        

      }
      .frame(width: screen.width, height: screen.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .background(Color("background")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
   }
}

struct SocialDetail_Previews: PreviewProvider {
    static var previews: some View {
        SocialDetail()
    }
}


struct SocialCircle: View {
    var link: String
    var imageName: String
    var linkName: String
    var body: some View {
        Link(destination: URL(string: self.link)!) {
            HStack {
                Image(self.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .shadow(color: Color("royalBlue").opacity(0.3), radius: 20, x: 0, y: 20)
                
                Text(self.linkName)
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color("royalBlue"))
                    .shadow(color: Color("royalBlue").opacity(0.3), radius: 20, x: 0, y: 20)
            }
        }
        .padding()
    }
}
