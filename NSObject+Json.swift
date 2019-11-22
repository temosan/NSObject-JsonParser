//
//  NSObject+Json.swift
//  SafetyApp-Swift
//
//  Created by Temosan on 01/08/2019.
//  Copyright © 2019 Temosan. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// Json 포맷 파일에서 최상위 Object를 가져온다.
    ///
    /// - Parameter jsonFileName: Json 포맷 파일
    /// - Returns: 최상위 노드
    class func objectFromJson(jsonFileName: String) -> Any? {
        return self.objectFromJson(jsonFileName: jsonFileName, path: nil)
    }
    
    /// Json 포맷 파일에서 Path와 일치한 Object를 가져온다. 만약 값을 찾을 수 없으면 nil을 반환한다.
    ///
    /// - Parameters:
    ///   - jsonFileName: Json 포맷 파일
    ///   - path: 가져올 Json Node의 Object위치
    /// - Returns: Path에 해당하는 Object, 찾지 못할 경우에는 nil을 반환한다.
    class func objectFromJson(jsonFileName: String, path: String?) -> Any? {
        
        let bundle = Bundle.main.path(forResource: jsonFileName, ofType: "geojson")
        guard let explicitBundle = bundle else { return nil }
        
        do {
            let file = try String(contentsOfFile: explicitBundle)
            guard let jsonData = file.data(using: .utf8) else { return nil }
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            let dictionary = json as? [String: Any]
            guard let result = dictionary?.object(forPath: path) else { return nil }
            
            return result
        } catch {
            print("Json Parse Error.")
            return nil
        }
    }
}

