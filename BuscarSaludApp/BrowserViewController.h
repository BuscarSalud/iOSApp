//
//  BrowserViewController.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/20/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "getInfoEngine.h"

@interface BrowserViewController : UIViewController<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottomContstraint;
@property (nonatomic, strong) NSDictionary *doctorsStatic;
- (IBAction)loadMoreResults:(id)sender;

@end
