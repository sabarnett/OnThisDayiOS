// Project: OnThisDay-iOS
//
//  
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("About the App").bold()) {
                    AboutLineView(name: "Name", value: "On This Day")
                    AboutLineView(name: "Version", value: Bundle.main.releaseAndBuildVersionNumberPretty)
                    AboutLineView(name: "Author", value: "Steven Barnett")
                }
                Section(header: Text("Support").bold()) {
                    AboutLineView(name: "Web", value: "http://www.sabarnett.co.uk")
                    AboutLineView(name: "Email", value: "mac@sabarnett.co.uk")
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Image("LaunchScreenLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150, alignment: .center)
                            .opacity(0.6)
                        Text("Copyright (c) 2022 Steven Barnett")
                            .font(.callout)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {  presentationMode.wrappedValue.dismiss() }
        label: { PopupDismissButton() }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}


struct AboutLineView: View {
    
    let name: String
    let value: String
    
    var body: some View {
        HStack {
            Text(name).foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
}
