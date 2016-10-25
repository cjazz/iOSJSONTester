//
//  OffersVC.m
//  iOSJsonTester
//
//  Created by Adam Chin on 10/24/16.
//  Copyright © 2016 hushbox. All rights reserved.
//

#import "OffersVC.h"



@interface OffersVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OffersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _closeButton.layer.cornerRadius = 5;
    _closeButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.receivedOffers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSDictionary *offer = self.receivedOffers[indexPath.row];
                               
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.text = [offer valueForKey:@"title"];
        
    }
    return cell;
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
