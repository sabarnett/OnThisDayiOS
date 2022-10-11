// Project: OnThisDay-iOS
//
//  This is the home view that controlls everything else. It presents the
//  event list on the left and the event detail on the right.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedEvent: Event?
    
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
