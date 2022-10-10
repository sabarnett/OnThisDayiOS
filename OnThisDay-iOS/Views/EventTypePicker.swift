// Project: OnThisDay-iOS
//
//  
//

import SwiftUI

struct EventTypePicker: View {
    
    @EnvironmentObject var appState: AppState
    
    @SceneStorage("eventDate") var eventDate = ""

    @Binding var selectedEventType: EventType
    
    var body: some View {
        Picker(
            selection: $selectedEventType,
            content: {
                ForEach(EventType.allCases, id: \.rawValue) { event in
                    Button(action: {}, label: {
                        Text(buttonCaption(for: event))
                    }).tag(event)
                }
            },
            label: {
                Text("Select an event type")
            }
        ).pickerStyle(.segmented)
    }
    
    func buttonCaption(for event: EventType) -> String {
        let baseLabel = "\(event.rawValue)"
        let count = eventCount(for: event)
        
        if count == 0 {
            return baseLabel
        }
        return "\(baseLabel): \(eventCount(for: event))"
    }
    
    func eventCount(for event: EventType) -> Int {
        appState.countFor(eventType: event, date: eventDate == "" ? nil : eventDate)
    }
}

struct EventTypePicker_Previews: PreviewProvider {
    
    @StateObject static var appState = AppState(isPreview: true)

    static var previews: some View {
        EventTypePicker(selectedEventType: .constant(.events))
            .environmentObject(appState)
    }
}
