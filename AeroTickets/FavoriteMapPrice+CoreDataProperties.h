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

@property (nullable, nonatomic, copy) NSString *from;
@property (nullable, nonatomic, copy) NSString *to;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nonatomic) int16_t numberOfChanges;
@property (nonatomic) int32_t value;
@property (nonatomic) int64_t distance;
@property (nonatomic) BOOL actual;

@end

NS_ASSUME_NONNULL_END
