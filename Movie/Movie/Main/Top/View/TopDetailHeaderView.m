//
//  TopDetailHeaderView.m
//  Movie
//
//  Created by ZhugeZhan on 16/4/9.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "TopDetailHeaderView.h"

@implementation TopDetailHeaderView

- (void)setModel:(TopDetailHeaderModel *)model {
    _model = model;
    
    [_movieImageView sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:[UIImage imageNamed:@"pig"]];
    _movieTitleLabel.text = _model.titleCn;
    _enTitleLabel.text = _model.titleEn;
    _movieContentTextView.text = _model.content;
    
    NSDictionary *dic1 = _model.videos[0];
    NSString *imgUrl1 = dic1[@"image"];
    UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl1]]];
    [_button1 setImage:img1 forState:UIControlStateNormal];
    
    NSDictionary *dic2 = _model.videos[1];
    NSString *imgUrl2 = dic2[@"image"];
    UIImage *img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl2]]];
    [_button2 setImage:img2 forState:UIControlStateNormal];
    
    NSDictionary *dic3 = _model.videos[2];
    NSString *imgUrl3 = dic3[@"image"];
    UIImage *img3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl3]]];
    [_button3 setImage:img3 forState:UIControlStateNormal];
    
    NSDictionary *dic4 = _model.videos[3];
    NSString *imgUrl4 = dic4[@"image"];
    UIImage *img4 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl4]]];
    [_button4 setImage:img4 forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
}

- (IBAction)button:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    NSDictionary *dic = _model.videos[index];
    NSString *url = dic[@"url"];
    
    AVPlayerViewController *movierPlayer = [[AVPlayerViewController alloc] init];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:url]];
    movierPlayer.player = player;
    [player play];

    //获取到最底层的viewController
    [self.viewController presentViewController:movierPlayer animated:YES completion:nil];
}


@end
