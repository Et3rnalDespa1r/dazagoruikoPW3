//
//  AddWishCell.swift
//  dazagoruikoPW3
//
//  Created by Даниил on 10.11.2025.
//
import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId = "AddWishCell"

    var addWish: ((String) -> Void)?

    private enum C {
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: Double = 8
        static let wrapOffsetH: Double = 12
        static let inset: Double = 12
        static let textHeight: Double = 44
        static let buttonHeight: Double = 44
    }

    private let wrap = UIView()
    private let textView = UITextView()
    private let placeholder = UILabel()
    private let button = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(wrap)
        wrap.backgroundColor = .secondarySystemBackground
        wrap.layer.cornerRadius = C.wrapRadius
        wrap.pinVertical(to: contentView, C.wrapOffsetV)
        wrap.pinHorizontal(to: contentView, C.wrapOffsetH)

        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.delegate = self
        wrap.addSubview(textView)

        placeholder.text = "Add wish..."
        placeholder.textColor = .secondaryLabel
        placeholder.font = .systemFont(ofSize: 16)
        wrap.addSubview(placeholder)

        var cfg = UIButton.Configuration.filled()
        cfg.title = "Add"
        cfg.baseBackgroundColor = .systemBlue
        cfg.baseForegroundColor = .white
        cfg.cornerStyle = .medium
        cfg.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        button.configuration = cfg
        button.addTarget(self, action: #selector(addTap), for: .touchUpInside)
        wrap.addSubview(button)

        textView.pinTop(to: wrap.topAnchor, C.inset)
        textView.pinHorizontal(to: wrap, C.inset)
        textView.setHeight(C.textHeight)

        placeholder.pin(to: textView, 8)

        button.pinTop(to: textView.bottomAnchor, C.inset)
        button.pinHorizontal(to: wrap, C.inset)
        button.setHeight(C.buttonHeight)
        button.pinBottom(to: wrap.bottomAnchor, C.inset)
    }

    @objc private func addTap() {
        let t = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty else { return }
        addWish?(t)
        textView.text = ""
        placeholder.isHidden = false
        textView.resignFirstResponder()
    }
}

extension AddWishCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
}
