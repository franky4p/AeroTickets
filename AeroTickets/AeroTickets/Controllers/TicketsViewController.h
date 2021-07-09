//
//  TicketsViewController.h
//  AeroTickets
//
//  Created by Pavel Khlebnikov on 08.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;
- (instancetype)initFavoriteTicketsController;
- (instancetype)initFavoriteMapPriceController;

@end

NS_ASSUME_NONNULL_END
