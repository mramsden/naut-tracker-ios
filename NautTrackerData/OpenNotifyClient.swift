import Foundation

enum OpenNotifyClientError: Error {
    case networkOffline
    case networkTimeout
    case unknown
}

protocol OpenNotifyClient {
    func fetchAstronauts(completion: @escaping ([String: Any]?, OpenNotifyClientError?) -> Void)
}

extension URLSession: OpenNotifyClient {

    func fetchAstronauts(completion: @escaping ([String: Any]?, OpenNotifyClientError?) -> Void) {
        dataTask(with: URL(string: "http://api.open-notify.org/astros.json")!) { data, response, error in
            if error?.networkOffline == true { return completion(nil, .networkOffline) }
            if error?.networkTimeout == true { return completion(nil, .networkTimeout) }

            guard error == nil, let data = data, response?.isJsonResponse == true else {
                return completion(nil, .unknown)
            }

            let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
            completion(json, nil)
        }.resume()
    }

}

private extension Error {

    var networkOffline: Bool {
        let error = self as NSError
        return error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet
    }

    var networkTimeout: Bool {
        let error = self as NSError
        return error.domain == NSURLErrorDomain && error.code == NSURLErrorTimedOut
    }

}

private extension URLResponse {

    var isJsonResponse: Bool {
        guard let response = self as? HTTPURLResponse else {
            return false
        }

        return response.allHeaderFields["Content-Type"] as? String == "application/json"
    }

}
