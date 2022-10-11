// Project: OnThisDay-iOS
//
//  Defines the popup button content for a dismiss button on a popup sheet.
//

import SwiftUI

struct PopupDismissButton: View {
    var body: some View {
        Image(systemName: "x.circle.fill")
            .font(Font.body.weight(.bold))
            .foregroundColor(.primary)
            .frame(width: 44, height: 44)
            .scaleEffect(1.5)
    }
}

struct PopupDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        PopupDismissButton()
            .previewLayout(.sizeThatFits)
    }
}
