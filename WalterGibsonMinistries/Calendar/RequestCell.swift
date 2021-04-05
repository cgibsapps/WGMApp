//
//  RequestCell.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/8/21.
//

import SwiftUI
import ElegantCalendar
import iPhoneNumberField

struct RequestCell: View {
    
    let request: Request

    var body: some View {
        HStack {
            tagView

            VStack(alignment: .leading) {
                locationName
                requestDuration
            }

            Spacer()
        }
        .frame(height: RequestPreviewConstants.cellHeight)
        .padding(.vertical, RequestPreviewConstants.cellPadding)
    }

}

private extension RequestCell {

    var tagView: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(request.tagColor)
            .frame(width: 5, height: 30)
    }

    var locationName: some View {
        Text(request.locationName)
            .font(.system(size: 16))
            .lineLimit(1)
    }

    var requestDuration: some View {
        Text(request.duration)
            .font(.system(size: 10))
            .lineLimit(1)
    }

}

//struct RequestCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DarkThemePreview {
//            RequestCell(request: .mock(withDate: Date()))
//        }
//    }
//}


struct RequestPreviewConstants {

    static let cellHeight: CGFloat = 30
    static let cellPadding: CGFloat = 10

    static let previewTime: TimeInterval = 3

}


struct RequestButton: View {
    var textColor: Color = CalendarTheme.royalBlue.primary
    @State var showForm: Bool = false
    var selectedDate: Date
    var body: some View {
        Button(action: {
            self.showForm = true
        }, label: {
            Text("Submit Request")
                .foregroundColor(textColor)
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
            
        }).sheet(isPresented: self.$showForm, content: {
            RequestForm(selectedDate: selectedDate)
        })
    }
}



struct RequestForm: View {
    @State var email: String = ""
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var description: String = ""
    @State var selectedType = "Prayer"
    @State var types = ["Prayer", "Event", "Counseling"]
    var selectedDate: Date
    
    init(selectedDate: Date){
        self.selectedDate = selectedDate
            UITableView.appearance().backgroundColor = .clear
        }
    
    var body: some View {
        NavigationView {
            ZStack {
                CalendarTheme.royalBlue.primary.opacity(0.8).edgesIgnoringSafeArea(.all)
                Form {
                    Section(header: Text(selectedDate.partialDate)
                                .foregroundColor(Color.white)) {
                        
                    }
                    
                    Section(header: Text("ABOUT YOU")
                                .foregroundColor(Color.white)) {
                        
                        TextField("Email", text: self.$email)
                            .font(Font.custom("HelveticaNeue-Light", size: 16))
                        TextField("Name", text: self.$name)
                            .font(Font.custom("HelveticaNeue-Light", size: 16))
                        iPhoneNumberField(text: self.$phoneNumber)
                            .font(Font.custom("HelveticaNeue-Light", size: 16))
                    }
                    Section(header: Text("ABOUT REQUEST")
                                .foregroundColor(Color.white)) {
                        Picker("Select a type", selection: self.$selectedType) {
                            ForEach(types, id: \.self) {
                                Text($0)
                                    .font(Font.custom("HelveticaNeue-Medium", size: 13))
                            }
                        }
                        TextField("Brief Description", text: self.$description)
                        
                    }
                    
                    Section {
                        MailContainer(email: self.$email, name: self.$name, phoneNumber: self.$phoneNumber, description: self.$description, selectedType: self.$selectedType, selectedDate: self.selectedDate, prompt: "Send")
                    }
                }.navigationBarTitle("Request Information")
                //.background(CalendarTheme.royalBlue.primary)
            }
        }
    }
    
    func setValues(about: String, from: String, body: String) {
        subject = about
        fromAddress = from
        messageBody = body
        
    }
}

struct RequestForm_Previews: PreviewProvider {
    static var previews: some View {
        //DarkThemePreview {
            RequestForm(selectedDate: Date())
        //}
        
    }
}

var subject: String = ""
var fromAddress: String = ""
var messageBody: String = ""
