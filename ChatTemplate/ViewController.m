//
//  ViewController.m
//  ChatTemplate
//
//  Created by Kun Liu on 30/08/2016.
//  Copyright © 2016 Blitzm System. All rights reserved.
//

#import "ViewController.h"
#import "BZChatTemplateViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoChatView:(id)sender {
    [BZChatTemplateViewController pushChatViewToNavController:self.navigationController];
}

@end
