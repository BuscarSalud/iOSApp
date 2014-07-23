//
//  CategoriesDictionary.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 4/21/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Specialty.h"

@interface CategoriesDictionary : NSObject

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *tid;

+(Specialty *)returnSpecialty:(NSString *)tid;

@end
