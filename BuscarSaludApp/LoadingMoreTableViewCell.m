//
//  LoadingMoreTableViewCell.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 3/30/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "LoadingMoreTableViewCell.h"
#import "UIView+AutoLayout.h"
#import "UIView+FLKAutoLayout.h"
#import <QuartzCore/QuartzCore.h>
#import "MPColorTools.h"
#import "GRKGradientView.h"


@interface LoadingMoreTableViewCell()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation LoadingMoreTableViewCell

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
        
        self.nameLabel = [UILabel newAutoLayoutView];
        [self.nameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.nameLabel setNumberOfLines:0];
        [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.nameLabel setTextColor:textNameColor];
        
        //self.activityIndicator = [UIActivityIndicatorView newAutoLayoutView];
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        self.activityIndicator.alpha = 0.0;

        [self.contentView addSubview:self.firstCellBackground];
        [self.contentView addSubview:self.activityIndicator];
        [self.contentView addSubview:self.nameLabel];
        
        [self updateFonts];

    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    [self.firstCellBackground autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [self.firstCellBackground autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [self.firstCellBackground autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.firstCellBackground constrainHeight:@"47"];
    
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel autoCenterInSuperview];
    
    [self.activityIndicator setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.activityIndicator autoCenterInSuperview];
    
    self.didSetupConstraints = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The below call to layoutSubviews on the table view cell's contentView should NOT be necessary.
    // However, in some (but not all!) cases it appears as though the super implementation does not call
    // layoutSubviews on the contentView, which causes all the UILabels to have a frame of CGRectZero.
    [self.contentView layoutSubviews];
    
    //self.nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLabel.frame);
}

- (void)updateFonts
{
    UIFont *sourceSansProSemibold16 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:16];
    
    [self.nameLabel setFont: sourceSansProSemibold16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    if (selected) {
        [UIView animateWithDuration:0.2 animations:^(void){
            self.nameLabel.alpha = 0.0;
        }completion:^(BOOL completed){
            [self.activityIndicator startAnimating];
            self.activityIndicator.alpha = 1.0;
        }];
        
    }else{
        self.nameLabel.alpha = 1.0;
    }
}

-(void)setsele
{
    
}
@end
