// Project: OnThisDay-iOS
//
//  Allows the user to set the app options. This currently allows them to
//  determine whether Births and Deaths are to be displayed and whether we
//  include the count of the items for a specific view in the event type
//  selector.
//

import SwiftUI

struct OptionsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("ShowBirths") var showBirths: Bool = true
    @AppStorage("ShowDeaths") var showDeaths: Bool = true
    @AppStorage("ShowTotals") var showTotals: Bool = true
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Event Types").bold()) {
                    HStack {
                        Toggle(isOn: $showBirths, label: {
                            Text("Show Birthday Items")
                        })
                    }
                    HStack {
                        Toggle(isOn: $showDeaths, label: {
                            Text("Show Death Items")
                        })
                    }
                }
                
                Section(header: Text("Totals").bold()) {
                    HStack {
                        Toggle(isOn: $showTotals, label: {
                            Text("Show Event Counts")
                        })
                    }
                }
                
                Section(header: Text("About On This Day").bold()) {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Image("LaunchScreenLogo")
                                .resizable()
                                .frame(width: 200, height: 200)
                            Text("On This Day.").font(.title)
                            Text("by").font(.caption)
                            Text("Steve Barnett").font(.title2)
                        }.padding(.vertical, 15)
                        Spacer()
                    }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                PopupDismissButton()
            }
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
            .previewLayout(.sizeThatFits)
    }
}
