//
//  PhotoCollectionViewCell.m
//  day4
//
//  Created by Student on 17.06.15.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "PhotoController.h"
@implementation PhotoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.imageView=[UIImageView new];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame=self.contentView.bounds;
}
-(void)setPhoto:(NSDictionary *)photo{
    _photo = photo;
    [PhotoController imageForPhoto:self.photo size:@"thumbnail" completion:^(UIImage *image) {
        self.imageView.image=image;
    }];
}
@end
