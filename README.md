# Runsquito
`Runsquito` is the **runtime** value editor package.

You can get help with implementation like a/b testing controller, develop & qa test helper etc...

# Screenshot
<img src="https://i.imgur.com/sHPBnr2.gif" width=260 />

# Installation
### Swift Pacakge Manager
```swift
dependencies: [
    .package(name: "Runsquito", path: "https://github.com/chaltteok-studio/runsquito-ios", from: "1.2.0")
]
```

# How to use
## Basic usage
`Runsquito` is runtime value storage.

`Runsquito` serve `default` storage. but you can create and manage it self.

To use `Runsquito`, you should add a `Slot` into `Runsquito`.

> `ValueSlot` is describe under the `Slot` section.

```swift
try Runsquito.default.addSlot(
    ValueSlot<Bool>(description: "This slot is flag for a/b testing some feature."),
    forKey: "ab-testing-some-feature"
)
```

And add items to serve presets of value.

```swift
try Runsquito.default.updateItem(
    ValueItem(true, description: "Activate some feature A."),
    forKey: "ab-testing-a",
    inSlotKey: "ab-testing-some-feature"
)
```

Then the slot with key `"ab-testing-some-feature"` has a item `true` for executation of A case of a/b testing.

This work perform recommand once like `AppDelegate`.

⚠️ Point to note is `Type`. `Slot` and `Item` has the `Type` of value. So all operations of `Runsquito` perform validation.
If you add or set value that it's type doesn't match to `Slot`, function throw `RunsquitoError.typeMismatch`.

If you add any slots, you can get value of slot anywhere. Configure your logic to handle `Runsquito` value first, and write right logic when value is `nil`.

```swift
if Runquito.default.value(Bool.self, forKey: "ab-testing-some-feature") ?? RemoteConfig.remoteConfig["some-feature-ab"] ?? false {
    // Run `A` process.
} else {
    // Run `B` process.
} 
```

### RunsquitoKit
If you use `Runsquito` only programmatically, you only need import `Runsquito` module. and you can make your own view. For your application's feature flags, test & QA helper, etc...

If you need `Runsquito` value edit views, import `RunsquitoKit`.

`RunsquitoKit` has a public `ViewController` named `RunsquitoViewController`.

```swift
public final class RunsquitoViewController : UINavigationController {
    public init(runsquito: Runsquito = .default)
}
```

It serve default features that manage `Runsquito`. like `Screenshot` section's GIF.

## Slot
`Slot` is the protocol that manage current value and presets of value.

`Runsquito` serve three `Slot` protocol adopt classes.

### ValueSlot
`ValueSlot` is basic slot. It can handle all value of type. but it can't edit.
  
### ParseableSlot
`ParseableSlot` is basic editable slot. It can handle `Parseable` adopt value of type.

`Parseable` is protocol for editing. It force implement two functions. `encode` & `decode`.
  
```swift
public protocol Parseable {
    func encode() throws -> Data
    static func decode(from data: Data) throws -> Self
}
```
  
Primitive type `Int`, `Float`, `Double`, `String`, `Bool` already adopt that.
  
If you want to use your own parser, you can implement it through adapt `Parseable` protocol to your models. or define new class that adopt `EditableSlot` protocol.

### CodableSlot
`CodableSlot` is custom editable slot. It design for json codable models.

If you use `Codable` models, you can use `CodableSlot` to edit value through `Runsquito` easyly.

## Item
`Item` is value preset of slot.

Basically you could use `ValueItem` struct.

If you want to instantiate value from `json` format file, use `FileItem`.

```swift
public struct FileItem<Value>: Item {
    public init?(description:fileName:in:) where Value: Decodable
}
```

# Contribution

Any ideas, issues, opinions are welcome.

# License

`Runsquito` is available under the MIT license.
