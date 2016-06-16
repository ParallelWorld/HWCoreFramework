//
//  HWUtilsMacro.h
//  HWCoreFramework
//
//  Created by 58 on 6/15/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#ifndef HWUtilsMacro_h
#define HWUtilsMacro_h

/**
 Synthsize a weak or strong reference.
 
 Example:
 HY_WEAKIFY(self)
 [self doSomething^{
 HY_STRONGIFY(self)
 if (!self) return;
 ...
 }];
 */
#ifndef HW_WEAKIFY
#define HW_WEAKIFY(object) __weak __typeof__(object) weak##_##object = object;
#endif

#ifndef HW_STRONGIFY
#define HW_STRONGIFY(object) __typeof__(object) object = weak##_##object;
#endif

#endif /* HWUtilsMacro_h */
