//
//  DateTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 10/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

import class Foundation.NSDate
import class Foundation.NSDateFormatter
import class Foundation.NSCalendar
import class Foundation.NSLocale
import class Foundation.NSTimeZone

/// Transformation that transforms node to `NSDate` value
/// in case of date represented as the formatted string.
public
struct DateTransform: TransformType {

    private
    let formatter: NSDateFormatter

    /// Creates an instance of `DateTransform` initilized with given date format string.
    ///
    /// - Parameter dateFormat: Date format.
    /// - Note: The formatter defaults to having the ISO 8601 calendar, `en_US_POSIX` locale and UTC time zone, for those properties.
    public
    init(dateFormat: String) {
        let formatter = NSDateFormatter()
        formatter.calendar = NSCalendar.ISO8601
        formatter.dateFormat = dateFormat
        formatter.locale = NSLocale.POSIX
        formatter.timeZone = NSTimeZone.UTC
        self.init(formatter: formatter)
    }

    /// Creates an instance of `DateTransform` initilized with given date formatter.
    ///
    /// - Parameter formatter: Date formatter.
    public
    init(formatter: NSDateFormatter) {
        self.formatter = formatter.copy() as! NSDateFormatter
    }

    /// Transforms node to `NSDate` value.
    ///
    /// - Parameter node: Node.
    /// - Returns: `NSDate` instance.
    /// - Throws: `MappingError`, `TransformError` if `String` value of node does not represent correctly formatted date.
    public
    func applyToNode(node: NodeType) throws -> NSDate {
        guard let value = try formatter.dateFromString(node.value(String)) else {
            throw errorWithReason("Unexpected date format")
        }
        return value
    }

}

public
extension DateTransform {

    /// Date transformation working with dates formatted using ISO 8601 standard.
    ///
    /// - Note: Transformation covers only `yyyy-MM-dd'T'HH:mm:ssZZZZZ` format.
    public
    static var ISO8601: DateTransform {
        return DateTransform(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    }
    
}
