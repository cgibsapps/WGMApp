//
//  HomeView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/3/21.
//

import SwiftUI
let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

struct HomeView: View {
        @State var show = false
       @State var showProfile = false

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                //ScrollView(.vertical) {
                    VStack {
                        OutlineList(outlineArray: OutlineArray())
                            .padding(.top, 150)
                    
                    }
                //}
            }.blur(radius: show ? 20 : 0)
            .scaleEffect(showProfile ? 0.95 : 1)
            .animation(.default)
            VStack {
                HStack {
                     MenuButton(show: $show)
                        .offset(x: -40)
                         Spacer()

                     MenuRight(show: $showProfile)
                        .offset(x: -16)
                 }.offset(y: showProfile ? statusBarHeight : 80)
                .animation(.spring())

                MenuView(show: $show)
            Spacer()
            }
            
            Image("WGPic copy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .offset(y: showProfile ? statusBarHeight - 30 : 50)
        }.background(Color("background"))
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct Menu: Identifiable {
   var id = UUID()
   var title: String
   var icon: String
}

struct MenuRow: View {

   var image = "creditcard"
   var text = "My Account"

   var body: some View {
      return HStack {
         Image(systemName: image)
            .imageScale(.large)
            .foregroundColor(Color("icons"))
            .frame(width: 32, height: 32)

         Text(text)
            .font(.headline)
            .foregroundColor(.primary)

         Spacer()
      }
   }
}

let menuData = [
   Menu(title: "Home", icon: "house"),
   Menu(title: "Outlines", icon: "list.dash"),
   Menu(title: "Prayers", icon: "hands.sparkles"),
   Menu(title: "Reading Plan", icon: "book.closed"),
   Menu(title: "Social", icon: "person.2.circle")
]

struct MenuView: View {

   var menu = menuData
   @Binding var show: Bool
   @State var showHome = false
    @State var showOutline = false
    @State var showPrayers = false
    @State var showReading = false
    @State var showSocial = false
    @State var showBookings = false

   var body: some View {
      return HStack {
         VStack(alignment: .leading) {
            ForEach(menu) { item in
                
                if item.title == "Home" {
                  Button(action: { //self.showHome.toggle()
                    self.show.toggle()
                  }) {
                     MenuRow(image: item.icon, text: item.title)
                        .sheet(isPresented: self.$showHome) {
                            //Settings()
                            //HomeView()
                            
                        }
                  }
               } else if item.title == "Outlines" {
                Button(action: {
                    self.showOutline.toggle()
                    outlineOpened = false
                }) {
                   MenuRow(image: item.icon, text: item.title)
                      .sheet(isPresented: self.$showOutline) {
                          //Settings()
                        
                        OutlineDetailList(outlineArray: OutlineArray())
                      }
                }
             } else if item.title == "Prayers" {
                Button(action: {
                    self.showPrayers.toggle()
                    prayerOpened = false
                }) {
                   MenuRow(image: item.icon, text: item.title)
                      .sheet(isPresented: self.$showPrayers) {
                          //Settings()
                        
                        PrayerDetailList(prayerArray: PrayerArray())
                          
                      }
                }
             } else if item.title == "Reading Plan" {
                Button(action: {
                    self.showReading.toggle()
                    readingOpened = false
                }) {
                   MenuRow(image: item.icon, text: item.title)
                      .sheet(isPresented: self.$showReading) {
                          //Settings()
                        
                        ReadingCalendar(readingArray: ReadingArray())
                      }
                }
             } else if item.title == "Social" {
                Button(action: { self.showSocial.toggle() }) {
                   MenuRow(image: item.icon, text: item.title)
                      .sheet(isPresented: self.$showSocial) {
                          //Settings()
                          SocialDetail()
                      }
                }
             } else {
                  MenuRow(image: item.icon, text: item.title)
               }
            }
            Spacer()
         }
         .padding(.top, 20)
         .padding(30)
         .frame(minWidth: 0, maxWidth: 360)
         .background(Color("button"))
         .cornerRadius(30)
         .padding(.trailing, 60)
         .shadow(radius: 20)
         .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
         .animation(.default)
         .offset(x: show ? 0 : -UIScreen.main.bounds.width)
         .onTapGesture {
            self.show.toggle()
         }
         Spacer()
      }.padding(.top, statusBarHeight)
   }
}

struct MenuButton: View {
   @Binding var show: Bool

   var body: some View {
      return ZStack(alignment: .topLeading) {
         Button(action: {
            self.show.toggle()
            prayerOpened = true
            readingOpened = true
         }) {
            HStack {
               Spacer()

               Image(systemName: "list.dash")
                  .foregroundColor(.primary)
            }
            .padding(.trailing, 18)
            .frame(width: 90, height: 60)
            .background(Color("button"))
            .cornerRadius(30)
            .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
         }
         Spacer()
      }
   }
}
