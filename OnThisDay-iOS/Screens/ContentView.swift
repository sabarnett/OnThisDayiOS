// Project: OnThisDay-iOS
//
//  
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedEvent: Event?  // = Event.sampleEvent
    
    var body: some View {
        NavigationView {
            EventListView(selectedEvent: $selectedEvent)
            
            EventDetailView(event: $selectedEvent)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    @StateObject static var appState = AppState(isPreview: true)

    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(appState)
    }
}
