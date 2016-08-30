//
//  BZChatMessageCellTemplate.h
//  ChatTemplate
//
//  Created by Kun Liu on 30/08/2016.
//  Copyright © 2016 Blitzm System. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BZMessageCellStyleForReceiver,
    BZMessageCellStyleForSender,
} BZMessageCellStyle;

@interface BZChatMessageCellTemplate : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *senderImage;
@property (strong, nonatomic) IBOutlet UILabel *messageLbl;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;

+ (BZChatMessageCellTemplate *)loadBZChatMessageCell:(BZMessageCellStyle)style;
@end
