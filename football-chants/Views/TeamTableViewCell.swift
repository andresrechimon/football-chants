//
//  TeamTableViewCell.swift
//  football-chants
//
//  Created by Andrés Rechimon on 19/01/2024.
//

import UIKit

protocol TeamTableViewCellDelegate: class {
    func didTapPlayback(for team: Team)
}

class TeamTableViewCell: UITableViewCell {
    static let cellID = "TeamTableViewCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        stack.axis = .vertical
        
        return stack
    }()
    
    private lazy var badgeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var playbackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var foundedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var jobLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.team = nil
        self.delegate = nil
        self.contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private weak var delegate: TeamTableViewCellDelegate?
    private var team: Team?
    
    func configure(with item: Team, delegate: TeamTableViewCellDelegate){
        self.team = item
        self.delegate = delegate
        containerView.backgroundColor = item.id.background
        nameLabel.text = item.name
        foundedLabel.text = item.founded
        jobLabel.text = "\(item.manager.job.rawValue): \(item.manager.name)"
        infoLabel.text = item.info
        badgeImageView.image = item.id.badge
        playbackButton.setImage(item.isPlaying ? Assets.pause : Assets.play, for: .normal)
        playbackButton.addTarget(self, action: #selector(didTapPlayback), for: .touchUpInside)
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(contentStackView)
        containerView.addSubview(badgeImageView)
        containerView.addSubview(playbackButton)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(foundedLabel)
        contentStackView.addArrangedSubview(jobLabel)
        contentStackView.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            badgeImageView.heightAnchor.constraint(equalToConstant: 50),
            badgeImageView.widthAnchor.constraint(equalToConstant: 50),
            badgeImageView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            badgeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: badgeImageView.trailingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: playbackButton.leadingAnchor, constant: -8),
            
            playbackButton.heightAnchor.constraint(equalToConstant: 44),
            playbackButton.widthAnchor.constraint(equalToConstant: 44),
            playbackButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            playbackButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    @objc func didTapPlayback(){
        if let team = team {
            delegate?.didTapPlayback(for: team)
        }
    }
}
