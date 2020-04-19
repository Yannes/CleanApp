//
//  TestExtension.swift
//  DataTests
//
//  Created by Yannes Meneguelli on 09/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import XCTest



extension XCTestCase {
    
 public  func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line){
          addTeardownBlock {[weak instance ] in
              XCTAssertNil(instance,file: file , line: line)
          }
      }
}
