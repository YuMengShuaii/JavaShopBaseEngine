//
//  BlockMethods.swift
//  JavashopBaseEngine
//
//  Created by LDD on 2017/10/7.
//  Copyright © 2017年 LDD. All rights reserved.
//

public typealias JavaShopMethod<Out> = (() -> (Out))

public typealias JavaShopMethod1<In1,Out> = ((In1) ->(Out))

public typealias JavaShopMethod2<In1,In2,Out> =  ((In1,In2) -> (Out))

public typealias JavaShopMethod3<In1,In2,In3,Out> =  ((In1,In2,In3) -> (Out))

public typealias JavaShopMethod4<In1,In2,In3,In4,Out> =  ((In1,In2,In3,In4) -> (Out))

public typealias JavaShopMethod5<In1,In2,In3,In4,In5,Out> =  ((In1,In2,In3,In4,In5) -> (Out))

public typealias JavaShopMethod6<In1,In2,In3,In4,In5,In6,Out> =  ((In1,In2,In3,In4,In5,In6) -> (Out))

public typealias JavaShopMethod7<In1,In2,In3,In4,In5,In6,In7,Out> =  ((In1,In2,In3,In4,In5,In6,In7) -> (Out))

public typealias JavaShopMethod8<In1,In2,In3,In4,In5,In6,In7,In8,Out> =  ((In1,In2,In3,In4,In5,In6,In7,In8) -> (Out))

public typealias JavaShopMethod9<In1,In2,In3,In4,In5,In6,In7,In8,In9,Out> =  ((In1,In2,In3,In4,In5,In6,In7,In8,In9) -> (Out))

public typealias JavaShopVoidMethod = (() -> ())

public typealias JavaShopVoidMethod1<In1> = ((In1) ->())

public typealias JavaShopVoidMethod2<In1,In2> =  ((In1,In2) -> ())

public typealias JavaShopVoidMethod3<In1,In2,In3> =  ((In1,In2,In3) -> ())

public typealias JavaShopVoidMethod4<In1,In2,In3,In4> =  ((In1,In2,In3,In4) -> ())

public typealias JavaShopVoidMethod5<In1,In2,In3,In4,In5> =  ((In1,In2,In3,In4,In5) -> ())

public typealias JavaShopVoidMethod6<In1,In2,In3,In4,In5,In6> =  ((In1,In2,In3,In4,In5,In6) -> ())

public typealias JavaShopVoidMethod7<In1,In2,In3,In4,In5,In6,In7> =  ((In1,In2,In3,In4,In5,In6,In7) -> ())

public typealias JavaShopVoidMethod8<In1,In2,In3,In4,In5,In6,In7,In8> =  ((In1,In2,In3,In4,In5,In6,In7,In8) -> ())

public typealias JavaShopVoidMethod9<In1,In2,In3,In4,In5,In6,In7,In8,In9> =  ((In1,In2,In3,In4,In5,In6,In7,In8,In9) -> ())
