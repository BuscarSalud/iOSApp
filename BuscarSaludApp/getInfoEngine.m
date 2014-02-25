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
    MKNetworkOperation *op = [self operationWithPath:@"get_info.php" params:params httpMethod:@"GET" ssl:NO];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            docsBlock(jsonObject);
        }];
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
}

@end
