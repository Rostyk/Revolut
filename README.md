# Revolut Demo

[Demo video link](https://youtu.be/H-H-S5sAUlI)
### View side of things:

```swift

....
let controller = CurrencyController()
controller.presentable = self
....

....
extension YourViewController: CurrencyPresentable {
    internal func refreshCurrencies() {
        /* do something like tableView.reloadData()
           use controller.getCurrency(indexPath) to build your cell
        */
    }
}

```

### API side of things:

"Networking engine" folder contains a very simple HTTP transport. Every request and response come as separate file.


#### API call invokation logic:

```swift
 let getCurrenciesReqeust = GetCurrenciesRequest(baseCurrency: baseCurrency)
        transport?.send(request: getCurrenciesReqeust) {
            (response: GetCurrenciesResponse?, error: TransportError?) in
            if let response = response {
                if let _ = response.rates {
                    completion(response, nil)
                } else {
                    completion(nil, TransportError.DeserializationFailed)
                }
            } else {
                completion(nil, error)
            }
        }
```

#### API wrapper. All time favourite singleton :) Could be something more elegant ofcourse. Like interactors to be more VIPER-ish.

```swift
RevolutAPI.shared.getCurrencies(baseCurrency: baseCurrency) { [weak self] (response, error) in
            if let response = response {
                //Use your response.rates: [String:Float]
            }
            else {
                //Do something according to error.code
            }
}
```

#### Parsing logic:
```swift
struct GetCurrenciesResponse: DDResponse {
    var rates: [String:Float]!
}

extension GetCurrenciesResponse: Deserializable {
    init?(data: Data) {
        guard let response = try? JSONDecoder().decode(GetCurrenciesResponse.self, from: data) else { return nil }
        
        rates = response.rates
    }
}

```

## Tests

```swift
// RevolutNetworkingTests.swift and RevolutCurrencyControllerTests.swift contain some simple tests:

func testSuccessCurrencyAPI() {
        RevolutAPI.shared.getCurrencies(baseCurrency: currencies[0]) { [weak self](response, error) in
            self?.validCurrencyExpectation.fulfill()
            
            XCTAssertNil(error, "Could not complete request")
            XCTAssertNotNil(response, "Could not get proper response")
            
            if let response = response {
                XCTAssert(response.rates.count > 0, "Could not get any currency rates")
                
                if let rate = response.rates.first {
                    let (code, value) = rate
                    
                    XCTAssert(code.count > 0, "Currency code should be a valid string")
                    XCTAssert(value > 0, "Currency exchange rate should be a valid number")
                }
            }
        }
        
        wait(for: [validCurrencyExpectation], timeout: 4.0)
}

```
