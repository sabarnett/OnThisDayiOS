// Project: OnThisDay-iOS
//
//  
//

import SwiftUI

struct EventTypePicker: View {
    
    @EnvironmentObject var appState: AppState
    
    @AppStorage("ShowBirths") var showBirths: Bool = true
    @AppStorage("ShowDeaths") var showDeaths: Bool = true
    @AppStorage("ShowTotals") var showTotals: Bool = true

    @SceneStorage("eventDate") var eventDate = ""

    @Binding var selectedEventType: EventType
    
    var allowedEventTypes: [EventType] {
        EventType.allCases.filter({ event in
            if event == .births && !showBirths { return false }
            if event == .deaths && !showDeaths { return false }
            return true
        })
    }
    
    var body: some View {
        Picker(
            selection: $selectedEventType,
            content: {
                ForEach(allowedEventTypes, id: \.rawValue) { event in
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
        
        if count == 0 || !showTotals {
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
