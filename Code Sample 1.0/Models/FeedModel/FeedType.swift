//
//  FeedType.swift
//  p153-ios
//
//  Created by ihor-ios on 15.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit

enum FeedType: String, Decodable {
    case profileFilterUpdated = "PROFILE_FILTER_UPDATE"
    case profileUpdated = "PROFILE_UPDATE"
    case profileNew = "PROFILE_NEW"
    case videoUpload = "VIDEO_UPLOAD"
    case profilePhotoUpload = "PROFILE_PHOTO_UPLOAD"
    case albumPhotoUpload = "ALBUM_PHOTO_UPLOAD"
    case coverPhotoChange = "COVER_PHOTO_CHANGE"
    case statusUpdated = "STATUS_UPDATE"
    case profilePersonal = "PROFILE_PERSONAL"
    case profileInterests = "PROFILE_INTERESTS"
    case profileVerify = "PROFILE_VERIFY"
    case plusMember = "PLUS_MEMBER"
    case newProfileStupsler1 = "NEW_PROFILE_STUPSLER1"
    case newProfileStupsler2 = "NEW_PROFILE_STUPSLER2"
    case newProfileChat1 = "NEW_PROFILE_CHAT1"
    case newProfileChat2 = "NEW_PROFILE_CHAT2"
    case newProfileChat3 = "NEW_PROFILE_CHAT3"
    case newProfileVisit = "NEW_PROFILE_VISIT"
    case newProfileLike1 = "NEW_PROFILE_LIKE1"
    case newProfileLike2 = "NEW_PROFILE_LIKE2"
    case newProfileLike3 = "NEW_PROFILE_LIKE3"
    case newProfileLike4 = "NEW_PROFILE_LIKE4"
}
