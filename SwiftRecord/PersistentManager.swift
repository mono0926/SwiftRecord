//
//  PersistentManager.swift
//  SwiftRecord
//
//  Created by mono on 6/16/14.
//  Copyright (c) 2014 mono. All rights reserved.
//

class PersistentManager {
    let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    let managedObjectContext: NSManagedObjectContext =
    {
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType);
        return moc;
    }()
    init() {
        self.persistentStoreCoordinator = PersistentManager.createPersistentStoreCoordinator(managedObjectModel)
        self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
    }
    
    class func createPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel) -> NSPersistentStoreCoordinator {        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let urls = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        let docUrl: NSURL = urls[urls.count - 1] as NSURL
        let url = docUrl.URLByAppendingPathComponent("CoreData.sqlite")
        
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        let error: NSErrorPointer = nil
        if !coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options, error: error) {
            println("\(error)")
        }
        return coordinator;
    }
}