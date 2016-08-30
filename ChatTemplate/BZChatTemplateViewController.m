//
//  ViewController.m
//  ChatTemplate
//
//  Created by Kun Liu on 30/08/2016.
//  Copyright © 2016 Blitzm System. All rights reserved.
//

#import "BZChatTemplateViewController.h"
#import "BZChatMessageCellTemplate.h"

#define MAXCELLWIDTH 210
#define CELLTEXTFONT [UIFont systemFontOfSize:14]
#define CELLPADDINGS 16
#define CELLMINIMUMHEIGHT 60
#define MESSAGETEXTVIEWHEIGHT 44

@interface BZChatTemplateViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *messagesTableView;
@property (strong, nonatomic) IBOutlet UIView *sendMsgView;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *messageTextViewHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sendMsgViewBottomConstraint;

@property (strong, nonatomic) NSMutableArray *testMessages;
@end

@implementation BZChatTemplateViewController
+ (void)pushChatViewToNavController:(UINavigationController *)navController {
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"BZChatTemplateViewController"
                                                      owner:self
                                                    options:nil];
    
    BZChatTemplateViewController *vc = [nibViews firstObject];

    [navController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _messagesTableView.delegate = self;
    _messagesTableView.dataSource = self;
    
    // Do any additional setup after loading the view.
    [self addDoneToolBarToKeyboard:_messageTextView];
    
    if(_messageTextView.text) {
        [_sendBtn setEnabled:YES];
        [self updateMessageTextViewHeight:_messageTextView.text];
    } else {
        [_sendBtn setEnabled:NO];
    }
    _testMessages = [[NSMutableArray alloc] initWithObjects:@"Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim", @"Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim", @"Lorem ipsum Sit sint offici", @"Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minimLorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minimLorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim", @"Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim Lorem ipsum Sit sint officia minim", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendMsgTapped:(id)sender {
    if (_messageTextView.text != nil) {
        [_testMessages addObject:_messageTextView.text];
        [_messagesTableView beginUpdates];
        NSIndexPath *lastPath = [NSIndexPath indexPathForRow:(_testMessages.count - 1) inSection:0];
        [_messagesTableView insertRowsAtIndexPaths:@[lastPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_messagesTableView endUpdates];
        _messageTextView.text = nil;
        [self updateMessageTextViewHeight:nil];
    }
}

#pragma mark - Utils methods
-(void)addDoneToolBarToKeyboard:(UITextView *)textView
{
    UIToolbar* doneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    doneToolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClickedDismissKeyboard)],
                         nil];
    [doneToolbar sizeToFit];
    textView.inputAccessoryView = doneToolbar;
}

-(void)doneButtonClickedDismissKeyboard
{
    [_messageTextView resignFirstResponder];
}

- (CGFloat)calculateDynamicHeight:(NSString *)str widthConstraint:(CGFloat)width heightConstraint:(CGFloat)height{
    CGRect labelRect = [str
                        boundingRectWithSize:CGSizeMake(width, 2000)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{NSFontAttributeName : CELLTEXTFONT}
                        context:nil];
    if(labelRect.size.height < height) labelRect.size.height = height;
    return labelRect.size.height;
}

- (void)updateMessageTextViewHeight:(NSString *)text {
    if (!text || [text isEqualToString:@""]) {
        _messageTextViewHeightConstraint.constant = MESSAGETEXTVIEWHEIGHT;
        [self.view updateConstraintsIfNeeded];
    } else {
        CGFloat textHeight = [self calculateDynamicHeight:text widthConstraint:_messageTextView.frame.size.width heightConstraint:MESSAGETEXTVIEWHEIGHT];
        
        if(textHeight > MESSAGETEXTVIEWHEIGHT) {
            _messageTextViewHeightConstraint.constant = textHeight;
            [self.view updateConstraintsIfNeeded];
        }
    }
}

#pragma mark - TableViewDelegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _testMessages.count;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self calculateDynamicHeight:[_testMessages objectAtIndex:indexPath.row] widthConstraint:MAXCELLWIDTH heightConstraint:CELLMINIMUMHEIGHT] + CELLPADDINGS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BZChatMessageCellTemplate *cell;
    NSInteger index = indexPath.row % 2;
    if (index != 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"messageCellForReceiver"];
        if (!cell) {
            cell = [BZChatMessageCellTemplate loadBZChatMessageCell:BZMessageCellStyleForReceiver];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"messageCellForSender"];
        if (!cell) {
            cell = [BZChatMessageCellTemplate loadBZChatMessageCell:BZMessageCellStyleForSender];
        }
    }
    cell.messageLbl.text = [_testMessages objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Keyboard Events
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"%@", NSStringFromCGSize(keyboardSize));
    
    //    CGFloat keyboardY = [[UIScreen mainScreen] bounds].size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.frame.size.height - keyboardSize.height;
    CGFloat keyboardY = keyboardSize.height;
    
    _sendMsgViewBottomConstraint.constant = keyboardY;
    //    _tableViewBottomConstraint.constant = keyboardY + _sendMsgView.frame.size.height;
    [self.view updateConstraintsIfNeeded];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    _sendMsgViewBottomConstraint.constant = 0;
    //    _tableViewBottomConstraint.constant = _sendMsgView.frame.size.height;
    [self.view updateConstraintsIfNeeded];
}

- (void)textViewDidChange:(UITextView *)textView {
    if(textView.text != nil) {
        [_sendBtn setEnabled:YES];
        [self updateMessageTextViewHeight:textView.text];
    } else {
        [_sendBtn setEnabled:NO];
    }
}


@end
