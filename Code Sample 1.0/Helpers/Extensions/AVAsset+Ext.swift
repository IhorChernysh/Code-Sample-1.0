//
//  AVAsset+Ext.swift
//  p153-ios
//
//  Created by ihor-ios on 12.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit
import AVFoundation

extension AVAsset {
    func videoSize()-> CGSize {
        let tracks = self.tracks(withMediaType: AVMediaType.video)
        if (tracks.count > 0){
            let videoTrack = tracks[0]
            let size = videoTrack.naturalSize
            let txf = videoTrack.preferredTransform
            let realVidSize = size.applying(txf)
            return realVidSize
        }
        return CGSize(width: 0, height: 0)
    }

}
