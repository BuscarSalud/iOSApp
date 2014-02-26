//
//  TableViewCell.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/24/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "TableViewCell.h"
#import "UIView+AutoLayout.h"
#import "UIView+FLKAutoLayout.h"

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
        //self.contentView.layer.cornerRadius = 10;
        
        self.cellBackground = [UIView newAutoLayoutView];
        self.cellBackground.layer.cornerRadius = 10;
        [self.cellBackground setBackgroundColor:[UIColor colorWithRed:245.0/255 green:247.0/255.0 blue:242.0/255 alpha:1]];
        
        
        self.photoContainer = [UIView newAutoLayoutView];
        [self.photoContainer setBackgroundColor:[UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1]];
        /*
        self.photoImageView = [UIImageView newAutoLayoutView];
         */
        
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
        
        self.phonelabel = [UILabel newAutoLayoutView];
        [self.phonelabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.phonelabel setNumberOfLines:1];
        [self.phonelabel setTextAlignment:NSTextAlignmentLeft];
        [self.phonelabel setTextColor:[UIColor colorWithRed:119.0/255.0 green:165.0/255.0 blue:14.0/255.0 alpha:1]];
        
        self.streetLabel = [UILabel newAutoLayoutView];
        [self.streetLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.streetLabel setNumberOfLines:0];
        [self.streetLabel setTextAlignment:NSTextAlignmentLeft];
        [self.streetLabel setTextColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1]];
        
        self.coloniaLabel = [UILabel newAutoLayoutView];
        [self.coloniaLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.coloniaLabel setNumberOfLines:0];
        [self.coloniaLabel setTextAlignment:NSTextAlignmentLeft];
        [self.coloniaLabel setTextColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1]];
        
        self.cityLabel = [UILabel newAutoLayoutView];
        [self.cityLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.cityLabel setNumberOfLines:0];
        [self.cityLabel setTextAlignment:NSTextAlignmentLeft];
        [self.cityLabel setTextColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1]];
        
        self.titleLabel = [UILabel newAutoLayoutView];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setNumberOfLines:0];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1]];
        
        self.schoolLabel = [UILabel newAutoLayoutView];
        [self.schoolLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.schoolLabel setNumberOfLines:0];
        [self.schoolLabel setTextAlignment:NSTextAlignmentLeft];
        [self.schoolLabel setTextColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1]];
        
        
        [self.contentView addSubview:self.cellBackground];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.photoContainer];
        [self.contentView addSubview:self.summaryLabel];
        [self.contentView addSubview:self.phonelabel];
        [self.contentView addSubview:self.streetLabel];
        [self.contentView addSubview:self.coloniaLabel];
        [self.contentView addSubview:self.cityLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.schoolLabel];
        
        
        //[self.cellBackground addSubview:self.phonelabel];
        
        [self updateFonts];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    /*
    [self.cellBackground setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.cellBackground alignTop:@"10" leading:@"10" bottom:@"-10" trailing:@"-10" toView:self.cellBackground.superview];
*/
    
    [self.cellBackground setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.cellBackground autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.schoolLabel withOffset:10];
    
    
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    
    [self.photoContainer setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.photoContainer constrainWidth:@"62" height:@"87"];
    [self.photoContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:10];
    [self.photoContainer autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    //[self.photoContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];

    [self.summaryLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.summaryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.photoContainer withOffset:-2];
    [self.summaryLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.photoContainer withOffset:15];
    [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    //[self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.phonelabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.phonelabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.summaryLabel withOffset:10];
    [self.phonelabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.photoContainer withOffset:15];
    [self.phonelabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    //[self.phonelabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.streetLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.streetLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phonelabel];
    [self.streetLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.photoContainer withOffset:15];
    [self.streetLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    //[self.streetLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.coloniaLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.coloniaLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.streetLabel];
    [self.coloniaLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.photoContainer withOffset:15];
    [self.coloniaLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    //[self.coloniaLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.cityLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.cityLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.coloniaLabel];
    [self.cityLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.photoContainer withOffset:15];
    [self.cityLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    //[self.cityLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.coloniaLabel];
    [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.cityLabel withOffset:15];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    //[self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.schoolLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.schoolLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.coloniaLabel];
    [self.schoolLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.titleLabel withOffset:15];
    [self.schoolLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [self.schoolLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    
    
    /*[self.photoContainer setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.photoContainer constrainWidth:@"62" height:@"87"];
    [self.photoContainer constrainTopSpaceToView:self.nameLabel predicate:@"10"];
    [self.photoContainer alignLeadingEdgeWithView:self.cellBackground predicate:@"10"];
    [self.photoContainer alignBottomEdgeWithView:self.cellBackground predicate:@"-15"];
    
    [self.summaryLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    [self.summaryLabel constrainTopSpaceToView:self.cellBackground predicate:@"10"];
    [self.summaryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.photoContainer withOffset:-3];
    [self.summaryLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.photoContainer withOffset:7];
     [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelNamelInsets];
    //[self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0f];
    

    [self.photoContainer constrainWidth:@"62" height:@"87"];
    [self.photoContainer alignLeadingEdgeWithView:self.cellBackground predicate:@"10"];
    [self.photoContainer alignBottomEdgeWithView:self.cellBackground predicate:@"-10"];
    [self.photoContainer constrainTopSpaceToView:self.nameLabel predicate:@">=10"];*/

    /* //[self.photoContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:10];
    [self.photoContainer autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLabelNamelInsets];
    [self.photoContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];*/ 
    
    
    /*
    [self.summaryLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.summaryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.photoContainer withOffset:-3];
    [self.summaryLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.photoContainer withOffset:7];
    [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelNamelInsets];
    //[self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0f];
    
    [self.phonelabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.phonelabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.summaryLabel withOffset:20.0f];
    [self.phonelabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.photoContainer withOffset:7];
    [self.phonelabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelNamelInsets];
    [self.phonelabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0f]; */
    
    
    
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
    self.nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLabel.frame);
    self.summaryLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.summaryLabel.frame);
    self.streetLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.streetLabel.frame);
    self.coloniaLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.coloniaLabel.frame);
    self.cityLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.cityLabel.frame);
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.frame);
    self.schoolLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.schoolLabel.frame);
}

- (void)updateFonts
{
    UIFont *sourceSansProRegular13 = [UIFont fontWithName:@"SourceSansPro-Regular" size:13];
    UIFont *sourceSansProSemibold16 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:16];
    UIFont *sourceSansProBold13 = [UIFont fontWithName:@"SourceSansPro-Bold" size:13];
    
    [self.nameLabel setFont:sourceSansProSemibold16];
    [self.summaryLabel setFont:sourceSansProRegular13];
    [self.phonelabel setFont:sourceSansProBold13];
    [self.streetLabel setFont:sourceSansProRegular13];
    [self.coloniaLabel setFont:sourceSansProRegular13];
    [self.cityLabel setFont:sourceSansProRegular13];
    [self.titleLabel setFont:sourceSansProRegular13];
    [self.schoolLabel setFont:sourceSansProRegular13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
