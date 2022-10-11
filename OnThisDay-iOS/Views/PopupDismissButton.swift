// Project: OnThisDay-iOS
//
//  
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
