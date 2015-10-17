//
//  ViewController.m
//  luhaoTextViewTest
//
//  Created by luhao on 15/10/17.
//  Copyright © 2015年 vxia. All rights reserved.
//

#import "ViewController.h"
#import "TitleInputTableViewCell.h"

@interface ViewController () <LUHTextViewDelegate, UITableViewDataSource, UITableViewDelegate, TitleInputTableViewCellDelegate>
{
    NSMutableArray *_cellTextData;
}
@property (nonatomic) LUHTextView *textView;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSIndexPath *tempIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _cellTextData = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<10; i++) {
        if (i%2==0) {
            [_cellTextData setObject:[NSString stringWithFormat:@"测试数据%d", i] atIndexedSubscript:i];
        }
        else {
            [_cellTextData setObject:@"" atIndexedSubscript:i];
        }
    }
    
    _textView = [[LUHTextView alloc] initWithFrame:CGRectMake(20, 400, 300, 80)];
    _textView.placeHolderLabel.text = @"自适应高度的 TableView";
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.luhTextViewDelegate = self;
    [self.view addSubview:_textView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 376, 300) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleInputTableViewCell *cell = [[TitleInputTableViewCell alloc] initCellAtIndexPath:indexPath
                                                                        placeHolderTitle:@"占位字符"
                                                                                    text:_cellTextData[indexPath.row]];
    cell.titleInputCellDelegate = self;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [TitleInputTableViewCell calculateText:_cellTextData[indexPath.row]];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - TitleInputTableViewCellDelegate

- (void)heightWillChangedTitleInputCell:(TitleInputTableViewCell *)cell
{
    
}

- (void)heightDidChangedTitleInputCell:(TitleInputTableViewCell *)backcell
{
    [self.tableView reloadRowsAtIndexPaths:@[backcell.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    TitleInputTableViewCell *cell = (TitleInputTableViewCell *)[self.tableView cellForRowAtIndexPath:backcell.indexPath];
    [cell.textView becomeFirstResponder];
}

- (void)cellTextDidChange:(TitleInputTableViewCell *)cell
{
    NSString *cellText = cell.textView.text;
    [_cellTextData replaceObjectAtIndex:cell.indexPath.row withObject:cellText];
}

@end
