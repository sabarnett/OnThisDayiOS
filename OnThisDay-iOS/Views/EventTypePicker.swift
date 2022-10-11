// Project: OnThisDay-iOS
//
//  Responsible for the display of the segmented control that the user uses to
//  select which type of event they want displayed. There are system options
//  that allow the user to disable some of the buttons. This is handled here.
//
//  Also, when displaying an item in the segmented control, we have the option
//  to display a count of the items for that event type.
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
    
    /// Sets the caption text for a specific event type in the segmented control
    /// - Parameter event: The event to be displayed
    /// - Returns: The caption text, customisewd to include or exclude the count of matching items
    func buttonCaption(for event: EventType) -> String {
        let baseLabel = "\(event.rawValue)"
        let count = eventCount(for: event)
        
        if count == 0 || !showTotals {
            return baseLabel
        }
        return "\(baseLabel): \(eventCount(for: event))"
    }
    
    /// Returns the count of the matching items for a specific event type.
    /// - Parameter event: The event that we want the count for
    /// - Returns: The number of items in this event.
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
