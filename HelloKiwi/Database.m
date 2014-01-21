//
//  Database.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 20/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "Database.h"



@implementation Database

- (id)initWithDatabaseName:(NSString *)name
{
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

- (void)setName:(NSString *)name
{
    _name = name;
    [self reset];
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) return _managedObjectModel;
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle mainBundle]]];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) return _persistentStoreCoordinator;
    
    NSString *storePath =
    [applicationDocumentsDirectory() stringByAppendingPathComponent:
     [self.name stringByAppendingPathExtension:@"sqlite"]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:storePath]) {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:self.name
                                                                     ofType:@"sqlite"];
        [[NSFileManager defaultManager] copyItemAtPath:defaultStorePath
                                                toPath:storePath
                                                 error:nil];
    }
    
    _persistentStoreCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                              configuration:nil
                                                        URL:[NSURL fileURLWithPath:storePath]
                                                    options:nil
                                                      error:nil];
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) return _managedObjectContext;
    
    if ([self persistentStoreCoordinator]) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        _managedObjectContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
    }
    
    return _managedObjectContext;
}

- (void)reset
{
    _managedObjectContext = nil;
    _persistentStoreCoordinator = nil;
    _managedObjectModel = nil;
}

@end
