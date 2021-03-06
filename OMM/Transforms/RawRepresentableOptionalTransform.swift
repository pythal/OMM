//
//  RawRepresentableOptionalTransform.swift
//  OMM
//
//  Created by Ivan Nikitin on 12/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

/// Transformation that transforms node to `RawRepresentable` value or `nil` if there is no value represented with raw value of node.
public
struct RawRepresentableOptionalTransform<T: RawRepresentable>: Transform where T.RawValue: Scalar {

    /// Creates an instance of `RawRepresentableOptionalTransform`.
    public
    init() { }

    /// Transforms node to `RawRepresentable` value or `nil` if there is no value represented with raw value of node.
    ///
    /// - Parameter node: Node.
    /// - Returns: `RawRepresentable` instance or `nil`.
    /// - Throws: `MappingError`.
    public
    func apply(to node: Node) throws -> T? {
        return try T(rawValue: node.value(T.RawValue.self))
    }
    
}
