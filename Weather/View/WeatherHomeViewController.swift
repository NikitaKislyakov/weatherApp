import UIKit

final class WeatherHomeViewController: UIViewController {
    
    // MARK: – Variables
    
    private var weatherPhenomena: [Phenomenon] = []
    private var lightningTimer: Timer?
    private var mockService: MockServiceProtocol?
    
    // MARK: – UI Components
    
    private lazy var layout: UICollectionViewLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(PhenomenaCell.self, forCellWithReuseIdentifier: "PhenomenaCellID")
        collection.allowsSelection = true
        return collection
    }()
    
    // MARK: – Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        
        fillPhenomenonArray()
        updateWeatherView(with: randomWeatherElement())
    }
    
    init(with mockService: MockServiceProtocol?) {
        self.mockService = mockService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func randomWeatherElement() -> Phenomenon {
        return weatherPhenomena.randomElement() ?? weatherPhenomena[0]
    }
    
    // MARK: – Filling the weather array
    
    private func fillPhenomenonArray() {
        let mockArray = mockService?.createWeatherPhenomena()
        weatherPhenomena = mockArray ?? []
    }
    
    // MARK: – UI setup
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            // CollectionView
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    //MARK: – Updating UI
    
    private func updateWeatherView(with selectedPhenomenon: Phenomenon) {
        let weatherView = UIView(frame: self.view.bounds)
        
        let name = selectedPhenomenon.name
        switch name {
        case "rain".localized:
            clearView(view: weatherView)
            addRainElements(to: weatherView)
            title = name.localized
        case "sun".localized:
            clearView(view: weatherView)
            addSunnyElements(to: weatherView)
            title = name.localized
        case "snow".localized:
            clearView(view: weatherView)
            addSnowElements(to: weatherView)
            title = name.localized
        case "cloud".localized:
            clearView(view: weatherView)
            addCloudyElements(to: weatherView)
            title = name.localized
        case "storm".localized:
            clearView(view: weatherView)
            addThunderstormElements(to: weatherView)
            title = name.localized
        default:
            clearView(view: weatherView)
            view.backgroundColor = .black
        }
        
        UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: { self.view.subviews.forEach { subview in
            if subview != self.collectionView {
                subview.removeFromSuperview()
            }
        }
            self.view.addSubview(weatherView)
            self.view.sendSubviewToBack(weatherView)
        }, completion: nil)
    }
    
    private func clearView(view: UIView) {
        removePreviousAnimations(from: view)
        removeAllPreviousElements(from: view)
        stopLightningTimer()
    }
    
    private func removeAllPreviousElements(from containerView: UIView) {
        containerView.subviews.forEach { subview in
            if subview is UIImageView || subview is UILabel {
                subview.removeFromSuperview()
            }
        }
    }
    
    private func removePreviousAnimations(from containerView: UIView) {
        containerView.layer.sublayers?.forEach { layer in
            if layer is CAEmitterLayer {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    private func createLabel(with text: String, to containerView: UIView) {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            label.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    // MARK: – Rain elements and animations
    
    private func addRainElements(to containerView: UIView) {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "RainyBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        
        containerView.addSubview(backgroundImageView)
        containerView.sendSubviewToBack(backgroundImageView)
        
        createLabel(with: "rain-label-message".localized, to: containerView)
        
        createRainAnimation(to: containerView)
    }
    
    private func createRainAnimation(to containerView: UIView) {
        let rainLayer = CAEmitterLayer()
        rainLayer.emitterPosition = CGPoint(x: view.bounds.size.width / 2, y: -10)
        rainLayer.emitterShape = .line
        rainLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
        
        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(named: "Raindrops")?.cgImage
        rainCell.birthRate = 150
        rainCell.lifetime = 20.0
        rainCell.velocity = 200
        rainCell.velocityRange = 50
        rainCell.yAcceleration = 80
        rainCell.scale = 0.02
        rainCell.scaleRange = 0.02
        
        rainLayer.emitterCells = [rainCell]
        containerView.layer.addSublayer(rainLayer)
    }
    
    // MARK: – Sun elements and animations
    
    private func addSunnyElements(to containerView: UIView) {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "SunnyBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        
        containerView.addSubview(backgroundImageView)
        containerView.sendSubviewToBack(backgroundImageView)
        
        let sunImageView = UIImageView(image: UIImage(named: "Sun"))
        sunImageView.frame = CGRect(x: view.bounds.size.width - 150, y: 210, width: 150, height: 150)
        sunImageView.contentMode = .scaleAspectFit
        sunImageView.tag = 100
        containerView.addSubview(sunImageView)
        
        createLabel(with: "sun-label-message".localized, to: containerView)
        
        changeSunOpacity(for: sunImageView)
        animateSun(with: containerView)
    }
    
    private func animateSun(with containerView: UIView) {
        guard let sunImageView = containerView.viewWithTag(100) as? UIImageView else { return }
        
        let originalPosition = sunImageView.center
        let upPosition = CGPoint(x: originalPosition.x, y: originalPosition.y - 40)
        
        UIView.animate(withDuration: 4,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: {
            sunImageView.center = upPosition
        })
    }
    
    private func changeSunOpacity(for sunImageView: UIImageView) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.7
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
        sunImageView.layer.add(animation, forKey: "sunAnimation")
    }
    
    
    // MARK: – Cloud elements and animations
    
    private func addCloudyElements(to containerView: UIView) {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "CloudyBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        
        containerView.addSubview(backgroundImageView)
        containerView.sendSubviewToBack(backgroundImageView)
        
        // Создание облаков
        for _ in 0..<6 {
            animateClouds(to: containerView)
        }
        
        createLabel(with: "cloud-label-message".localized, to: containerView)
    }
    
    private func animateClouds(to containerView: UIView) {
        let cloudImageView = UIImageView(image: UIImage(named: "Cloud"))
        cloudImageView.frame = CGRect(x: -150, y: CGFloat.random(in: 230...600), width: 150, height: 90)
        cloudImageView.contentMode = .scaleAspectFit
        containerView.addSubview(cloudImageView)
        
        UIView.animate(withDuration: 8,
                       delay: TimeInterval.random(in: 0...2),
                       options:[
                        .repeat,
                        .curveEaseOut
                       ],
                       animations: {
            cloudImageView.frame.origin.x = self.view.bounds.size.width
        }) { _ in
            cloudImageView.removeFromSuperview()
        }
    }
    
    // MARK: – Snow elements and animations
    
    private func addSnowElements(to containerView: UIView) {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "SnowBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        containerView.addSubview(backgroundImageView)
        containerView.sendSubviewToBack(backgroundImageView)
        
        createSnowAnimation(to: containerView)
        
        createLabel(with: "snow-label-message".localized, to: containerView)
    }
    
    private func createSnowAnimation(to containerView: UIView) {
        let snowEmitter = CAEmitterLayer()
        snowEmitter.emitterPosition = CGPoint(x: view.bounds.size.width / 2, y: -10)
        snowEmitter.emitterShape = .line
        snowEmitter.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
        
        let snowflake = CAEmitterCell()
        let snowflakeImage = UIImage(named: "Snowflakes")?.cgImage
        snowflake.contents = snowflakeImage
        snowflake.birthRate = 30
        snowflake.lifetime = 20.0
        snowflake.velocity = 100
        snowflake.velocityRange = 50
        snowflake.yAcceleration = 20
        snowflake.scale = 0.07
        snowflake.scaleRange = 0.02
        
        snowEmitter.emitterCells = [snowflake]
        containerView.layer.addSublayer(snowEmitter)
    }
    
    // MARK: – Storm elements and animations
    
    private func addThunderstormElements(to containerView: UIView) {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "StormBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        
        containerView.addSubview(backgroundImageView)
        containerView.sendSubviewToBack(backgroundImageView)
        
        createRainStormAnimation(to: containerView)
        startLightningTimer()
        createLabel(with: "storm-label-message".localized, to: containerView)
    }
    
    private func createRainStormAnimation(to containerView: UIView) {
        let rainLayer = CAEmitterLayer()
        rainLayer.emitterPosition = CGPoint(x: view.bounds.size.width / 2, y: -10)
        rainLayer.emitterShape = .line
        rainLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
        
        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(named: "Raindrops")?.cgImage
        rainCell.birthRate = 150
        rainCell.lifetime = 20.0
        rainCell.velocity = 200
        rainCell.velocityRange = 50
        rainCell.yAcceleration = 100
        rainCell.scale = 0.04
        rainCell.scaleRange = 0.04
        
        rainLayer.emitterCells = [rainCell]
        containerView.layer.addSublayer(rainLayer)
    }
    
    private func startLightningTimer() {
        lightningTimer = Timer.scheduledTimer(timeInterval: Double.random(in: 2...5),
                                               target: self,
                                               selector: #selector(showLightning),
                                               userInfo: nil,
                                               repeats: true)
    }
    
    @objc
    private func showLightning() {
        let lightningView = UIView(frame: view.bounds)
        lightningView.backgroundColor = UIColor.clear
        self.view.addSubview(lightningView)
    
        let randomX = CGFloat.random(in: view.bounds.width * 0.4...view.bounds.width * 0.6)
        let randomY = CGFloat.random(in: view.bounds.height * 0.1...view.bounds.height * 0.5)

        let lightningLayer = createLightning(at: CGPoint(x: randomX, y: randomY), color: .white, lineWidth: 3)
        
        lightningView.layer.addSublayer(lightningLayer)

        lightningView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        UIView.animate(withDuration: 0.1, animations: {
            lightningView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
                lightningView.alpha = 0.0
            }) { _ in
                lightningView.removeFromSuperview()
            }
        }

        lightningLayer.opacity = 0.8
        lightningLayer.opacity = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            lightningLayer.removeFromSuperlayer()
        }
    }
    
    private func createLightning(at position: CGPoint, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        let lightningPath = UIBezierPath()
        
        lightningPath.move(to: position)
        
        lightningPath.addLine(to: CGPoint(x: position.x + 10, y: position.y + 30))
        lightningPath.addLine(to: CGPoint(x: position.x - 10, y: position.y + 60))
        lightningPath.addLine(to: CGPoint(x: position.x + 15, y: position.y + 90))
        lightningPath.addLine(to: CGPoint(x: position.x - 5, y: position.y + 120))
        
        let lightningLayer = CAShapeLayer()
        lightningLayer.path = lightningPath.cgPath
        lightningLayer.strokeColor = color.cgColor
        lightningLayer.lineWidth = lineWidth
        lightningLayer.lineCap = .round
        lightningLayer.fillColor = UIColor.clear.cgColor
        
        return lightningLayer
    }
    
    private func stopLightningTimer() {
        lightningTimer?.invalidate()
        lightningTimer = nil
    }
}

extension WeatherHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherPhenomena.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "PhenomenaCellID", for: indexPath) as? PhenomenaCell else {
            print("Cannot dequeue cell")
            return UICollectionViewCell()
        }
        let phenomena = weatherPhenomena[indexPath.row]
        cell.configureView(image: phenomena.image, text: phenomena.name)
        return cell
    }
}

extension WeatherHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhenomenaCell
        UIView.animate(withDuration: 0.3) {
            cell.toggleSelected()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhenomenaCell
        UIView.animate(withDuration: 0.3) {
            cell.toggleSelected()
        }
        let selectedPhenomenon = weatherPhenomena[indexPath.row]
        self.updateWeatherView(with: selectedPhenomenon)
    }
}

extension WeatherHomeViewController: UICollectionViewDelegateFlowLayout {
    
}



