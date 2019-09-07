//
//  Extension.swift
//  NewsAPP
//
//  Created by Srinivasan on 08/09/19.
//  Copyright © 2019 Srinivasan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T:Decodable>{
    var url:URL
}

extension URLRequest{
    
    static func loadResource<T>(resource:Resource<T>)->Observable<T?>{
        return Observable.from([resource.url]).flatMap{ url -> Observable<Data> in
            return URLSession.shared.rx.data(request: self.init(url: url))
            }.map{ data -> T? in
                return try? JSONDecoder().decode(T.self, from: data)
        }
    }
    
}
