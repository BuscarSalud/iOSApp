//
//  FiltersTableViewCell.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 4/15/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltersTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *instancesLabel;

- (void)updateFonts;

@end
