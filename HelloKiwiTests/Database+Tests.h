//
//  Database+Tests.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 21/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "Database.h"



@interface Database (Tests)

- (void)setManagedObjectModel:(NSManagedObjectModel *)managedObjectModel;
- (void)setPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (NSManagedObjectModel *)currentManagedObjectModel;
- (NSPersistentStoreCoordinator *)currentPersistentStoreCoordinator;
- (NSManagedObjectContext *)currentManagedObjectContext;

@end
