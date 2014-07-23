//
//  StatesDictionary.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 4/21/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "State.h"

@interface StatesDictionary : NSObject

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *tid;

+(State *)returnState:(NSString *)tid;


@end
