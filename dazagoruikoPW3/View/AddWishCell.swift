//
//  AddWishCell.swift
//  dazagoruikoPW3
//
//  Created by Даниил on 10.11.2025.
//
import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId = "AddWishCell"

    private enum C {
        static let wrapColor: UIColor = .secondarySystemBackground
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: Double = 5
        static let wrapOffsetH: Double = 10
        static let labelOffset: Double = 12
    }

    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear

        let wrap = UIView()
        addSubview(wrap)
        wrap.backgroundColor = C.wrapColor
        wrap.layer.cornerRadius = C.wrapRadius
        wrap.pinVertical(to: self, C.wrapOffsetV)
        wrap.pinHorizontal(to: self, C.wrapOffsetH)

        label.text = "Add wish…"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        wrap.addSubview(label)
        label.pin(to: wrap, C.labelOffset)
    }

    required init?(coder: NSCoder) { fatalError() }
}

