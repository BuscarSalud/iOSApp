//
//  FirstTableViewCell.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 3/9/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *firstCellBackground;
@property (strong, nonatomic) IBOutlet UIImageView *iconContainer;

- (void)updateFonts;

@end
