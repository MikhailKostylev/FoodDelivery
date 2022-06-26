//
//  OnboardingViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private var slides = [OnboardingSlideModel]()
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
                skipButton.isHidden = true
            } else {
                nextButton.setTitle("Next", for: .normal)
                skipButton.isHidden = false
            }
        }
    }
    
    private let collectionHeightMultiplier: CGFloat = 0.8
    private let buttonHeight: CGFloat = 50
    private let buttonWidth: CGFloat = 150
    private let padding: CGFloat = 20
    private let cornerRadius: CGFloat = 30
    private let buttonCornerRadius: CGFloat = 15
    
    // MARK: - UI elements
    
    private var collectionView: UICollectionView!
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appYellow
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = padding
        return stackView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isEnabled = false
        pageControl.currentPageIndicatorTintColor = .appRed
        pageControl.pageIndicatorTintColor = .appOrange
        return pageControl
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.backgroundColor = .appRed
        button.layer.cornerRadius = buttonCornerRadius
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("skip", for: .normal)
        button.setTitleColor(.appRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupSlidesContent()
        setupPageControl()
        setupCollectionView()
        setupLayout()
        addActions()
    }
    
    // MARK: - Setups
    
    private func setupVC() {
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.width, height: view.height * collectionHeightMultiplier)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            OnboardingSlideCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingSlideCollectionViewCell.identifier
        )
    }
    
    private func setupSlidesContent() {
        slides = [
            OnboardingSlideModel(title: "A huge assortment of food to choose from in your device", subtitle: "Order as many as you like.", image: "onboarding1"),
            OnboardingSlideModel(title: "Make an order in a few seconds", subtitle: "A couple of clicks and you're already happy.", image: "onboarding2"),
            OnboardingSlideModel(title: "Five star delivery", subtitle: "Traffic jams are not a problem for us.", image: "onboarding3"),
            OnboardingSlideModel(title: "Stock up on groceries for the weeks ahead", subtitle: "No more going to the store and waiting in line.", image: "onboarding4"),
            OnboardingSlideModel(title: "All your favorites", subtitle: "Order from the best local restaurants with easy, on-demand delivery.", image: "onboarding5"),
            OnboardingSlideModel(title: "The best from the delivery world", subtitle: "Innovative technology for your convenience.", image: "onboarding6")
        ]
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
    }
    
    // MARK: - Actions
    
    private func addActions() {
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
    }
    
    private func goToMainVC() {
        let vc = MainViewController()
        let mainVC = UINavigationController(rootViewController: vc)
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
    
    @objc private func didTapNextButton() {
        if currentPage == slides.count - 1 {
            goToMainVC()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc private func didTapSkipButton() {
        goToMainVC()
    }
}

// MARK: - CollectionView Methods

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingSlideCollectionViewCell.identifier, for: indexPath) as! OnboardingSlideCollectionViewCell
        cell.configure(with: slides[indexPath.row])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.width)
    }
}

// MARK: - Layout

extension OnboardingViewController {
    
    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(containerView)
        view.addSubview(stackView)
        view.addSubview(skipButton)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)
        
        collectionView.prepareForAutoLayout()
        containerView.prepareForAutoLayout()
        stackView.prepareForAutoLayout()
        pageControl.prepareForAutoLayout()
        nextButton.prepareForAutoLayout()
        skipButton.prepareForAutoLayout()
                
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: collectionHeightMultiplier),
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: cornerRadius),
            
            stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            nextButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            nextButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            skipButton.topAnchor.constraint(equalTo: nextButton.topAnchor),
            skipButton.leadingAnchor.constraint(equalTo: nextButton.trailingAnchor),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skipButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
