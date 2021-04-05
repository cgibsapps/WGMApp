//
//  OutlineList.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/3/21.
//

import SwiftUI
import Parse
import ElegantCalendar

var outlineOpened = false
struct OutlineList: View {
    @ObservedObject var outlineArray: OutlineArray
    @State var showContent = false
    @State var number = 6
    @State private var selectedOultine: Outline? = nil
    var body: some View {
          VStack {
             HStack {
                VStack(alignment: .leading) {
                   Text("Latest Outlines")
                      .font(.largeTitle)
                      .fontWeight(.heavy)

                }
                Spacer()
             }
             .padding(.leading, 60.0)

             ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10.0) {
                    ForEach(outlineArray.outlines) { outline in
                       Button(action: { self.showContent.toggle() }) {
                          GeometryReader { geometry in
                             OutlineRow(outline: outline)
                                .rotation3DEffect(Angle(degrees:
                                   Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                .onTapGesture {
                                    self.selectedOultine = outline
                                }
                          }
                          .frame(width: 246, height: 360)
                       }
                    }
                }.sheet(item: self.$selectedOultine) {
                    OutlineDetail(outline: $0)
                }
                .padding(.leading, 30)
                .padding(.top, 30)
                .padding(.bottom, 70)
                Spacer()
             }
             //CertificateRow()
          }
          .padding(.top, 78)
          .onAppear() {
            if outlineOpened == false {
           findObjects()
            }
          }
       
    }
    func findObjects() {
        let query = PFQuery(className: "Outline")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                ////print(objects!.count)
                ////print("found items")
                
                var newOutlines: [Outline] = []
                for i in 0...objects!.count - 1 {
                    let object = objects![i]
                    let title = object["title"] as! String
                    let date = object["date"] as! String
                    let scripture = object["scripture"] as! String
                    let note = object["note"] as! String
                    
                    let newOutline = Outline(title: title, headline: date, summary: scripture, fullText: note)
                    newOutlines.append(newOutline)
                    if i == objects!.count - 1 {
                        outlineArray.outlines = newOutlines
                    }
                }
            }
        }
    }
 }

struct OutlineDetailList: View {
    @State var mailInfo: MailInfo = MailInfo()
    @ObservedObject var outlineArray: OutlineArray
    @State var showContent = false
    @State var number = 6
    @State private var selectedOultine: Outline? = nil
    var body: some View {
          VStack {
             HStack {
                VStack(alignment: .leading) {
                   Text("Outlines")
                      .font(.largeTitle)
                      .fontWeight(.heavy)

                }.padding(.top, 20)
                Spacer()
             }
             .padding(.leading, 60.0)

             ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10.0) {
                    ForEach(outlineArray.outlines) { outline in
                       Button(action: { self.showContent.toggle() }) {
                          GeometryReader { geometry in
                             OutlineRow(outline: outline)
                                .rotation3DEffect(Angle(degrees:
                                   Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                .onTapGesture {
                                    self.selectedOultine = outline
                                }
                          }
                          .frame(width: 246, height: 360)
                       }
                    }
                }.sheet(item: self.$selectedOultine) {
                    OutlineDetail(outline: $0)
                }
                .padding(.leading, 30)
                .padding(.top, 30)
                .padding(.bottom, 70)
                Spacer()
             }
          }
          .padding(.top, 78)
          .onAppear() {
            if outlineOpened == false {
           findObjects()
            }
          }
       
    }
    func findObjects() {
        let query = PFQuery(className: "Outline")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                ////print(objects!.count)
                ////print("found items")
                
                var newOutlines: [Outline] = []
                for i in 0...objects!.count - 1 {
                    let object = objects![i]
                    let title = object["title"] as! String
                    let date = object["date"] as! String
                    let scripture = object["scripture"] as! String
                    let note = object["note"] as! String
                    
                    let newOutline = Outline(title: title, headline: date, summary: scripture, fullText: note)
                    newOutlines.append(newOutline)
                    if i == objects!.count - 1 {
                        outlineArray.outlines = newOutlines
                        ////print("done")
                    }
                }
            } else {
                ////print("bummer")
            }
        }
    }
 }

struct OutlineRow: View {
    var outline: Outline
   

   var body: some View {
      return VStack(alignment: .leading) {
        Text(outline.title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .lineLimit(4)
            .padding(30)
            
        
        Text(outline.headline)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .lineLimit(4)
            .padding(.horizontal, 30)
            
        
        Text(outline.summary)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .lineLimit(4)
            .padding(.top, 10)
            .padding(.horizontal, 30)
            
        
        Spacer()

      }
      .background(outline.color)
      .cornerRadius(30)
      .frame(width: 246, height: 360)
      .shadow(color: outline.shadowColor, radius: 20, x: 0, y: 20)
   }
}

struct OutlineDetail: View {
    var outline: Outline

   var body: some View {
      return VStack(alignment: .leading) {
        Text(outline.title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(30)
            .lineLimit(4)

        Text(outline.headline)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .lineLimit(4)
        
        ScrollView(.vertical) {
        Text(outline.fullText)
            .font(.subheadline)
            .fontWeight(.light)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
        }
        Spacer()

      }
      .background(outline.color)
      .shadow(color: outline.shadowColor, radius: 20, x: 0, y: 20)
   }
}

class Outline: Identifiable {
    
    var id = UUID()
    var title: String
    var headline: String
    var summary: String
    var fullText: String
    var color: Color
    var shadowColor: Color
    
    init (title: String, headline: String, summary: String, fullText: String) {
        self.title = title
        self.headline = headline
        self.summary = summary
        self.fullText = fullText
        let randomInt = Int.random(in: 0...7)
        self.color = CalendarTheme.allThemes[randomInt].primary
        self.shadowColor = CalendarTheme.allThemes[randomInt].primary.opacity(0.5)
    }
}



struct OutlineList_Previews: PreviewProvider {
    static var previews: some View {
        OutlineList(outlineArray: OutlineArray())
    }
}
