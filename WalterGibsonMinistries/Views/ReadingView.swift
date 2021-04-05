//
//  ReadingView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/3/21.
//

import SwiftUI
import Parse
import Combine
import ElegantCalendar
var readingOpened = false
var calGridItemLayout = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]

struct ReadingCalendar: View {
    @State private var selectedReading: Reading? = nil
    @ObservedObject var readingArray: ReadingArray
    var body: some View {
        
        VStack {
           HStack {
              VStack(alignment: .leading) {
                 Text("Reading Plan")
                    .font(.largeTitle)
                    .fontWeight(.heavy)

                  Text("30 Days")
                    .foregroundColor(.gray)
              }.padding(.top, 20)
              Spacer()
           }
           .padding(.leading, 60.0)
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            VStack {
                LazyVGrid(columns: calGridItemLayout, spacing: 20) {
                    ForEach(readingArray.reading, id: \.id) { reading in
                        NumberCircle(reading: reading)
                            .onTapGesture {
                                self.selectedReading = reading
                            }
                    
                    }
               }.sheet(item: self.$selectedReading) {
                ReadingDetail(reading: $0)
               }
                .padding(.horizontal, 30)
                .padding(.top, 30)
                .padding(.bottom, 30)
                Spacer()
            }
                
            }
            //.frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 200, alignment: .center)
        }.onAppear() {
            if readingOpened == false {
           findObjects()
            }
          }
    }
    
    func findObjects() {
        let query = PFQuery(className: "Readings")
        query.order(byAscending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                ////print(objects!.count)
                ////print("found readings")
                
                var newReadings: [Reading] = []
                for i in 0...objects!.count - 1 {
                    let object = objects![i]
                    let day = object["title"] as! String
                    //let subtitle = object["subtitle"] as? String ?? ""
                    let scripture = object["scripture"] as! String
                    let fullReading = object["fullReading"] as! String
                    let newReading = Reading(day: day, scripture: scripture, fullReading: fullReading)
                    newReadings.append(newReading)
                    if i == objects!.count - 1 {
                        readingArray.reading = newReadings
                        ////print("done")
                        readingOpened = true
                    }
                }
            } else {
                ////print("bummer")
            }
        }
    }
}

struct NumberCircle: View {
    var reading: Reading
    var body: some View {
        ZStack {
            Circle()
                .fill(reading.color)
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(reading.number)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .background(Color.clear)
        }
        
        
            
            
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
//
//struct ReadingView: View {
//    var id = UUID()
//    @ObservedObject var readingArray: ReadingArray
//    @State var showContent = false
//    @State var number = 6
//    @State private var selectedReading: Reading? = nil
//    var body: some View {
//          VStack {
//             HStack {
//                VStack(alignment: .leading) {
//                   Text("Reading Plan")
//                      .font(.largeTitle)
//                      .fontWeight(.heavy)
//
//                    Text("30 Days")
//                      .foregroundColor(.gray)
//                }.padding(.top, 20)
//                Spacer()
//             }
//             .padding(.leading, 60.0)
//
//             ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 10.0) {
//                    ForEach(readingArray.reading) { reading in
//                       Button(action: { self.showContent.toggle() }) {
//                          GeometryReader { geometry in
//                             ReadingRow(reading: reading)
//                                .rotation3DEffect(Angle(degrees:
//                                   Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
//                                .onTapGesture {
//                                    self.selectedReading = reading
//                                }
//                          }
//                          .frame(width: 246, height: 246)
//                       }
//                    }
//                }.sheet(item: self.$selectedReading) {
//                    ReadingDetail(reading: $0)
//                }
//                .padding(.leading, 30)
//                .padding(.top, 30)
//                .padding(.bottom, 30)
//                Spacer()
//             }
//             //CertificateRow()
//          }
//          .padding(.top, 38)
//          .onAppear() {
//            if readingOpened == false {
//           findObjects()
//            }
//          }
//
//    }
//    func findObjects() {
//        let query = PFQuery(className: "Readings")
//        query.order(byAscending: "createdAt")
//        query.findObjectsInBackground { (objects, error) in
//            if error == nil {
//                ////print(objects!.count)
//                ////print("found readings")
//
//                var newReadings: [Reading] = []
//                for i in 0...objects!.count - 1 {
//                    let object = objects![i]
//                    let day = object["title"] as! String
//                    //let subtitle = object["subtitle"] as? String ?? ""
//                    let scripture = object["scripture"] as! String
//                    let fullReading = object["fullReading"] as! String
//                    let newReading = Reading(day: day, scripture: scripture, fullReading: fullReading)
//                    newReadings.append(newReading)
//                    if i == objects!.count - 1 {
//                        readingArray.reading = newReadings
//                        ////print("done")
//                        readingOpened = true
//                    }
//                }
//            } else {
//                ////print("bummer")
//            }
//        }
//    }
// }
//
// #if DEBUG
// struct ReadingView_Previews: PreviewProvider {
//    static var previews: some View {
//       ReadingCalendar(readingArray: ReadingArray())
//    }
// }
// #endif
//
//
//struct ReadingRow: View {
//    var reading: Reading
//
//
//   var body: some View {
//    return HStack {
//        Spacer()
//        VStack(alignment: .leading) {
//            Text(reading.day)
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
//                .padding(30)
//                .lineLimit(4)
//                .frame(width: 246)
//
//            Text(reading.scripture)
//                .font(.headline)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//                .padding(.horizontal, 30)
//                .lineLimit(4)
//
//            Spacer()
//
//          }
//        .background(reading.color)
//          .cornerRadius(30)
//          .frame(width: 246, height: 246)
//        .shadow(color: reading.shadowColor, radius: 20, x: 0, y: 20)
//        Spacer()
//    }
//
//   }
//}


struct ReadingDetail: View {
    var reading: Reading

   var body: some View {
      return VStack(alignment: .leading) {
        Text(reading.day)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(30)
            .lineLimit(4)
        
        Text(reading.scripture)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .lineLimit(4)
        
        ScrollView(.vertical) {
        Text(reading.fullReading)
            .font(.subheadline)
            .fontWeight(.light)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
        }
        Spacer()

      }
      .background(reading.color)
      .shadow(color: reading.shadowColor, radius: 20, x: 0, y: 20)
   }
}

class ReadingArray: ObservableObject {

    let objectWillChange = PassthroughSubject<ReadingArray,Never>()

    var reading: [Reading] = [] {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
}

class Reading: Identifiable {

var id = UUID()
var day: String
//var subtitle: String
var scripture: String
var fullReading: String
var color: Color
var shadowColor: Color
    var number: String

    init (day: String, scripture: String, fullReading: String) {
    self.day = day
    //self.subtitle = subtitle
    self.scripture = scripture
        self.fullReading = fullReading
        let randomInt = Int.random(in: 0...7)
        self.color = CalendarTheme.allThemes[randomInt].primary
        self.shadowColor = CalendarTheme.allThemes[randomInt].primary.opacity(0.5)
        self.number = day.deletingPrefix("Day ")
}
}

struct CircleButton: View {

   var icon = "person.crop.circle"

   var body: some View {
      return HStack {
         Image(systemName: icon)
            .foregroundColor(.primary)
      }
      .frame(width: 44, height: 44)
      .background(Color("button"))
      .cornerRadius(30)
      .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
   }
}

struct MenuRight: View {
    @State var mailInfo: MailInfo = MailInfo()
   @Binding var show: Bool
    @State var showBio = false
   @State var showBookings = false

   var body: some View {
      return ZStack(alignment: .topTrailing) {
         HStack {
            Button(action: { self.showBio.toggle() }) {
               CircleButton(icon: "info.circle")
            }
            .sheet(isPresented: self.$showBio) {
              //UpdateList()
              BioView()
            }
            
            if idiom == .pad {
                Button(action: { self.showBookings.toggle() }) {
                   CircleButton(icon: "calendar.badge.plus")
                    .fullScreenCover(isPresented: self.$showBookings, content: {
                        RequestCalendarView(ascRequests: NewRequest.adds(start: Date(), end: Date().advanced(by: 86400*365)), initialMonth: nil)
                    })
                }
            } else {
                Button(action: { self.showBookings.toggle() }) {
                   CircleButton(icon: "calendar.badge.plus")
                      .sheet(isPresented: self.$showBookings) {
                        RequestCalendarView(ascRequests: NewRequest.adds(start: Date(), end: Date().advanced(by: 86400*365)), initialMonth: nil)
                        
                      }
                }
            }
         }
         Spacer()
      }
   }
}


