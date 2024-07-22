import UIKit

final class MockService: MockServiceProtocol {
    
    func createWeatherPhenomena() -> [Phenomenon] {
        var phenomenaArray: [Phenomenon] = []
        
        let rain = Phenomenon(name: "rain".localized, image: UIImage(systemName: "cloud.rain.fill")!)
        phenomenaArray.append(rain)
        let clear = Phenomenon(name: "sun".localized, image: UIImage(systemName: "sun.max")!)
        phenomenaArray.append(clear)
        let cloudy = Phenomenon(name: "cloud".localized, image: UIImage(systemName: "cloud")!)
        phenomenaArray.append(cloudy)
        let snowy = Phenomenon(name: "snow".localized, image: UIImage(systemName: "cloud.snow")!)
        phenomenaArray.append(snowy)
        let storm = Phenomenon(name: "storm".localized, image: UIImage(systemName: "cloud.bolt.rain.fill")!)
        phenomenaArray.append(storm)
        return phenomenaArray
    }
}
