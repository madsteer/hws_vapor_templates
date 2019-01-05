//
//  Join.swift
//  App
//
//  Created by Cory Steers on 1/4/19.
//

import Foundation
import Async
import Leaf

public final class JoinTag: TagRenderer {
    public func render(tag parsed: TagContext) throws -> Future<TemplateData> {
        try parsed.requireParameterCount(2)

        return Future.map(on: parsed.container) {
            if let array = parsed.parameters[0].array,
               let separator = parsed.parameters[1].string {

                let items = array.compactMap { $0.string }
                return .string(items.joined(separator: separator))

            } else {
                return .null
            }
        }
    }
}
