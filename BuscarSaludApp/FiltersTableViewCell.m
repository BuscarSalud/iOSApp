//
//  FiltersTableViewCell.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 4/15/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "FiltersTableViewCell.h"
#import "UIView+AutoLayout.h"
#import "UIView+FLKAutoLayout.h"
#import <QuartzCore/QuartzCore.h>
#import "MPColorTools.h"
#import "GRKGradientView.h"

@interface FiltersTableViewCell()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation FiltersTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIColor *textNameColor = [UIColor colorWithRGB:0x484848];
        
        self.nameLabel = [UILabel newAutoLayoutView];
        [self.nameLabel setNumberOfLines:0];
        [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.nameLabel setTextColor:textNameColor];
        
        self.instancesLabel = [UILabel newAutoLayoutView];
        [self.instancesLabel setNumberOfLines:0];
        [self.instancesLabel setTextAlignment:NSTextAlignmentLeft];
        [self.instancesLabel setTextColor:textNameColor];
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.instancesLabel];
        
        [self updateFonts];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    
    [self.instancesLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel];
    [self.instancesLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15.0f];
    
    self.didSetupConstraints = YES;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The below call to layoutSubviews on the table view cell's contentView should NOT be necessary.
    // However, in some (but not all!) cases it appears as though the super implementation does not call
    // layoutSubviews on the contentView, which causes all the UILabels to have a frame of CGRectZero.
    [self.contentView layoutSubviews];
    
}

- (void)updateFonts
{
    UIFont *sourceSansProSemibold12 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:12];
    UIFont *sourceSansProSemibold10 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:10];
    
    [self.nameLabel setFont: sourceSansProSemibold12];
    [self.instancesLabel setFont:sourceSansProSemibold10];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    // Initialization code
}
@end
