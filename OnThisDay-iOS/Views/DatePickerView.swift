// Project: OnThisDay-iOS
//
//  Displays a popup window that the user can use to select the date to be displayed
//  in the event list. In addition to selecting a new date, we retain a list of the
//  previously selected dates, so the user can re-select one that they have already
//  fetched.
//

import SwiftUI

struct DatePickerView: View {
    
    @EnvironmentObject var appState: AppState
    
    @SceneStorage("eventDate") var eventDate = ""
    
    @Binding var pickerShown: Bool
    
    @State var selectedMonth: String = "January"
    @State var selectedDay: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Month: ")
                Picker(selection: $selectedMonth, content: {
                    ForEach(DateParts.englishMonthNames, id: \.self) { name in
                        Text(name).tag(name)
                    }
                }, label: {
                    Text("Select a month")
                })
                .pickerStyle(.menu)
                
                Text("Day: ")
                Picker(selection: $selectedDay, content: {
                    ForEach(1...DateParts.daysPerMonth(selectedMonth), id: \.self) { day in
                        Text("\(day)").tag(day)
                    }
                }, label: {
                    Text("Select a Day")
                })
                .pickerStyle(.menu)
                
                Button("Go") {
                    // Set the date selection
                    eventDate = "\(selectedMonth) \(selectedDay)"
                    
                    // Hide the popup
                    pickerShown = false
                }.buttonStyle(.bordered)
                    .tint(.green)
            }
            .padding()
            
            List(appState.sortedDates, id: \.self) { date in
                Text(date)
                    .onTapGesture {
                        eventDate = date
                        pickerShown = false
                    }
            }
            .listStyle(.plain)
            .frame(height: 120)
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    
    @StateObject static var appState = AppState(isPreview: true)
    
    static var previews: some View {
        DatePickerView(pickerShown: .constant(true))
            .environmentObject(appState)
            .previewLayout(.sizeThatFits)
    }
}
