//
//  S3Util.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 3/4/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import Foundation
import AWSCore
import AWSS3
import AWSAuthCore
import AWSUserPoolsSignIn

func getFile(with name: String, from folder: String) -> URL? {
    
    let fileManager = FileManager.default
    do {
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let fileURL = documentDirectory.appendingPathComponent(name)
        
        //downloadFile(with: name, from: folder, to: fileURL)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            print("file exists: \(name)")
            return fileURL
        }
        else {
            print("file doesn't exists, downloading: \(name)")
            downloadFile(with: name, from: folder, to: fileURL)
            return fileURL
        }
        
    } catch {
        print(error)
    }
    
    return nil
}

func downloadFile(with name: String, from folder: String, to url: URL) {
    let expression = AWSS3TransferUtilityDownloadExpression()
    expression.progressBlock = {(task, progress) in DispatchQueue.main.async(execute: {
        // Do something e.g. Update a progress bar.
    })
    }
    
    var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
    completionHandler = { (task, URL, data, error) -> Void in
        DispatchQueue.main.async(execute: {
            // Do something e.g. Alert a user for transfer completion.
            // On failed downloads, `error` contains the error object.
            print("transfer completed")
        })
    }
    
    let transferUtility = AWSS3TransferUtility.default()
    transferUtility.download(
        to: url,
        bucket: S3BucketName,
        key: "\(folder)/\(name)",
        expression: expression,
        completionHandler: completionHandler
        ).continueWith {
            (task) -> AnyObject! in if let error = task.error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let _ = task.result {
                // Do something with downloadTask.
                
            }
            return nil;
    }
}

func uploadFile(_ data: Data, with name: String, to folder: String) {
    let expression = AWSS3TransferUtilityUploadExpression()
    expression.progressBlock = {(task, progress) in
        DispatchQueue.main.async(execute: {
            // Do something e.g. Update a progress bar.
        })
    }
    
    var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    completionHandler = { (task, error) -> Void in
        DispatchQueue.main.async(execute: {
            // Do something e.g. Alert a user for transfer completion.
            // On failed uploads, `error` contains the error object.
        })
    }
    
    let transferUtility = AWSS3TransferUtility.default()
    
    let userId = AWSIdentityManager.default().identityId!
    
    print("UserId: \(userId)")
    
    transferUtility.uploadData(data,
                               bucket: S3BucketName,
                               key: "\(folder)/\(userId)/\(name)",
        contentType: "audio/m4a",
        expression: expression,
        completionHandler: completionHandler).continueWith {
            (task) -> AnyObject! in
            if let error = task.error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let _ = task.result {
                // Do something with uploadTask.
            }
            return nil;
    }
}
