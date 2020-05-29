//
//  CallViewModel.swift
//  DAPNET
//
//  Created by Thomas Gatzweiler on 26.05.20.
//  Copyright © 2020 Thomas Gatzweiler. All rights reserved.
//

import Foundation

class CallViewModel: ObservableObject {
    @Published public private(set) var calls: [Call] = [];
    @Published public private(set) var loading: Bool = false;
    
    private var request: AnyObject?;
    
    init(calls: [Call]? = nil) {
        if calls == nil {
            let req: ApiRequest<CallResource> = ApiRequest(resource: CallResource());
            request = req
            loading = true
            req.load { [weak self] (calls: [Call]?) in
                if calls != nil {
                    self?.calls = calls!
                    self?.loading = false
                }
            };
        }
        else {
            self.loading = false
            self.calls = calls!
        }
    }
}
