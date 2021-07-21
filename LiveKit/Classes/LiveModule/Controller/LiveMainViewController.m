//
//  LiveMainViewController.m
//  PrivateTest
//
//  Created by don on 2021/7/19.
//

#import "LiveMainViewController.h"
#import <Masonry/Masonry.h>

@interface LiveMainViewController ()

@end

@implementation LiveMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)setupViews{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    [imageView setImage: [UIImage imageNamed:@"公路"]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(CGSizeMake(100, 100)));
        make.center.equalTo(self.view);
    }];
    NSString *titleStr = [self.dict objectForKey:@"title"];
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)btnClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}

@end
