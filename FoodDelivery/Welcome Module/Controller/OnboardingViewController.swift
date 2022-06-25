//
//  OnboardingViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private lazy var assembly = Assembly()
    private var slides = [OnboardingSlideModel]()
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    // MARK: - UI elements
    
    private var collectionView: UICollectionView!
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isEnabled = false
        pageControl.numberOfPages = 6
        pageControl.setIndicatorImage(UIImage(systemName: "star.fill"), forPage: 5)
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .lightText
        return pageControl
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.appColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupSlidesContent()
        setupCollectionView()
        setupLayout()
        addActions()
    }
    
    // MARK: - Setups
    
    private func setupVC() {
        view.backgroundColor = .appColor
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.width, height: view.height*0.8)
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
        pageControl.numberOfPages = slides.count
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)
        
        collectionView.prepareForAutoLayout()
        stackView.prepareForAutoLayout()
        pageControl.prepareForAutoLayout()
        nextButton.prepareForAutoLayout()
                
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.padding),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Actions
    
    func addActions() {
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    @objc private func didTapNextButton() {
        if currentPage == slides.count - 1 {
            let mainVC = assembly.configureMainModule()
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
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
