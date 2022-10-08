// Project: OnThisDay-iOS

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

final class WebViewModel: ObservableObject {
    @Published var urlString = "about:blank"
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
    }
    
    func loadUrl() {
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func back() {
        webView.goBack()
    }

    func forward() {
        webView.goForward()
    }
}
