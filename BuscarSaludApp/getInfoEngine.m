//
//  getInfoEngine.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/21/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "getInfoEngine.h"

@implementation getInfoEngine

-(void) getDoctorsList:(NSMutableDictionary *)params completionHandler:(InfoResponseBlock)docsBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    NSLog(@"%@", params);
    MKNetworkOperation *op = [self operationWithPath:@"admin/bsmws" params:params httpMethod:@"GET" ssl:NO];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            docsBlock(jsonObject);
        }];
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
}

-(void) searchDoctors:(NSMutableDictionary *)params completionHandler:(InfoResponseBlock)docsBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    NSLog(@"%@", params);
    MKNetworkOperation *op = [self operationWithPath:@"admin/bsmws" params:params httpMethod:@"GET" ssl:NO];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            docsBlock(jsonObject);
        }];
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
}

-(void) getStateSpecialty:(NSMutableDictionary *)params completionHandler:(InfoResponseStateSpecialtyBlock)infoBlock errorHandler:(MKNKErrorBlock)errorBlock{
    
    MKNetworkOperation *op = [self operationWithPath:@"get_specialties_states.php" params:params httpMethod:@"GET" ssl:NO];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            infoBlock(jsonObject);
        }];
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}

@end
