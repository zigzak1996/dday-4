//
//  ViewController.m
//  day4
//
//  Created by Student on 17.06.15.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import <SimpleAuth/SimpleAuth.h>

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic) NSString *accessToken;
@property(nonatomic) NSMutableArray *photos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    self.accessToken=[userDefaults objectForKey:@"accessToken"];
    if(self.accessToken==nil){
        [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error) {
            self.accessToken=responseObject[@"credentials"][@"token"];
            [userDefaults setObject:self.accessToken forKey:@"accessToken"];
            [userDefaults synchronize];
            [self  downloadImages];
        }];
    }
    else {
        [self downloadImages];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - helper methods
-(void)downloadImages{
    NSURLSession * session=[NSURLSession sharedSession];
    NSString *urlString=[[NSString alloc]initWithFormat:@"https://api.instagram.com/v1/tags/cats/media/recent?access_token=%@",self.accessToken];
    NSURL *url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data =[[NSData alloc]initWithContentsOfURL:location];
        NSDictionary *responseDictionary=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        self.photos=responseDictionary[@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    [task resume];
}
#pragma mark - UICollectionView methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photos count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  //  cell.imageView.image=[UIImage imageNamed:@"carimage.jpg"];
    NSDictionary *photo =self.photos[indexPath.row];
    cell.photo=photo;
    return cell;
}
@end
