//
//  Zebra.swift
//  App
//
//  Created by Cory Steers on 1/5/19.
//

import Foundation
import Async
import Leaf

public final class ZebraTag: TagRenderer {
    public func render(tag parsed: TagContext) throws -> Future<TemplateData> {
        try parsed.requireParameterCount(3)

        let prefix = "<div class=\"row\"><div class=\"col-md-3\">"
        let suffix = "</li></div></div>"
        return Future.map(on: parsed.container) {
            if let name = parsed.parameters[0].string,
                let index = parsed.parameters[1].int,
                let text = parsed.parameters[2].string {

                var myLiTag: String
                if index % 2 != 0 {
                    myLiTag = "<li class=\"black-stripe\">"
                } else {
                    myLiTag = "<li>"
                }

                let fixedText = text.replacingOccurrences(of: "INDEX", with: String(index)).replacingOccurrences(of: "NAME", with: name)
                return .string(prefix + myLiTag + fixedText + suffix)

            } else {
                return .null
            }
        }
    }
}
