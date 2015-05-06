//
//  RootViewController.m
//  ChangeViewControllerDemo
//
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) NSDictionary *controllers;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"first" style:UIBarButtonItemStylePlain target:self action:@selector(changeView)];
    self.navigationItem.leftBarButtonItem = _leftBarButtonItem;
    
    [self setUpViewControllers];
    [self changeView];
}

- (void)setUpViewControllers {
    UIViewController *firstController = [[FirstViewController alloc] init];
    UIViewController *secondController = [[SecondViewController alloc] init];
    _controllers = @{@"first": firstController,
                     @"second": secondController};
}

- (void)changeView {
    if (_currentViewController) {
        [_currentViewController willMoveToParentViewController:nil];
        [_currentViewController.view removeFromSuperview];
        [_currentViewController removeFromParentViewController];
    }
    
    NSString *key = self.navigationItem.leftBarButtonItem.title;
    self.title = key;
    _currentViewController = _controllers[key];
    [self addChildViewController:_currentViewController];
    [self.view addSubview:_currentViewController.view];
    [self didMoveToParentViewController:_currentViewController];
    
    self.navigationItem.leftBarButtonItem.title = [key isEqualToString:@"first"] ? @"second" : @"first";
}



@end
