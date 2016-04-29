//
//  JJUserCenterView.m
//  JiaJia
//
//  Created by jojoting on 16/4/20.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "JJUserCenterView.h"

#define leftMargin 15
#define divisionMargin 20
#define userInfoHeight 65
#define userAvatarImageViewWidth 65
#define userNameLabelWidth 130
#define divisionViewWidth (self.slideView.frame.size.width - leftMargin)
#define buttonImageWidth 20
#define buttonWidth (self.slideView.frame.size.width - leftMargin)
#define buttonHeight 50

@interface JJUserCenterView ()

@property (nonatomic, strong) UIView        *userInfoView;
@property (nonatomic, strong) UIImageView   *userAvatarImageView;
@property (nonatomic ,strong) UILabel       *userNameLabel;
@property (nonatomic, strong) UIView        *divisionView1;
@property (nonatomic, strong) UIView        *divisionView2;
@property (nonatomic, strong) UIButton      *journeyRecordButton;
@property (nonatomic, strong) UIButton      *couponButton;
@property (nonatomic, strong) UIButton      *messageCenterButton;
@property (nonatomic, strong) UIButton      *aboutButton;

@end

@implementation JJUserCenterView

#pragma mark - init
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    [self.userInfoView addSubview:self.userAvatarImageView];
    [self.userInfoView addSubview:self.userNameLabel];
    [self.slideView addSubview:self.userInfoView];
    [self.slideView addSubview:self.divisionView1];
    [self.slideView addSubview:self.journeyRecordButton];
    [self.slideView addSubview:self.aboutButton];
    [self.slideView addSubview:self.messageCenterButton];
    [self.slideView addSubview:self.couponButton];
    [self.slideView addSubview:self.divisionView2];
}


- (void)layoutSubviews{
    self.userInfoView.frame = CGRectMake(leftMargin, 50, divisionViewWidth, userInfoHeight);
    self.userAvatarImageView.frame = CGRectMake(0, 0, userAvatarImageViewWidth, userAvatarImageViewWidth);
    self.userNameLabel.frame = CGRectMake(self.userAvatarImageView.frame.origin.x + userAvatarImageViewWidth + 10, 0, userNameLabelWidth, userAvatarImageViewWidth);
    self.userAvatarImageView.layer.cornerRadius = _userAvatarImageView.frame.size.width / 2;

    CGFloat divisionView1PositionY = self.userInfoView.frame.origin.y + userAvatarImageViewWidth + divisionMargin;
    self.divisionView1.frame = CGRectMake(leftMargin, divisionView1PositionY, divisionViewWidth, 1.f);
    
    self.journeyRecordButton.frame = CGRectMake(leftMargin, divisionView1PositionY + divisionMargin,buttonWidth , buttonHeight);
    self.couponButton.frame = CGRectMake(leftMargin, self.journeyRecordButton.frame.origin.y + buttonHeight, buttonWidth, buttonHeight);
    self.messageCenterButton.frame = CGRectMake(leftMargin, self.couponButton.frame.origin.y + buttonHeight, buttonWidth, buttonHeight);
    
    CGFloat divisionView2PositionY = self.messageCenterButton.frame.origin.y + buttonHeight + divisionMargin;
    self.divisionView2.frame = CGRectMake(leftMargin, divisionView2PositionY, divisionViewWidth, 1.f);
    
    self.aboutButton.frame = CGRectMake(leftMargin, divisionView2PositionY + divisionMargin, buttonWidth, buttonHeight);

}

#pragma mark - private methods

- (UIView *)divisionView{
    UIView *divisionView = [[UIView alloc] init];
    divisionView.backgroundColor = [UIColor lightGrayColor];
    return divisionView;
}

- (UIButton *)buttonWithImageName:(NSString *)imageName tittle:(NSString *)tittle index:(NSInteger )index{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:tittle forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, buttonImageWidth, 0, 0);
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.tag = index;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)buttonClicked:(UIButton *)sender{
    NSInteger index = sender.tag;
    if ([self.delegate respondsToSelector:@selector(userCenterView:buttonClickedAtIndex:)]) {
        [self.delegate userCenterView:self buttonClickedAtIndex:index];
    }
}

- (void)tapUserInfoView:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(didSelectUserInfoWithUserCenterView:)]) {
        [self.delegate didSelectUserInfoWithUserCenterView:self];
    }
}
#pragma mark - getter

- (UIView *)userInfoView{
    if (!_userInfoView) {
        _userInfoView = [[UIView alloc] init];
        _userInfoView.userInteractionEnabled = YES;
        [_userInfoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserInfoView:)]];
    }
    return _userInfoView;
}
- (UIImageView *)userAvatarImageView{
    if (!_userAvatarImageView) {
        _userAvatarImageView = [[UIImageView alloc] init];
        _userAvatarImageView.backgroundColor = [UIColor lightGrayColor];
        _userAvatarImageView.layer.masksToBounds = YES;
    }
    return _userAvatarImageView;
}

- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        [_userNameLabel setText:@"journey han"];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        [_userNameLabel setTextColor:[UIColor lightGrayColor]];
    }
    return _userNameLabel;
}

- (UIView *)divisionView1{
    if (!_divisionView1) {
        _divisionView1 = [self divisionView];
    }
    return _divisionView1;
}

- (UIView *)divisionView2{
    if (!_divisionView2) {
        _divisionView2 = [self divisionView];
    }
    return _divisionView2;
}

- (UIButton *)journeyRecordButton{
    if (!_journeyRecordButton) {
        _journeyRecordButton = [self buttonWithImageName:@"buttonImage" tittle:@"行程记录" index:0];
    }
    return _journeyRecordButton;
}

- (UIButton *)couponButton{
    if (!_couponButton) {
        _couponButton = [self buttonWithImageName:@"buttonImage" tittle:@"优惠券" index:1];
    }
    return _couponButton;
}

- (UIButton *)messageCenterButton{
    if (!_messageCenterButton) {
        _messageCenterButton = [self buttonWithImageName:@"buttonImage" tittle:@"消息中心" index:2];
    }
    return _messageCenterButton;
}

- (UIButton *)aboutButton{
    if (!_aboutButton) {
        _aboutButton = [self buttonWithImageName:@"buttonImage" tittle:@"关于" index:3];;
    }
    return _aboutButton;
}

@end