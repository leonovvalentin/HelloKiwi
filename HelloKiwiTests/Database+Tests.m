//
//  Database+Tests.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 21/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "Database+Tests.h"



@implementation Database (Tests)

- (void)setManagedObjectModel:(NSManagedObjectModel *)managedObjectModel
{
    _managedObjectModel = managedObjectModel;
}

- (void)setPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    _persistentStoreCoordinator = persistentStoreCoordinator;
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
}

- (NSManagedObjectModel *)currentManagedObjectModel
{
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)currentPersistentStoreCoordinator
{
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)currentManagedObjectContext
{
    return _managedObjectContext;
}

@end
