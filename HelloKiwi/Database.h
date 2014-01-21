//
//  Database.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 20/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



@interface Database : NSObject
{
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectContext *_managedObjectContext;
}

@property (nonatomic, strong) NSString *name;

- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectContext *)managedObjectContext;

- (id)initWithDatabaseName:(NSString *)name;
- (void)reset;

//- (NSManagedObject *)itemOfClass:(Class)classOfItem withPredicate:(NSPredicate *)predicate;

@end
