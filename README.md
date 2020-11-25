## Swift Dependency Injector


### How to use 


#### For development module
```swift
class DevModule: AbstractModule {
  override func configure() {
    super.configure()

    bind(String.self).withName("api-host").to("http://api.development.com")

    bind(FooService.self).to(DevFooServiceImpl())
    bind(BarService.self).to(BarServiceImpl())
  }
}
```

#### For testing module
```swift
class TestModule: DevModule {
  override func configure() {
    super.configure()

    bind(String.self).withName("api-host").to("http://api.localhost.com")

    bind(BarService.self).to(FakedServiceImpl())
  }
}
```

#### For production module
```swift
class ProdModule: DevModule {
  override func configure() {
    super.configure()

    bind(String.self).withName("api-host").to("http://api.production.com")

    bind(FooService.self).to(ProdFooServiceImpl())
  }
}
```


#### In app delegate
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  Injectors.initialize(modules: DevModule())

  //...
  return true
}
```

#### get instance 
``` swift
  let fooService = Injectors.get(FooService.self)
  fooService.foo()
```