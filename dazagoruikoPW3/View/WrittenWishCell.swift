//
//  WrittenWishCell.swift
//  dazagoruikoPW3
//
//  Created by Даниил on 10.11.2025.
//
import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId = "WrittenWishCell"

    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: Double = 5
        static let wrapOffsetH: Double = 10
        static let wishLabelOffset: Double = 8
    }

    private let wishLabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with wish: String) {
        wishLabel.text = wish
    }

    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear

        let wrap = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        
        wrap.addSubview(wishLabel)
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)
    }
}
