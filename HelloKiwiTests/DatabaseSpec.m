//
//  DatabaseSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 20/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "Database+Tests.h"

#import <Kiwi/Kiwi.h>
#import <CoreData/CoreData.h>



SPEC_BEGIN(DatabaseSpec)

describe(@"Database", ^{
    
    __block Database *sut;
    __block NSString *storePath;
    __block NSString *defaultStorePath;
    
    beforeEach(^{
        
        storePath =
        [applicationDocumentsDirectory()
         stringByAppendingPathComponent:[@"Model" stringByAppendingPathExtension:@"sqlite"]];
        
        defaultStorePath = [NSString stringWithFormat:@"path/to/test/file/%@.sqlite", @"Model"];
        
        [[NSBundle mainBundle] stub:@selector(pathForResource:ofType:)
                          andReturn:defaultStorePath
                      withArguments:@"Model", @"sqlite"];
        
        sut = [[Database alloc] initWithDatabaseName:@"Model"];
    });
    
    afterEach(^{
        sut = nil;
        storePath = nil;
        defaultStorePath = nil;
    });
    
    it(@"should have right name", ^{
        [[sut.name should] equal:@"Model"];
    });
    
    it(@"should set context to nil after reset", ^{
        [sut setManagedObjectContext:[[NSManagedObjectContext alloc] init]];
        [sut reset];
        [[[sut currentManagedObjectContext] should] beNil];
    });
    
    it(@"should set coordinator to nil after reset", ^{
        [sut setPersistentStoreCoordinator:[[NSPersistentStoreCoordinator alloc] init]];
        [sut reset];
        [[[sut currentPersistentStoreCoordinator] should] beNil];
    });
    
    it(@"should set model to nil after reset", ^{
        [sut setManagedObjectModel:[[NSManagedObjectModel alloc] init]];
        [sut reset];
        [[[sut currentManagedObjectModel] should] beNil];
    });
    
    it(@"should be reseted after setName:", ^{
        [[sut should] receive:@selector(reset)];
        [sut setName:@"Model"];
    });
    
//    it(@"should return NSManagedObject in itemOfClass:withPredicate:", ^{
//        <#code#>
//    });
    
    context(@"managedObjectModel", ^{
        
        it(@"should not be recreated if it already exists", ^{
            NSManagedObjectModel *model = [[NSManagedObjectModel alloc] init];
            [sut setManagedObjectModel:model];
            [[theValue([sut managedObjectModel]) should] equal:theValue(model)];
        });
        
        it(@"should be created via merge model from main bundle if it not exists yet", ^{
            
            [sut setManagedObjectModel:nil];
            NSManagedObjectModel *model = [[NSManagedObjectModel alloc] init];
            [NSManagedObjectModel stub:@selector(mergedModelFromBundles:)
                             andReturn:model
                         withArguments:@[[NSBundle mainBundle]]];
            
            [[[sut managedObjectModel] should] equal:model];
        });
    });
    
    context(@"persistentStoreCoordinator", ^{
        
        it(@"should not be recreated if it already exists", ^{
            NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] init];
            [sut setPersistentStoreCoordinator:coordinator];
            [[theValue([sut persistentStoreCoordinator]) should] equal:theValue(coordinator)];
        });
        
        it(@"should copy right .sqlite file if it not exists yet", ^{
            
            [sut setPersistentStoreCoordinator:nil];
            [[NSFileManager defaultManager] removeItemAtPath:storePath error:nil];
            
            [[[NSFileManager defaultManager] should] receive:@selector(copyItemAtPath:toPath:error:)
                                               withArguments:defaultStorePath, storePath, nil];
            
            [sut persistentStoreCoordinator];
        });
        
        it(@"should have right managedObjectModel", ^{
            [[theValue([sut.persistentStoreCoordinator managedObjectModel]) should] equal:
             theValue([sut managedObjectModel])];
        });
        
        it(@"should have right persistentStore type", ^{
            
            NSPersistentStore *store =
            [[[sut persistentStoreCoordinator] persistentStores] firstObject];
            
            [[store.type should] equal:NSSQLiteStoreType];
        });
        
        it(@"should have right persistentStore URL", ^{
            
            NSPersistentStore *store =
            [[[sut persistentStoreCoordinator] persistentStores] firstObject];
            
            [[store.URL should] equal:[NSURL fileURLWithPath:storePath]];
        });
    });
    
    context(@"managedObjectContext", ^{
        
        it(@"should not be recreated if it already exists", ^{
            NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
            [sut setManagedObjectContext:context];
            [[theValue([sut managedObjectContext]) should] equal:theValue(context)];
        });
        
        it(@"should be nil if persistentStoreCoordinator is nil", ^{
            
            [sut setManagedObjectContext:nil];
            [sut stub:@selector(persistentStoreCoordinator) andReturn:nil];
            
            [[[sut managedObjectContext] should] beNil];
        });
        
        it(@"should have right persistentStoreCoordinator if it exists", ^{
            
            [sut stub:@selector(persistentStoreCoordinator)
            andReturn:[[NSPersistentStoreCoordinator alloc] init]];
            
            [[theValue([[sut managedObjectContext] persistentStoreCoordinator]) should] equal:
             theValue([sut persistentStoreCoordinator])];
        });
    });
});

SPEC_END
