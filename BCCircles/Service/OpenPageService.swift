

import SafariServices


final class OpenPage {
    
    func openWebView() {
        if let url = URL(string: "https://www.privacypolicies.com/live/f08fb0ff-0559-4723-8a3c-b108b81510f9") {
            let safariViewController = SFSafariViewController(url: url)

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(safariViewController, animated: true, completion: nil)
            }
        }
    }
}
