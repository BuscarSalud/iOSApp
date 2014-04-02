//
//  LoadingMoreTableViewCell.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 3/30/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingMoreTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *firstCellBackground;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (void)updateFonts;

@end
