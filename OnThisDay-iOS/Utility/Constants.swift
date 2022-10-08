// Project: OnThisDay-iOS
//
//  
//

import Foundation

struct DateParts {
    /// English month names
    /// Calendar can provide `monthSymbols` but they might not have been in English which the API requires
    static var englishMonthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ]
      
    /// Days per month, based on english month names
    static func daysPerMonth(_ month: String) -> Int {
      switch month {
      case "February":
          return 29
      case "April", "June", "September", "Novenber":
          return 30
      default:
          return 31
      }
    }
}
