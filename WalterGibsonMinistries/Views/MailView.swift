//
//  MailView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/4/21.
//

import SwiftUI
import MessageUI
import ElegantCalendar

struct MailContainer: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @Binding var email: String
    @Binding var name: String
    @Binding var phoneNumber: String
    @Binding var description: String
    @Binding var selectedType: String
    var selectedDate: Date
    var prompt: String
    
    var body: some View {
            Button(action: {
                self.isShowingMailView.toggle()
            }) {
                Text(prompt)
                    .foregroundColor(CalendarTheme.royalBlue.primary)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            .disabled(!MFMailComposeViewController.canSendMail())
            .sheet(isPresented: $isShowingMailView) {
                MailView(email: self.$email, name: self.$name, phoneNumber: self.$phoneNumber, description: self.$description, selectedType: self.$selectedType, selectedDate: self.selectedDate, result: self.$result)
            }
        }
}

//struct MailContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        MailContainer(prompt: "Send email", mailInfo: <#Binding<MailInfo>#>)
//    }
//}

struct MailView: UIViewControllerRepresentable {
    @Binding var email: String
    @Binding var name: String
    @Binding var phoneNumber: String
    @Binding var description: String
    @Binding var selectedType: String
    var selectedDate: Date
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        
        vc.setSubject("\(self.selectedType) Request - \(self.selectedDate.fullDate)")
        //vc.setPreferredSendingEmailAddress(self.mailInfo.email)
        vc.setToRecipients(["wgibsonministries@gmail.com"])
        vc.setMessageBody( "Name: \(self.name) \n Email: \(self.email) \n Phone Number: \(self.phoneNumber) \n Type: \(self.selectedType) request \n Selected Date: \(self.selectedDate.fullDate) \n Description: \(self.description)", isHTML: false)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }
    
    

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}

class MailInfo {
    var email: String
    var name: String
    var phoneNumber: String
    var description: String
    var selectedType: String
    var body: String
    var selectedDate: Date = Date()
    
    init(email: String, name: String, phoneNumber: String, description: String, selectedType: String, body: String) {
        self.email = email
        self.name = name
        self.phoneNumber = phoneNumber
        self.description = description
        self.selectedType = selectedType
        self.body = body
    }
    
    init(email: String, name: String, phoneNumber: String, description: String, selectedType: String, body: String, date: Date) {
        self.email = email
        self.name = name
        self.phoneNumber = phoneNumber
        self.description = description
        self.selectedType = selectedType
        self.body = body
        self.selectedDate = date
    }
    
    init() {
        self.email = ""
        self.name = ""
        self.phoneNumber = ""
        self.description = ""
        self.selectedType = ""
        self.body = ""
    }
}
