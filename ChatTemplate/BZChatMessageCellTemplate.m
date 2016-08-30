//
//  BZChatMessageCellTemplate.m
//  ChatTemplate
//
//  Created by Kun Liu on 30/08/2016.
//  Copyright © 2016 Blitzm System. All rights reserved.
//

#import "BZChatMessageCellTemplate.h"

@interface BZChatMessageCellTemplate()

@property (nonatomic, assign) BZMessageCellStyle style;
@end

@implementation BZChatMessageCellTemplate

+ (BZChatMessageCellTemplate *)loadBZChatMessageCell:(BZMessageCellStyle)style {
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"BZChatMessageCellTemplate"
                                                      owner:self
                                                    options:nil];
    
    BZChatMessageCellTemplate *cell;
    switch (style) {
        case BZMessageCellStyleForSender:
            cell = [nibViews lastObject];
            break;
        case BZMessageCellStyleForReceiver:
            cell = [nibViews firstObject];
            break;
        default:
            cell = [nibViews firstObject];
            break;
    }
    cell.style = style;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
