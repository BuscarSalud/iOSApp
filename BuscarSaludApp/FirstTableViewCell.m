//
//  FirstTableViewCell.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 3/9/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "UIView+AutoLayout.h"
#import "UIView+FLKAutoLayout.h"
#import <QuartzCore/QuartzCore.h>
#import "MPColorTools.h"
#import "GRKGradientView.h"

@interface FirstTableViewCell()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation FirstTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIColor *contentViewColor = [UIColor colorWithRGB:0xd9dcd3];
        UIColor *textNameColor = [UIColor colorWithRGB:0x484848];
        UIColor *firstCellBackgroundBorderColor = [UIColor colorWithRGB:0xccd0c9];
        UIColor *firstCellBackgroundColor = [UIColor colorWithRGB:0xf4f8f0];

        self.contentView.backgroundColor = contentViewColor;
        
        self.firstCellBackground = [UIView newAutoLayoutView];
        self.firstCellBackground.layer.cornerRadius = 7;
        self.firstCellBackground.layer.borderColor = firstCellBackgroundBorderColor.CGColor;
        self.firstCellBackground.layer.borderWidth = 1.0f;
        
        self.firstCellBackground.layer.shadowColor = firstCellBackgroundBorderColor.CGColor;
        self.firstCellBackground.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        self.firstCellBackground.layer.shadowOpacity = 0.65f;
        self.firstCellBackground.layer.shadowRadius = 1.0f;
        self.firstCellBackground.layer.shouldRasterize = YES;
        self.firstCellBackground.opaque = YES;
        
        [self.firstCellBackground setBackgroundColor:firstCellBackgroundColor];
        
        self.iconContainer = [UIImageView newAutoLayoutView];
        
        self.nameLabel = [UILabel newAutoLayoutView];
        [self.nameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.nameLabel setNumberOfLines:0];
        [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.nameLabel setTextColor:textNameColor];
        
        [self.contentView addSubview:self.firstCellBackground];
        [self.contentView addSubview:self.iconContainer];
        [self.contentView addSubview:self.nameLabel];
        
        [self updateFonts];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    [self.firstCellBackground autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:14];
    [self.firstCellBackground autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [self.firstCellBackground autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.firstCellBackground constrainHeight:@"47"];
    
    [self.iconContainer constrainWidth:@"22" height:@"20"];
    [self.iconContainer autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:29];
    [self.iconContainer autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:21];
    
    
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.firstCellBackground withOffset:12];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:52];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    
    self.didSetupConstraints = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The below call to layoutSubviews on the table view cell's contentView should NOT be necessary.
    // However, in some (but not all!) cases it appears as though the super implementation does not call
    // layoutSubviews on the contentView, which causes all the UILabels to have a frame of CGRectZero.
    [self.contentView layoutSubviews];
    
    self.nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLabel.frame);
}

- (void)updateFonts
{
    UIFont *sourceSansProSemibold19 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:19];
    
    [self.nameLabel setFont: sourceSansProSemibold19];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
