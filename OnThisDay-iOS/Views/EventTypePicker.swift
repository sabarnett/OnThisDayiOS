// Project: OnThisDay-iOS
//
//  
//

import SwiftUI

struct EventTypePicker: View {
    
    @Binding var selectedEventType: EventType
    
    var body: some View {
        Picker(
            selection: $selectedEventType,
            content: {
                ForEach(EventType.allCases, id: \.rawValue) { event in 
                    Button(event.rawValue) {
                        // TODO: Change the data displayed
                    }.tag(event)
                }
            },
            label: {
                Text("Select an event type")
            }
        ).pickerStyle(.segmented)
    }
}

struct EventTypePicker_Previews: PreviewProvider {
    static var previews: some View {
        EventTypePicker(selectedEventType: .constant(.events))
    }
}
