//
//  Education.swift
//  AnyMindResume
//
//  Created by Nil Rathod on 11/03/22.
//

import UIKit
import SwiftUI

/// Basic education details
class Education: ObservableObject {
    
    @Published var startYear: String = ""
    @Published var endYear: String = ""
    @Published var stillInSchool: Bool = false
    
    @Published var major: String = ""
    @Published var institution: String = ""
    
    /// Dictionary data used to save the model on user defaults
    var dictionary: [String: Any] {
        [
            "startYear": startYear, "endYear": endYear, "stillInSchool": stillInSchool,
            "major": major, "institution": institution
        ]
    }
    
    /// Initializer with dictionary
    convenience init(dictionary: [String: Any]) {
        self.init()
        startYear = dictionary["startYear"] as? String ?? ""
        endYear = dictionary["endYear"] as? String ?? ""
        stillInSchool = dictionary["stillInSchool"] as? Bool ?? false
        major = dictionary["major"] as? String ?? ""
        institution = dictionary["institution"] as? String ?? ""
    }
    
    /// Defines when education entry is valid
    var isValid: Bool {
        !institution.trimmingCharacters(in: .whitespaces).isEmpty
            && !startYear.trimmingCharacters(in: .whitespaces).isEmpty
            && ((!stillInSchool && !endYear.trimmingCharacters(in: .whitespaces).isEmpty) || stillInSchool)
    }
    
    /// Formatted details
    var startEndYear: String {
        let end = stillInSchool ? "Present" : endYear
        return "\(startYear) - \(end)"
    }
    
    /// Preview model
    static var preview: Education {
        let model = Education()
        model.startYear = "2009"
        model.endYear = "2015"
        model.stillInSchool = false
        model.major = "Master Computer Application"
        model.institution = "Gujrat University"
        return model
    }
}
