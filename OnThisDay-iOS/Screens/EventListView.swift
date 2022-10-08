
import SwiftUI

struct EventListView: View {
    
    @EnvironmentObject var appState: AppState
    
    @SceneStorage("eventDate") var eventDate = ""
    
    @State private var selectedEventType: EventType = .events
    @State private var showDatePicker: Bool = false
    @State private var selectedRow: UUID?
    
    @Binding var selectedEvent: Event?
    
    var selectionDate: String? {
        eventDate == "" ? nil : eventDate
    }
    
    var events: [Event] {
        if appState.isLoading {
            selectedEvent = nil
            selectedRow = nil
        }
        return appState.dataFor(eventType: selectedEventType,
                         date: selectionDate)
    }
    
    var body: some View {
        VStack {
            // Segmented control
            EventTypePicker(selectedEventType: $selectedEventType)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            if appState.isLoading {
                Spacer()
                ProgressView()
                    .scaleEffect(2)
                    .padding(.bottom, 15)
                Text("Loading historical information")
                Spacer()
            } else {
                List(events, selection: $selectedRow) { event in
                    EventListCell(event: event)
                        .onTapGesture {
                            selectedRow = event.id
                            selectedEvent = event
                        }
                        .listRowBackground(self.selectedRow == event.id
                                           ? Color(.systemGroupedBackground)
                                           : Color(.systemBackground))
                }.listStyle(.plain)
                                  
            }
        }
        .navigationBarTitle(selectionDate ?? appState.today)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(
            trailing:
                HStack(spacing: 15) {
                    Button {
                        showDatePicker = true
                    } label: {
                        Image(systemName: "calendar")
                            .scaleEffect(1.3)
                    }
                    .popover(isPresented: $showDatePicker, arrowEdge: .top) {
                        DatePickerView(pickerShown: $showDatePicker)
                            .frame(minWidth: 260, idealWidth: 280, maxWidth: 280, minHeight: 200, idealHeight: 200, maxHeight: 220)
                    }
                })
        .onChange(of: eventDate, perform: { date in
            selectedRow = nil
            selectedEvent = nil
        })
    }
}

struct EventListView_Previews: PreviewProvider {

    @StateObject static var appState = AppState(isPreview: true)
    @State static var sample: Event? = Event.sampleEvent

    static var previews: some View {
        EventListView(selectedEvent: $sample)
            .environmentObject(appState)
    }
}
