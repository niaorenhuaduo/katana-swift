//
//  NativeButton.swift
//  Katana
//
//  Copyright © 2016 Bending Spoons.
//  Distributed under the MIT License.
//  See the LICENSE file for more information.


public typealias ClickHandlerClosure = () -> ()

public class NativeButton: NSButton {
  
  // MARK: - backgroundColor
  
  public var backgroundColor: NSColor = NSColor.white {
    didSet {
      self.needsDisplay = true
    }
  }
  
  public var backgroundHighlightedColor: NSColor = NSColor.white {
    didSet {
      self.needsDisplay = true
    }
  }
  
  // MARK: - clickHandler
  
  public var clickHandler: ClickHandlerClosure? {
    didSet {
      updateTarget()
    }
  }
  
  private func updateTarget() {
    self.target = self
    self.action = #selector(click)
  }
  
  @objc private func click() {
    clickHandler?()
  }
  
  // MARK: - updates
  
  override public var wantsUpdateLayer: Bool {
    return true
  }
  
  override public func updateLayer() {
    if let cell = self.cell, cell.isHighlighted {
      self.layer?.backgroundColor = self.backgroundHighlightedColor.cgColor
    } else {
      self.layer?.backgroundColor = self.backgroundColor.cgColor
    }
  }
  
  // MARK: - coordinate system
  
  // In Katana macOS we stick with the iOS coordinate system
  override public var isFlipped: Bool {
    return true
  }
  
}
