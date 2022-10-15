// Project: OnThisDay-iOS
//
// Helper extension to give human readable version numbers.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v \(releaseVersionNumber ?? "1.0.0")"
    }
    var releaseAndBuildVersionNumberPretty: String {
        return "v \(releaseVersionNumber ?? "1.0").\(buildVersionNumber ?? ".0")"
    }
}
