//
//  UIFont+Ext.swift
//  MyTeams
//
//  Created by Martin Bucko on 02/01/2022.
//

import UIKit

extension UIFont {

    func withTraits(traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        var symTraits = fontDescriptor.symbolicTraits
        traits.forEach { if !symTraits.contains($0) { symTraits.insert($0) } }
        guard let descriptor = fontDescriptor.withSymbolicTraits(symTraits) else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }

    func boldItalic() -> UIFont {
        return withTraits(traits: .traitBold, .traitItalic)
    }
    
    func withoutTraits(traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        var symTraits = fontDescriptor.symbolicTraits
        traits.forEach { if symTraits.contains($0) { symTraits.remove($0) } }
        guard let descriptor = fontDescriptor.withSymbolicTraits(symTraits) else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func removeBold() -> UIFont {
        return withoutTraits(traits: .traitBold)
    }

    func removeItalic() -> UIFont {
        return withoutTraits(traits: .traitItalic)
    }
    
    func removeBoldItalic() -> UIFont {
        return withoutTraits(traits: .traitBold, .traitItalic)
    }

}
