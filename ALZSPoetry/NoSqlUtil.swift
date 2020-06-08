//
//  NoSqlUtil.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 3/9/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import Foundation
import AWSDynamoDB

func saveRecording(_ recording: Recording) {
    let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
    dynamoDbObjectMapper.save(recording, completionHandler: {
        (error: Error?) -> Void in
        
        if let error = error {
            print("Amazon DynamoDB Save Error: \(error)")
            return
        }
        print("An item was saved.")
    })
}
