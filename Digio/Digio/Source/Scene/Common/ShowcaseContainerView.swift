/*
See LICENSE folder for this sample’s licensing information.

Abstract:
This file contains both the carousel container view class, and a definition for the subclass
            of `UIAccessibilityElement` we use to represent the carousel.
*/

import UIKit

class CarouselAccessibilityElement: UIAccessibilityElement {
    var currentItem: ImagePresentationViewModel?
    
    init(accessibilityContainer: Any, item: ImagePresentationViewModel?) {
        super.init(accessibilityContainer: accessibilityContainer)
        currentItem = item
    }

    /// This indicates to the user what exactly this element is supposed to be.
    override var accessibilityLabel: String? {
        get {
            return "Banner"
        }
        set {
            super.accessibilityLabel = newValue
        }
    }

    override var accessibilityValue: String? {
        get {
            if let currentItem = currentItem {
                return currentItem.title
            }
            return super.accessibilityValue
        }

        set {
            super.accessibilityValue = newValue
        }
    }

    // This tells VoiceOver that our element will support the increment and decrement callbacks.
    /// - Tag: accessibility_traits
    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return .adjustable
        }
        set {
            super.accessibilityTraits = newValue
        }
    }

    /**
        A convenience for forward scrolling in both `accessibilityIncrement` and `accessibilityScroll`.
        It returns a `Bool` because `accessibilityScroll` needs to know if the scroll was successful.
    */
    func accessibilityScrollForward() -> Bool {

        guard let containerView = accessibilityContainer as? ShowcaseCarouselContainerView else {
            return false
        }
        
        guard let currentItem = currentItem, let items = containerView.items else {
            return false
        }

        // Get the index of the currently focused.
        guard let index = items.firstIndex(of: currentItem), index < items.count - 1 else {
            return false
        }

        // Scroll the collection view to the currently focused dog.
        containerView.collectionView.scrollToItem(
            at: IndexPath(row: index + 1, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
        
        return true
    }

    /**
        A convenience for backward scrolling in both `accessibilityIncrement` and `accessibilityScroll`.
        It returns a `Bool` because `accessibilityScroll` needs to know if the scroll was successful.
    */
    func accessibilityScrollBackward() -> Bool {
        guard let containerView = accessibilityContainer as? ShowcaseCarouselContainerView else {
            return false
        }

        guard let currentItem = currentItem, let items = containerView.items else {
            return false
        }

        guard let index = items.firstIndex(of: currentItem), index > 0 else {
            return false
        }

        containerView.collectionView.scrollToItem(
            at: IndexPath(row: index - 1, section: 0),
            at: .centeredHorizontally,
            animated: true
        )

        return true
    }

    // MARK: Accessibility

    /*
        Overriding the following two methods allows the user to perform increment and decrement actions
        (done by swiping up or down).
    */
    /// - Tag: accessibility_increment_decrement
    override func accessibilityIncrement() {
        // This causes the picker to move forward one if the user swipes up.
        _ = accessibilityScrollForward()
    }
    
    override func accessibilityDecrement() {
        // This causes the picker to move back one if the user swipes down.
        _ = accessibilityScrollBackward()
    }

    /*
        This will cause the picker to move forward or backwards on when the user does a 3-finger swipe,
        depending on the direction of the swipe. The return value indicates whether or not the scroll was successful,
        so that VoiceOver can alert the user if it was not.
    */
    override func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
        if direction == .left {
            return accessibilityScrollForward()
        } else if direction == .right {
            return accessibilityScrollBackward()
        }
        return false
    }

}

/**
    The carousel container is a container view for the carousel collection view and the favorite and gallery button.
    We subclass it so that we can override its `accessibilityElements` to exclude the collection view
    and use our custom element instead, and so that we can add and remove the gallery buton as
    an accessibility element as it appears and disappears.
*/
class ShowcaseCarouselContainerView: UIView {
    // MARK: Properties
    var collectionView: UICollectionView = UICollectionView()

    var currentItem: ImagePresentationViewModel? {
        didSet {
            _accessibilityElements = nil

            if let currentItem = currentItem, let carouselAccessibilityElement = carouselAccessibilityElement {
                carouselAccessibilityElement.currentItem = currentItem
            }
        }
    }

    var items: [ImagePresentationViewModel]?

    // MARK: Accessibility

    var carouselAccessibilityElement: CarouselAccessibilityElement?

    // Like in the `DogStatsView`, we need to cache `accessibilityElements`. See that file for an explanation why.
    /// - Tag: using_carousel_accessibility_element
    private var _accessibilityElements: [Any]?

    override var accessibilityElements: [Any]? {
        set {
            _accessibilityElements = newValue
        }

        get {
            guard _accessibilityElements == nil else {
                return _accessibilityElements
            }

            guard let currentItem = currentItem else {
                return _accessibilityElements
            }

            let carouselAccessibilityElement: CarouselAccessibilityElement
            if let theCarouselAccessibilityElement = self.carouselAccessibilityElement {
                carouselAccessibilityElement = theCarouselAccessibilityElement
            } else {
                carouselAccessibilityElement = CarouselAccessibilityElement(
                    accessibilityContainer: self,
                    item: currentItem
                )
                
                carouselAccessibilityElement.accessibilityFrameInContainerSpace = collectionView.frame
                self.carouselAccessibilityElement = carouselAccessibilityElement
            }

            // Only show the gallery button if we have multiple images.
            _accessibilityElements = [carouselAccessibilityElement]
            return _accessibilityElements
        }
    }
}
