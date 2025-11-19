import SwiftUI
import WebKit

struct JSWebView: UIViewRepresentable {
    let htmlContent: String
    let library: JSLibrary
    @Binding var swiftToJSMessage: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let contentController = WKUserContentController()
        contentController.add(context.coordinator, name: "swiftHandler")
        configuration.userContentController = contentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.bounces = true
        webView.isInspectable = true
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if webView.url == nil {
            webView.loadHTMLString(htmlContent, baseURL: URL(string: "https://localhost"))
        }
        
        if let message = swiftToJSMessage, !message.isEmpty {
            webView.evaluateJavaScript("handleSwiftMessage('\(message)')")
        }
    }
    
    class Coordinator: NSObject, WKScriptMessageHandler {
        var parent: JSWebView
        
        init(_ parent: JSWebView) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "swiftHandler", let body = message.body as? String {
                print("📱 JavaScript → Swift: \\(body)")
            }
        }
    }
}
