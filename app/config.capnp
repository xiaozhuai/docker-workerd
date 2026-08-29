using Workerd = import "/workerd/workerd.capnp";

const config :Workerd.Config = (
    services = [
        (
            name = "main",
            worker = .mainWorker
        )
    ],

    sockets = [
        (
            name = "http",
            address = "*:8080",
            http = (),
            service = "main"
        ),
    ]
);

const mainWorker :Workerd.Worker = (
    modules = [
        (
            name = "index.js",
            esModule = embed "./src/index.js"
        )
    ],
    compatibilityDate = "2026-08-27",
);
