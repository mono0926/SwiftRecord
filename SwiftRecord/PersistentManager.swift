//
//  PersistentManager.swift
//  SwiftRecord
//
//  Created by mono on 6/16/14.
//  Copyright (c) 2014 mono. All rights reserved.
//

class PersistentManager {
    let managedObjectModel = NSManagedObjectModel()
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    let managedObjectContext: NSManagedObjectContext
    init() {
    }
    
    func createPersistentStoreCoordinator() -> NSPersistentStoreCoordinator? {
        let applicationSupportDirectory = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)[0] as String
        
        let fileManager = NSFileManager.defaultManager();
        let error:NSError? = nil
        var isDirectory:CBool = false        
        if (fileManager.fileExistsAtPath(applicationSupportDirectory, isDirectory: false)) {
            if (!fileManager .createDirectoryAtURL(applicationSupportDirectory, withIntermediateDirectories: false, attributes: nil, error: &error)) {
                return nil;
            }
        }
        
        let storeUrl = NSURL.fileURLWithPath("\(applicationSupportDirectory)CoreModel.sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeUrl, options: nil, error: &error)
        return coordinator;
    }
}