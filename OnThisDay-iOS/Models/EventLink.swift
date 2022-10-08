// Project: OnThisDay-iOS
//
//  
//

import Foundation

struct EventLink: Decodable, Identifiable {
  let id: UUID
  let title: String
  let url: URL
}
