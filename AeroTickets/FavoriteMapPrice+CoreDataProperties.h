//
//  FavoriteMapPrice+CoreDataProperties.h
//  AeroTickets
//
//  Created by Pavel Khlebnikov on 09.07.2021.
//
//

#import "FavoriteMapPrice+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteMapPrice (CoreDataProperties)

+ (NSFetchRequest<FavoriteMapPrice *> *)fetchRequest;

@property (nonatomic) BOOL actual;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nonatomic) int64_t distance;
@property (nullable, nonatomic, copy) NSString *from;
@property (nonatomic) int16_t numberOfChanges;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nullable, nonatomic, copy) NSString *to;
@property (nonatomic) int64_t price;

@end

NS_ASSUME_NONNULL_END
