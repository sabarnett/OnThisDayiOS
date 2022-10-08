// Project: OnThisDay-iOS
//
//  
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
                Picker(selection: $selectedMonth, content: {
                    ForEach(DateParts.englishMonthNames, id: \.self) { name in
                        Text(name).tag(name)
                    }
                }, label: {Text("Select a month")})
                .pickerStyle(.menu)
                .padding(.horizontal, 10)
                .foregroundColor(.primary)
                .border(.secondary, width: 1)
                
                Picker(selection: $selectedDay, content: {
                    ForEach(1...DateParts.daysPerMonth(selectedMonth), id: \.self) { day in
                        Text("\(day)").tag(day)
                    }
                }, label: {Text("Select a Day")})
                .pickerStyle(.menu)
                .padding(.horizontal, 10)
                .foregroundColor(.primary)
                .border(.secondary, width: 1)

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
