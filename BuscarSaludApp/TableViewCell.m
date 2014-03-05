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
#import <QuartzCore/QuartzCore.h>
#import "MPColorTools.h"
#import "GRKGradientView.h"

@interface TableViewCell()
{
    GRKGradientView *buttonGradient;

}

@property (nonatomic, assign) BOOL didSetupConstraints;

//@property (nonatomic,weak) IBOutlet GRKGradientView *buttonGradient;

@end

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIColor *contentViewColor = [UIColor colorWithRGB:0xd9dcd3];
        UIColor *textNameColor = [UIColor colorWithRGB:0x484848];
        UIColor *textOthersColor = [UIColor colorWithRGB:0x474747];
        UIColor *pointsColor = [UIColor colorWithRGB:0x464646];
        UIColor *phoneNumberColor = [UIColor colorWithRGB:0x77a50e];
        UIColor *cellBackgroundBorderColor = [UIColor colorWithRGB:0xccd0c9];
        UIColor *cellBackgroundColor = [UIColor colorWithRGB:0xf4f8f0];
        UIColor *photoContainerColor = [UIColor colorWithRGB:0xdddddd];
        UIColor *pointsContainerColor = [UIColor colorWithRGB:0xedf0e7];
        UIColor *color1Gradient = [UIColor colorWithRGB:0x70b220];
        UIColor *color2Gradient = [UIColor colorWithRGB:0x60961b];
        UIColor *seeProfileButtonTextColor = [UIColor colorWithRGB:0xffffff];
        UIColor *seeProfileButtonTextShadowColor = [UIColor colorWithRGB:0x5d931a];
        
        
        self.contentView.backgroundColor = contentViewColor;
        //self.contentView.layer.cornerRadius = 10;
        
        self.cellBackground = [UIView newAutoLayoutView];
        self.cellBackground.layer.cornerRadius = 10;
        self.cellBackground.layer.borderColor = cellBackgroundBorderColor.CGColor;
        self.cellBackground.layer.borderWidth = 0.8f;
        self.cellBackground.layer.shadowColor = cellBackgroundBorderColor.CGColor;
        self.cellBackground.layer.shadowOffset = CGSizeMake(0.0, 10.0);
        //self.cellBackground.layer.shadowOpacity = 1.0;
        //self.cellBackground.layer.shadowRadius = 20.0;
        [self.cellBackground setBackgroundColor:cellBackgroundColor];
        
        self.photoContainer = [UIView newAutoLayoutView];
        [self.photoContainer setBackgroundColor:photoContainerColor];
        
        self.photoImageView = [UIImageView newAutoLayoutView];
        
        self.pointsContainer = [UIView newAutoLayoutView];
        [self.pointsContainer setBackgroundColor:pointsContainerColor];
        
        
        buttonGradient = [[GRKGradientView alloc]init];
        //buttonGradient.gradientOrientation = GRKGradientOrientationDown;
        buttonGradient.gradientColors = [NSArray arrayWithObjects:color1Gradient, color2Gradient, nil];
        buttonGradient.layer.cornerRadius = 5;
        [[buttonGradient layer] setMasksToBounds:YES];
        
        
        
        self.nameLabel = [UILabel newAutoLayoutView];
        [self.nameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.nameLabel setNumberOfLines:0];
        [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.nameLabel setTextColor:textNameColor];
      
        self.summaryLabel = [UILabel newAutoLayoutView];
        [self.summaryLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.summaryLabel setNumberOfLines:0];
        [self.summaryLabel setTextAlignment:NSTextAlignmentLeft];
        [self.summaryLabel setTextColor:textNameColor];
        
        self.phonelabel = [UILabel newAutoLayoutView];
        [self.phonelabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.phonelabel setNumberOfLines:1];
        [self.phonelabel setTextAlignment:NSTextAlignmentLeft];
        [self.phonelabel setTextColor:phoneNumberColor];
        
        self.streetLabel = [UILabel newAutoLayoutView];
        [self.streetLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.streetLabel setNumberOfLines:0];
        [self.streetLabel setTextAlignment:NSTextAlignmentLeft];
        [self.streetLabel setTextColor:textOthersColor];
        
        self.coloniaLabel = [UILabel newAutoLayoutView];
        [self.coloniaLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.coloniaLabel setNumberOfLines:0];
        [self.coloniaLabel setTextAlignment:NSTextAlignmentLeft];
        [self.coloniaLabel setTextColor:textOthersColor];
        
        self.cityLabel = [UILabel newAutoLayoutView];
        [self.cityLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.cityLabel setNumberOfLines:0];
        [self.cityLabel setTextAlignment:NSTextAlignmentLeft];
        [self.cityLabel setTextColor:textOthersColor];
        
        self.titleLabel = [UILabel newAutoLayoutView];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setNumberOfLines:0];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:textOthersColor];
        
        self.schoolLabel = [UILabel newAutoLayoutView];
        [self.schoolLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.schoolLabel setNumberOfLines:0];
        [self.schoolLabel setTextAlignment:NSTextAlignmentLeft];
        [self.schoolLabel setTextColor:textOthersColor];
        
        self.pointsLabel = [UILabel newAutoLayoutView];
        [self.pointsLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.pointsLabel setNumberOfLines:1];
        [self.pointsLabel setTextAlignment:NSTextAlignmentLeft];
        [self.pointsLabel setTextColor:pointsColor];
        
        self.seeProfileLabel = [UILabel newAutoLayoutView];
        [self.seeProfileLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.seeProfileLabel setNumberOfLines:1];
        [self.seeProfileLabel setTextAlignment:NSTextAlignmentLeft];
        [self.seeProfileLabel setTextColor:seeProfileButtonTextColor];
        self.seeProfileLabel.text = @"Ver Perfil";
        self.seeProfileLabel.shadowColor = seeProfileButtonTextShadowColor;
        self.seeProfileLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        
        
        [self.contentView addSubview:self.cellBackground];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.photoContainer];
        [self.contentView addSubview:self.pointsContainer];
        [self.contentView addSubview:self.pointsLabel];
        [self.contentView addSubview:self.summaryLabel];
        [self.contentView addSubview:self.phonelabel];
        [self.contentView addSubview:self.streetLabel];
        [self.contentView addSubview:self.coloniaLabel];
        [self.contentView addSubview:self.cityLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.schoolLabel];
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:buttonGradient];
        [self.contentView addSubview:self.seeProfileLabel];
        
        
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
    
    //[self.cellBackground setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:9];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    if ([self.summaryLabel.text isEqualToString:@""] && [self.phonelabel.text isEqualToString:@""]) {
        [self.cellBackground autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:buttonGradient withOffset:10];
        NSLog(@"No hay extracto ni telefono!! : %@", self.nameLabel.text);
    }else{
        [self.cellBackground autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.schoolLabel withOffset:10];
    }
    
    
    
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.cellBackground withOffset:10];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    
    [self.photoContainer setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.photoContainer constrainWidth:@"62" height:@"87"];
    [self.photoContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:5];
    [self.photoContainer autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    //[self.photoContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.photoImageView constrainWidthToView:self.photoContainer predicate:@"*.97"];
    [self.photoImageView constrainHeightToView:self.photoContainer predicate:@"*.98"];
    [self.photoImageView alignCenterWithView:self.photoContainer];
    
    [self.pointsContainer constrainWidthToView:self.photoContainer predicate:@"*1"];
    [self.pointsContainer constrainHeight:@"13"];
    [self.pointsContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.photoContainer];
    [self.pointsContainer autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeft ofView:self.photoContainer];
    
    [self.pointsLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.pointsLabel alignCenterWithView:self.pointsContainer];
    
    [buttonGradient constrainWidthToView:self.pointsContainer predicate:@"*1"];
    [buttonGradient constrainHeight:@"21"];
    [buttonGradient autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pointsContainer];
    [buttonGradient autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeft ofView:self.photoContainer];
    
    [self.seeProfileLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.seeProfileLabel alignCenterWithView:buttonGradient];

    
    
    [self.summaryLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.summaryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:4];
    [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:92];
    [self.summaryLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.nameLabel];
    /*[self.summaryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.photoContainer withOffset:-2];
    [self.summaryLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.photoContainer withOffset:10];
    [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    if ([self.phonelabel.text isEqualToString:@""]) {
        [self.summaryLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.streetLabel withOffset:-10];
        NSLog(@"No phone number!!!!!!!!!!! name: %@", self.nameLabel.text);
    }else{
        [self.summaryLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.phonelabel withOffset:-10];
    }*/
    
    //[self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.phonelabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    if ([self.summaryLabel.text isEqualToString:@""]) {
        [self.phonelabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.photoContainer withOffset:-2];
        [self.phonelabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:92];
    }else{
        [self.phonelabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.summaryLabel withOffset:10];
        [self.phonelabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.summaryLabel];
    }
    //[self.phonelabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeRight ofView:self.photoContainer withOffset:15];
    [self.phonelabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.summaryLabel];
    //[self.phonelabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.streetLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    if ([self.phonelabel.text isEqualToString:@""]) {
        if ([self.summaryLabel.text isEqualToString:@""]) {
            [self.streetLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.photoContainer];
        }else{
            [self.streetLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.summaryLabel];
        }
    }else{
        [self.streetLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phonelabel];
    }
    [self.streetLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.phonelabel];
    [self.streetLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.phonelabel];
    //[self.streetLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.coloniaLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.coloniaLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.streetLabel];
    [self.coloniaLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.streetLabel];
    [self.coloniaLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.streetLabel];
    //[self.coloniaLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [self.cityLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    if ([self.coloniaLabel.text isEqualToString:@""]) {
        [self.cityLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.streetLabel];
    }else{
        [self.cityLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.coloniaLabel];
    }
    [self.cityLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.coloniaLabel];
    [self.cityLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.coloniaLabel];
    [self.cityLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.coloniaLabel];
    //[self.cityLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
 
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.cityLabel withOffset:10];
    [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.cityLabel];
    [self.titleLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.cityLabel];
    //[self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];

    [self.schoolLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.schoolLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel];
    [self.schoolLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.titleLabel];
    [self.schoolLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.titleLabel];
    [self.schoolLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
    
   
    
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
    if (![self.summaryLabel.text isEqualToString:@""]) {
        self.summaryLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.summaryLabel.frame);
    }
    self.streetLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.streetLabel.frame);
    if (![self.coloniaLabel.text isEqualToString:@""]) {
        self.coloniaLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.coloniaLabel.frame);
    }
    self.cityLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.cityLabel.frame);
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.frame);
    self.schoolLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.schoolLabel.frame);
    self.pointsLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.pointsLabel.frame);
    self.seeProfileLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.seeProfileLabel.frame);
}

- (void)updateFonts
{
    
    UIFont *sourceSansProRegular13 = [UIFont fontWithName:@"SourceSansPro-Regular" size:13];
    UIFont *sourceSansProRegular10 = [UIFont fontWithName:@"SourceSansPro-Regular" size:10];
    UIFont *sourceSansProSemibold17 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:17];
    UIFont *sourceSansProSemibold12 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:12];
    UIFont *sourceSansProBold15 = [UIFont fontWithName:@"SourceSansPro-Bold" size:15];
     
    
    
    [self.nameLabel setFont: sourceSansProSemibold17];
    [self.summaryLabel setFont:sourceSansProRegular13];
    [self.phonelabel setFont:sourceSansProBold15];
    [self.streetLabel setFont:sourceSansProRegular13];
    [self.coloniaLabel setFont:sourceSansProRegular13];
    [self.cityLabel setFont:sourceSansProRegular13];
    [self.titleLabel setFont:sourceSansProRegular13];
    [self.schoolLabel setFont:sourceSansProRegular13];
    [self.pointsLabel setFont:sourceSansProRegular10];
    [self.seeProfileLabel setFont:sourceSansProSemibold12];
     
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
