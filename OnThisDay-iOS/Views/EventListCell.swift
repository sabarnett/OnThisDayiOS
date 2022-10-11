// Project: OnThisDay-iOS
//
//  Defines the content of an individual event when displayed in the list of
//  events. 
//

import SwiftUI

struct EventListCell: View {
    
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.year)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.yearColor)
            Text(event.text)
                .multilineTextAlignment(.leading)
                .font(.caption)
                .lineLimit(3)
                .foregroundColor(Color.listItemColor)
        }
    }
}

struct EventListCell_Previews: PreviewProvider {
    static var previews: some View {
        EventListCell(event: Event.sampleEvent)
            .previewLayout(.sizeThatFits)
    }
}
