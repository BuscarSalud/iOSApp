//
//  getInfoEngine.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/21/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface getInfoEngine : MKNetworkEngine

typedef void (^InfoResponseBlock)(NSMutableArray* infoDictionary);

-(void) getDoctorsList:(NSMutableDictionary*) params completionHandler:(InfoResponseBlock) docsBlock errorHandler:(MKNKErrorBlock) errorBlock;
@end
