//
//  ContentView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/2/21.
//

import SwiftUI
import Parse
import Combine
import Foundation

var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
var gridItemLayout = [GridItem(.flexible())]

var outline1 = Outline(title: title1, headline: date1, summary: scripture1, fullText: note1)
var outline2 = Outline(title: title2, headline: date2, summary: scripture2, fullText: note2)
var outlines = [outline1, outline2]


class OutlineArray: ObservableObject {

    let objectWillChange = PassthroughSubject<OutlineArray,Never>()

    var outlines = [outline1, outline2] {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
}


struct BioLink: View {
    @State var showBio = false
    var body: some View {
        Button(action: {self.showBio.toggle()}, label: {
            Image("information-50")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45, alignment: .center)
        }).sheet(isPresented: self.$showBio) {
            BioView()
            
        }
    }
}

struct BackgroundImage: View {
    var body: some View {
        Image(uiImage: UIImage(named: "WGPic-Cropped")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct OutlineContainer: View {
    var outline: Outline
    var body: some View {
        VStack(alignment: .center) {
            Text(outline.title)
                .font(.title)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 15)
            Text(outline.headline)
                .font(.headline)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .padding(.vertical, 10)
            ScrollView(.vertical) {
            Text(outline.summary)
                .font(.subheadline)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            }
        }.frame(width: UIScreen.main.bounds.width * 0.70, height: UIScreen.main.bounds.height * 0.50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .padding(.horizontal, 5)
    }
}


