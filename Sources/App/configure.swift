import Vapor
import Leaf

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Configure the rest of your application here
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    var tags = LeafTagConfig.default()
    tags.use(JoinTag(), as: "join")
    tags.use(ZebraTag(), as: "zebra")
    services.register(tags)

    var middleware = MiddlewareConfig.default()
    middleware.use(FileMiddleware.self) // Serves files from the `Public/` directory
    middleware.use(ErrorMiddleware.self) // converts errors to HTTP responses
    services.register(middleware)
}
