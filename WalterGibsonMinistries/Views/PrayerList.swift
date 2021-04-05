//
//  PrayerList.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/3/21.
//

import SwiftUI
import Parse
import Combine
import ElegantCalendar
var prayerOpened = false
struct PrayerList: View {
    var id = UUID()
    @ObservedObject var prayerArray: PrayerArray
    @State var showContent = false
    @State var number = 6
    @State private var selectedPrayer: Prayer? = nil
    var body: some View {
          VStack {
             HStack {
                VStack(alignment: .leading) {
                   Text("Prayers")
                      .font(.largeTitle)
                      .fontWeight(.heavy)

                    Text("\(self.prayerArray.prayers.count) Prayers")
                      .foregroundColor(.gray)
                }.padding(.top, 20)
                Spacer()
             }
             .padding(.leading, 60.0)

             ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10.0) {
                    ForEach(prayerArray.prayers) { prayer in
                       
                          GeometryReader { geometry in
                            
                            Button(action: { self.showContent.toggle() }) {
                             PrayerRow(prayer: prayer)
                                .rotation3DEffect(Angle(degrees:
                                   Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                .onTapGesture {
                                    self.selectedPrayer = prayer
                                }
                          }.buttonStyle(PlainButtonStyle())
                          
                       }.frame(width: 246, height: 246)
                    }
                }.sheet(item: self.$selectedPrayer) {
                    PrayerDetail(prayer: $0)
                }
                .padding(.leading, 30)
                .padding(.top, 30)
                .padding(.bottom, 40)
                Spacer()
             }
             //CertificateRow()
          }
          .padding(.top, 38)
          .onAppear() {
            if prayerOpened == false {
           findObjects()
            }
          }
       
    }
    func findObjects() {
        let query = PFQuery(className: "Prayer")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                ////print(objects!.count)
                ////print("found prayers")
                
                var newPrayers: [Prayer] = []
                for i in 0...objects!.count - 1 {
                    let object = objects![i]
                    let title = object["title"] as! String
                    //let subtitle = object["subtitle"] as? String ?? ""
                    let words = object["words"] as! String
                    
                    let newPrayer = Prayer(title: title, words: words)
                    newPrayers.append(newPrayer)
                    if i == objects!.count - 1 {
                        prayerArray.prayers = newPrayers
                        ////print("done")
                        prayerOpened = true
                    }
                }
            } else {
                ////print("bummer")
            }
        }
    }
 }

struct PrayerDetailList: View {
    var id = UUID()
    @State var mailInfo: MailInfo = MailInfo()
    @ObservedObject var prayerArray: PrayerArray
    @State var showContent = false
    @State var number = 6
    @State private var selectedPrayer: Prayer? = nil
    var body: some View {
          VStack {
             HStack {
                VStack(alignment: .leading) {
                   Text("Prayers")
                      .font(.largeTitle)
                      .fontWeight(.heavy)

                    Text("\(self.prayerArray.prayers.count) Prayers")
                      .foregroundColor(.gray)
                }
                Spacer()
             }
             .padding(.leading, 60.0)

             ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10.0) {
                    ForEach(prayerArray.prayers) { prayer in
                       
                          GeometryReader { geometry in
                            
                            Button(action: { self.showContent.toggle() }) {
                             PrayerRow(prayer: prayer)
                                .rotation3DEffect(Angle(degrees:
                                   Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                .onTapGesture {
                                    self.selectedPrayer = prayer
                                }
                          }.buttonStyle(PlainButtonStyle())
                          
                       }.frame(width: 246, height: 246)
                    }
                }.sheet(item: self.$selectedPrayer) {
                    PrayerDetail(prayer: $0)
                }
                .padding(.leading, 30)
                .padding(.top, 30)
                .padding(.bottom, 40)
                Spacer()
             }
             //CertificateRow()
            RequestButton(textColor: Color.white, selectedDate: Date())
                .padding(.bottom, 50)
//            MailContainer(mailInfo: self.$mailInfo, prompt: "Request personal prayer")
//                .padding(.bottom, 50)
          }
          .padding(.top, 38)
          .onAppear() {
            if prayerOpened == false {
           findObjects()
            }
          }
       
    }
    func findObjects() {
        let query = PFQuery(className: "Prayer")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                ////print(objects!.count)
                ////print("found prayers")
                
                var newPrayers: [Prayer] = []
                for i in 0...objects!.count - 1 {
                    let object = objects![i]
                    let title = object["title"] as! String
                    //let subtitle = object["subtitle"] as? String ?? ""
                    let words = object["words"] as! String
                    
                    let newPrayer = Prayer(title: title, words: words)
                    newPrayers.append(newPrayer)
                    if i == objects!.count - 1 {
                        prayerArray.prayers = newPrayers
                        ////print("done")
                        prayerOpened = true
                    }
                }
            } else {
                ////print("bummer")
            }
        }
    }
 }

 #if DEBUG
 struct PrayerList_Previews: PreviewProvider {
    static var previews: some View {
       PrayerList(prayerArray: PrayerArray())
    }
 }
 #endif


struct PrayerRow: View {
    var prayer: Prayer


   var body: some View {
      return VStack(alignment: .leading) {
        Text(prayer.title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(30)
            .lineLimit(4)
        
        Spacer()

      }
      .background(prayer.color)
      .cornerRadius(30)
      .frame(width: 246, height: 246)
      .shadow(color: prayer.shadowColor, radius: 20, x: 0, y: 20)
   }
}

struct PrayerDetail: View {
    var prayer: Prayer
   

   var body: some View {
      return VStack(alignment: .leading) {
        Text(prayer.title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(30)
            .lineLimit(4)
        
        ScrollView(.vertical) {
            Text(prayer.words)
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.white)
                .padding(30)
        }
        
        Spacer()

      }
      .background(prayer.color)
      .shadow(color: prayer.shadowColor, radius: 20, x: 0, y: 20)
   }
}

class PrayerArray: ObservableObject {

    let objectWillChange = PassthroughSubject<PrayerArray,Never>()

    var prayers: [Prayer] = [] {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
}

class Prayer: Identifiable {

var id = UUID()
var title: String
//var subtitle: String
var words: String
var color: Color
var shadowColor: Color

init (title: String, words: String) {
    self.title = title
    //self.subtitle = subtitle
    self.words = words
    let randomInt = Int.random(in: 0...7)
    self.color = CalendarTheme.allThemes[randomInt].primary
    self.shadowColor = CalendarTheme.allThemes[randomInt].primary.opacity(0.5)
}
}
