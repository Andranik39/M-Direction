//
//  Languages.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 17.06.2021.
//

import UIKit

final class Languages: SegmentControl {
    override func setupSubviews() {
        container.spacing = 23
        
        for model in languageModels {
            let language = LanguageSegment()
            language.delegate = self
            language.setup(with: model)
            container.addArrangedSubview(language)
        }
    }
}
