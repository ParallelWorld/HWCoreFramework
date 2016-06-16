//
//  SLHomeCell.m
//  HWCoreFramework
//
//  Created by 58 on 6/15/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLHomeCell.h"
#import "SLHomeCellModel.h"

@interface SLHomeCell ()

@property (nonatomic, weak) SLHomeCellModel *cellModel;

@end

@implementation SLHomeCell

@dynamic cellModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.myLabel];
        
        [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)updateCell {
    [super updateCell];
    
    self.myLabel.text = self.cellModel.title;
}

- (UILabel *)myLabel {
    if (!_myLabel) {
        _myLabel = [UILabel new];
    }
    return _myLabel;
}

@end
