//
//  LoginConfig.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 21/10/25.
//

import Foundation

public struct LoginConfigResponse: Codable {
    public let success: Bool
    public let message: String
    public let data: LoginConfigData
}

public struct LoginConfigData: Codable {
    public let id: String
    public let background: BackgroundConfig?
    public let card: CardConfig?
    public let bottomSheet: BottomSheetConfig?
    public let captcha: CaptchaConfig?
}

public struct BackgroundConfig: Codable {
    public let show: Bool
    public let color: String?
    public let image: ImageConfig?
}

public struct ImageConfig: Codable {
    public let url: String?
    public let fit: String?
    public let position: String?
}

public struct CardConfig: Codable {
    public let show: Bool
    public let layout: String?
    public let title: String?
    public let subtitle: String?
    public let button: ButtonConfig?
    public let horizontalTexts: [HorizontalTextConfig]?
}

public struct ButtonConfig: Codable {
    public let text: String
    public let url: String?
    public let style: String?
    public let backgroundColor: String?
    public let enabled: Bool?
}

public struct HorizontalTextConfig: Codable {
    public let title: String
    public let button: ButtonConfig?
}

public struct BottomSheetConfig: Codable {
    public let title: String?
    public let fields: [FieldConfig]?
    public let buttons: [ButtonConfig]
}

public struct FieldConfig: Codable {
    public let type: String
    public let name: String
    public let hint: String?
    public let leadingIcon: String?
    public let trailingIcon: String?
    public let border: Bool?
}

public struct CaptchaConfig: Codable {
    public let show: Bool
    public let provider: String?
    public let siteKey: String?
    public let position: String?
    public let theme: String?
    public let threshold: Double?
}
