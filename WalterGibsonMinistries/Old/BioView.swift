//
//  BioView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/2/21.
//

import SwiftUI

struct BioView: View {
    var body: some View {
        
        if idiom == .pad {
                        
            iPadBioView()
            
                } else {
        ZStack {
            Color.clear
            ScrollView(.vertical) {
                Text(bio)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.55, alignment: .center)
            .padding(.top, UIScreen.main.bounds.width * 0.5490966222)
        
        }.background(
            Image(uiImage: UIImage(named: "WGPic-Cropped")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/),
                     alignment: .top)
        .padding(.top, -60)
                }
        }
    }


struct iPadBioView: View {
    var body: some View {
        ZStack {
            Color.clear
            ScrollView(.vertical) {
                Text(bio)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            .frame(height: UIScreen.main.bounds.height * 0.55, alignment: .center)
            .padding(.top, UIScreen.main.bounds.width * 0.6)
            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        
        }.background(
            Image(uiImage: UIImage(named: "WGPic-Cropped")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/),
                     alignment: .top)
        .padding(.top, 20)
    }
}
