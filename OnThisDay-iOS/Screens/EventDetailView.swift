// Project: OnThisDay-iOS
//
//  Displays the details of an event. We have some basic text, including the year
//  and a description of the event. Following that, we have a series of buttons
//  that will lead to web links. Below that, we have a web view that we display the
//  web content in.
//

import SwiftUI

struct EventDetailView: View {
    
    @EnvironmentObject var appState: AppState
    
    @SceneStorage("eventDate") var eventDate = ""
    
    @Binding var event: Event?
    
    @StateObject private var model = WebViewModel()
    
    var evt: Event { event! }
    var selectionDate: String? { eventDate == "" ? nil : eventDate }
    
    var body: some View {
        if event == nil {
            Text("Select an event from the list")
        } else {
            VStack (alignment: .leading) {
                Text(evt.text)
                    .font(.body)
                    .foregroundColor(Color.listItemColor)
                
                ScrollView {
                    HStack {
                        ForEach(evt.links) { link in
                            Button("\(link.title)  ") {
                                model.urlString = link.url.absoluteString
                                model.loadUrl()
                            }
                            .buttonStyle(.bordered)
                            .tint(.blue)
                        }
                    }
                }
               .frame(height: 50)
                
                WebView(webView: model.webView)
                HStack {
                    Button(action: {model.back()},
                           label: { Image(systemName: "arrow.backward")})
                    Button(action: {model.forward()},
                           label: { Image(systemName: "arrow.forward")})

                    TextField("URL", text: $model.urlString)
                        .textFieldStyle(.roundedBorder)
                    Button("Go") {
                        model.loadUrl()
                    }
                }.padding()

            }.frame(
                minWidth: 0, maxWidth: .infinity,
                minHeight: 0, maxHeight: .infinity,
                alignment: .topLeading
            )
            .navigationBarTitle("\(evt.year)")
            .navigationBarTitleDisplayMode(.large)
            .onChange(of: event, perform: {newValue in
                if let url = evt.links.first?.url {
                    model.urlString = url.absoluteString
                    model.loadUrl()
                }
            })
            .onAppear {
                if let url = evt.links.first?.url {
                    model.urlString = url.absoluteString
                    model.loadUrl()
                }
            }
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    
    @StateObject static var appState = AppState(isPreview: true)
    
    @State static var event: Event? = Event.sampleEvent
    
    static var previews: some View {
        EventDetailView(event: $event)
            .environmentObject(appState)
    }
}
