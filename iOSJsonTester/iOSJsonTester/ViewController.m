//
//  ViewController.m
//  iOSJsonTester
//
//  Created by Adam Chin on 10/18/16.
//  Copyright © 2016 hushbox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *URL = [NSURL URLWithString:@"http://ip.jsontest.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (!error) {
                                          __block NSDictionary *json;
                                          json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          NSLog(@"response: %@",json);
                                      } else NSLog(@"Error : %@",[error localizedDescription]);
                                      
                                  }];
    
    [task resume];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
