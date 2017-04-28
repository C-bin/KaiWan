//
//  EAHero.m
//  ScaryFlight
//
//  Created by Evgeny Karkan on 14.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//

#import "EAHero.h"

static CGFloat const kHeroDirection = 28.5f;

@implementation EAHero;

- (void)flyWithYLimit:(CGFloat)yLimit
{
    NSParameterAssert(yLimit > 0.0f);
    
    if (self.position.y < yLimit - self.size.height / 2.0f) { // <-- avoid hero to fly away from top of screen
        CGFloat heroDirection = self.zRotation + (CGFloat)M_PI_2;
        self.physicsBody.velocity = CGVectorMake(0.0f, 0.0f);
        [self.physicsBody applyImpulse:CGVectorMake(kHeroDirection * cosf((float)heroDirection),
                                                    kHeroDirection * sinf((float)heroDirection))];
    }
    
    [self runAction:[SKAction playSoundFileNamed:@"Jump.wav" waitForCompletion:YES]];
}

@end
