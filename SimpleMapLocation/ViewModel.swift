import CoreLocation
import Combine

final class ViewModel: NSObject, ObservableObject {
    let model: LocationDataSource
    var cancellables = Set<AnyCancellable>()
    @Published var authorizationStatus = CLAuthorizationStatus.notDetermined
    @Published var location: CLLocation = .init()

    var latitude: CLLocationDegrees {
        location.coordinate.latitude
    }

    var longitude: CLLocationDegrees {
        location.coordinate.longitude
    }

    init(model: LocationDataSource) {
        self.model = model
    }

    func requestAuthorization() {
        model.requestAuthorization()
    }

    func activate() {
        model.authorizationPublisher().print("dump:status").sink { [weak self] authorizationStatus in
            guard let self = self else { return }
            self.authorizationStatus = authorizationStatus
        }.store(in: &cancellables)

        model.locationPublisher().print("dump:location").sink { [weak self] locations in
            guard let self = self else { return }
            if let last = locations.last {
                self.location = last
            }
        }.store(in: &cancellables)
    }

    func deactivate() {
        cancellables.removeAll()
    }

    func startTracking() {
        model.startTracking()
    }

    func stopTracking() {
        model.stopTracking()
    }
}
