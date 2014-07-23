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

@interface BrowserViewController : UIViewController<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottomContstraint;
@property (nonatomic, strong) NSDictionary *doctorsStatic;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *doctorsButton;
@property (strong, nonatomic) IBOutlet UIView *firstCellBackground;
@property (retain, nonatomic)NSDictionary *specialtiesDictionary;
@property (retain, nonatomic)NSDictionary *statesDictionary;
@property (retain, nonatomic)NSDictionary *previousSpecialtiesDictionary;
@property (retain, nonatomic)NSDictionary *previousStatesDictionary;

- (IBAction)searchButton:(id)sender;
- (IBAction)loadMoreResults:(id)sender;
- (void)showFilterOptionsMethod:(id)sender;
@end
