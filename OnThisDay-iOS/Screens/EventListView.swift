// Project: OnThisDay-iOS
//
//  Presents the user with a list of the events for the selected date, limited
//  to the specific event type.
//

import SwiftUI

struct EventListView: View {
    
    @EnvironmentObject var appState: AppState
    
    @SceneStorage("eventDate") var eventDate = ""

    @State private var selectedEventType: EventType = .events
    @State private var showDatePicker: Bool = false
    @State private var showOptions: Bool = false
    @State private var selectedRow: UUID?
    
    @Binding var selectedEvent: Event?
    
    var selectionDate: String? {
        eventDate == "" ? nil : eventDate
    }
    
    /// Returns the events that match the specific event type that is currently selected. If we are still
    /// loading the events, then we also clear the currently selected event and the currently selected
    /// row. This will force clear the details pane and the row highlight.
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
            
            // If loading, present a loading placeholder. Otherwise, present
            // the list of events.
            if appState.isLoading {
                LoadingPlaceholder()
            } else {
                List(events, selection: $selectedRow) { event in
                    EventListCell(event: event)
                        .onTapGesture {
                            selectedRow = event.id
                            selectedEvent = event
                        }
                        .listRowBackground(self.selectedRow == event.id
                                           ? Color(.systemBlue).opacity(0.5)
                                           : Color(.systemBackground))
                }.listStyle(.plain)
            }
        }
        .navigationBarTitle(selectionDate ?? appState.today)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(trailing: toolbarTrailingItems())
        .onChange(of: eventDate, perform: { date in
            selectedRow = nil
            selectedEvent = nil
        })
    }
    
    fileprivate func LoadingPlaceholder() -> some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(2)
                .padding(.bottom, 15)
            Text("Loading historical information")
            Spacer()
        }
    }
    
    fileprivate func toolbarTrailingItems() -> some View {
        HStack(spacing: 15) {
            Button {
                showDatePicker = true
            } label: {
                Image(systemName: "calendar")
                    .scaleEffect(1.3)
            }
            .popover(isPresented: $showDatePicker, arrowEdge: .top) {
                DatePickerView(pickerShown: $showDatePicker)
                    .frame(minWidth: 360, idealWidth: 380, maxWidth: 480, minHeight: 200, idealHeight: 200, maxHeight: 220)
            }
            
            Button {
                showOptions = true
            } label: {
                Image(systemName: "gearshape")
                    .scaleEffect(1.3)
            }
            .sheet(isPresented: $showOptions) {
                OptionsView()
            }
        }
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
