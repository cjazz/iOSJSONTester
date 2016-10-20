//
//  ViewController.m
//  iOSJsonTester
//
//  Created by Adam Chin on 10/18/16.
//  Copyright © 2016 hushbox. All rights reserved.
//

#import "ViewController.h"
#define HTTP_BIGLEAGUE_ISSUE 202
#define OFFERS_LOCATION [NSURL URLWithString:@"http://www.hushboxlive.com/offers.json"]


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCurrentOffers];
}

-(void)loadCurrentOffers
{
    NSURL *URL = OFFERS_LOCATION;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                      
                                      if ((long)[httpResponse statusCode] > HTTP_BIGLEAGUE_ISSUE)
                                      {
                                          return;
                                      }
                                      
                                      if (!error) {
                                          
                                          NSString *fileName = @"offers.json";
                                          
                                          if (data)
                                          {
                                              NSFileManager* fm = [NSFileManager new];
                                              NSError* err = nil;
                                              NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                                                          inDomain:NSUserDomainMask
                                                                 appropriateForURL:nil
                                                                            create:YES
                                                                             error:&err];
                                              NSURL *jsonFolder = [docsurl URLByAppendingPathComponent:@"json"];
                                              
                                              
                                              if ([fm createDirectoryAtURL:jsonFolder
                                               withIntermediateDirectories:YES
                                                                attributes:nil
                                                                     error:&err])
                                              {
                                                  NSURL *fileURL = [jsonFolder URLByAppendingPathComponent:fileName];
                                                  
                                                  if ([data writeToURL:fileURL options:NSDataWritingAtomic error:&err])
                                                  {
                                                      NSLog(@"file saved :%@",fileName);
                                                  }
                                                  else
                                                  {
                                                      NSLog(@"file not saved :%@ error: %@",fileName, err);
                                                  }
                                              }
                                          }
                                          
                                      } else NSLog(@"Error : %@",[error localizedDescription]);
                                      
                                  }];
    [task resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
