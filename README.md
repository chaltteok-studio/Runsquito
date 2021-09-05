# Runsquito
`Runsquito` is the **runtime** value editing package.

# Screenshot
<img src="https://i.imgur.com/sHPBnr2.gif" width=260 />

# Installation
### Swift Pacakge Manager
```swift
dependencies: [
    .package(name: "Runsquito", path: "https://github.com/chaltteok-studio/runsquito-ios", from: "1.1.0")
]
```

# How to use
## Basic usage
`Runsquito` is runtime value storage.

`Runsquito` serve `default` storage. but you can create and manage it self.

To use `Runsquito`, you should add a `Slot` into `Runsquito`.

> `ValueSlot` is decribe under the `Slot` section.

```swift
try Runsquito.default.addSlot(
    ValueSlot<Bool>(description: "This slot is test flag."),
    for: "test-slot"
)
```

And add items to serve presets of value.

```swift
try Runsquito.default.addItem(
    ValueItem(true, description: "Test slot value `true`."),
    for: "test-slot-true",
    in: "test-slot"
)

try Runsquito.default.addItem(
    ValueItem(false, description: "Test slot value `false`."),
    for: "test-slot-false",
    in: "test-slot"
)
```

Then the slot with key "test-slot" has items `true` and `false`.

This work perform recommand once like `AppDelegate`.

⚠️ Point to note is `Type`. `Slot` and `Item` has the `Type` of value. So all operations of `Runsquito` perform validation.
If you add or set value that it's type doesn't match to `Slot`, function throw `RunsquitoError.typeMismatch`.

If you add any slots, you can get value of slot anywhere.

```swift
Runquito.default.value(Bool.self, for: "test-slot")
```

### RunsquitoKit
If you use `Runsquito` only programmatically, you only need import `Runsquito` module. and you can make your own view. For your application's feature flags, test & QA helper, etc...

If you need `Runsquito` value edit views, use `RunsquitoKit`.

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

- `ValueSlot`

  `ValueSlot` is basic slot. It can handle all value of type. but it can't edit.
  
- `ParseableSlot`

  `ParseableSlot` is basic editable slot. It can handle `Parseable` adopt value of type.
  
  `Parseable` is protocol for editing. It force implement two functions. `encode` & `decode`.
  
  ```swift
  public protocol Parseable {
      static func encode(_ value: Self) throws -> Data
      static func decode(_ data: Data) throws -> Self
  }
  ```
  
  Primitive type `Int`, `Float`, `Double`, `String`, `Bool` already adopt that.
  
  If you want to use your own parser, you can implement it through adapt `Parseable` protocol to your models. or define new class that adopt `Slot` & `Editable` protocols.

- `CodableSlot`

  `CodableSlot` is custom editable slot. It design for json codable models.
  
  If you use `Codable` models, you can use `CodableSlot` to edit value through `Runsquito` easyly.

## Item
`Item` is value preset of slot.

Basically you could use `ValueItem` struct.

I'm getting ready `FileItem` for instantiate value by read file from bundle.

# Contribution

Any ideas, issues, opinions are welcome.

# License

`Runsquito` is available under the MIT license.
