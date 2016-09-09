//
//  SLTable1Cell.m
//  HWCoreFramework
//
//  Created by 58 on 9/8/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLTable1Cell.h"
#import "SLTable1CellModel.h"

HW_DEFINITION(SLTable1CellCheckButtonTapAction);

@interface SLTable1Cell ()
@property (nonatomic, strong) UILabel *myTitleLabel;
@property (nonatomic, strong) UIButton *checkButton;
@end

@implementation SLTable1Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.myTitleLabel];
        [self.contentView addSubview:self.checkButton];
        [self.myTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.checkButton.mas_left).offset(-10);
        }];
        [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
    }
    return self;
}

- (void)configureCellWithModel:(SLTable1CellModel *)cellModel {
    [super configureCellWithModel:cellModel];
    self.myTitleLabel.text = cellModel.title;
    [self.checkButton addTarget:self action:@selector(tapCheckButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapCheckButton:(UIButton *)button {
    [self.actionDelegate actionFromView:self eventIdentifier:SLTable1CellCheckButtonTapAction context:nil];
}

- (UILabel *)myTitleLabel {
    if (!_myTitleLabel) {
        _myTitleLabel = [UILabel new];
        _myTitleLabel.textColor = [UIColor blueColor];
    }
    return _myTitleLabel;
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton new];
        [_checkButton setTitle:@"check" forState:UIControlStateNormal];
        [_checkButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _checkButton;
}

@end
