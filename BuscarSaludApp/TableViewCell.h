//
//  TableViewCell.h
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/24/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLabelContainerInsets      11.0f
#define kLabelNamelInsets      10.0f
#define kLabelExtractlInsets      90.0f
#define kLabelVerticalLabelsSummaryInsets        12.0f
#define kLabelVerticalLabelsNameInsets        13.0f
#define kLabelVerticalConteinerInsets        11.0f

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *phonelabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *schoolLabel;
@property (strong, nonatomic) IBOutlet UILabel *streetLabel;
@property (strong, nonatomic) IBOutlet UILabel *coloniaLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel; 
@property (strong, nonatomic) IBOutlet UIView *cellBackground;
@property (strong, nonatomic) IBOutlet UIView *photoContainer;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;


- (void)updateFonts;

@end
