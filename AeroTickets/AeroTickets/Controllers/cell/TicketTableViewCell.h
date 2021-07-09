//
//  TicketTableViewCell.h
//  AeroTickets
//
//  Created by Pavel Khlebnikov on 08.07.2021.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"
#import "FavoriteTiket+CoreDataClass.h"
#import "FavoriteMapPrice+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, strong) FavoriteTiket *favoriteTicket;
@property (nonatomic, strong) FavoriteMapPrice *favoriteMapPrice;

@end

NS_ASSUME_NONNULL_END
