//
//  TableViewCell.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/24/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "TableViewCell.h"
#import "UIView+AutoLayout.h"

@interface TableViewCell()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:220.0/255.0 blue:211.0/255.0 alpha:0.8];
        
        self.cellContainer = [UIView newAutoLayoutView];
        self.cellContainer.layer.cornerRadius = 10;
        [self.cellContainer setBackgroundColor:[UIColor colorWithRed:245.0/255 green:247.0/255.0 blue:242.0/255 alpha:1]];
        
        self.nameLabel = [UILabel newAutoLayoutView];
        [self.nameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.nameLabel setNumberOfLines:0];
        [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.nameLabel setTextColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1]];
        
        self.summaryLabel = [UILabel newAutoLayoutView];
        [self.summaryLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.summaryLabel setNumberOfLines:0];
        [self.summaryLabel setTextAlignment:NSTextAlignmentLeft];
        [self.summaryLabel setTextColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1]];
        
        [self.contentView addSubview:self.cellContainer];
        [self.cellContainer addSubview:self.nameLabel];
        [self.cellContainer addSubview:self.summaryLabel];
        
        [self updateFonts];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    [self.cellContainer setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.cellContainer autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalConteinerInsets];
    [self.cellContainer autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelContainerInsets];
    [self.cellContainer autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelContainerInsets];
    [self.cellContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalLabelsNameInsets];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelNamelInsets];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelNamelInsets];
    
    [self.summaryLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.summaryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:10.0f];
    [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelExtractlInsets];
    [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelNamelInsets];
    [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0f];
    
    
    
    self.didSetupConstraints = YES;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The below call to layoutSubviews on the table view cell's contentView should NOT be necessary.
    // However, in some (but not all!) cases it appears as though the super implementation does not call
    // layoutSubviews on the contentView, which causes all the UILabels to have a frame of CGRectZero.
    [self.contentView layoutSubviews];
    
    // Set the preferredMaxLayoutWidth of the mutli-line body Label based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.summaryLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.summaryLabel.frame);
    self.nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLabel.frame);
}

- (void)updateFonts
{
    UIFont *sourceSansProRegular13 = [UIFont fontWithName:@"SourceSansPro-Regular" size:13];
    UIFont *sourceSansProSemibold16 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:16];
    [self.nameLabel setFont:sourceSansProSemibold16];
    [self.summaryLabel setFont:sourceSansProRegular13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
