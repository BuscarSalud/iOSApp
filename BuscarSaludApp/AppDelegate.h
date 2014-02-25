//
//  AppDelegate.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/17/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "getInfoEngine.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) getInfoEngine *infoEngine;


@end
