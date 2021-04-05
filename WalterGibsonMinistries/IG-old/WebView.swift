//
//  WebView.swift
//  WalterGibsonMinistries
//
//  Created by Christian Gibson on 3/3/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    //MARK:- Member variables
    @Binding var presentAuth: Bool
    @Binding var testUserData: InstagramTestUser
    @Binding var instagramApi: InstagramApi
    
    
    //MARK:- UIViewRepresentable Delegate Methods
    func makeCoordinator() -> WebView.Coordinator {
        return Coordinator(parent: self)
        
    }
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        // return a webView object
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
        
    }
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        //authorize the app
        instagramApi.authorizeApp { (url) in
            DispatchQueue.main.async {
                webView.load(URLRequest(url: url!))
                
            }
            
        }
    }
    
    //MARK:- Coordinator class
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        init(parent: WebView) {  self.parent = parent  }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // get instagram test user token and id
            let request = navigationAction.request
            self.parent.instagramApi.getTestUserIDAndToken(request: request) { (instagramTestUser) in
                self.parent.testUserData = instagramTestUser
                self.parent.presentAuth = false
                
            }
            
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
    
    
}


