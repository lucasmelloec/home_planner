import app/route
import app/ui/icon
import app/ui/sidebar
import gleam/uri.{type Uri}
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import modem

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

type Model {
  Model(route: route.Route, sidebar_expanded: Bool)
}

fn init(_) -> #(Model, Effect(Msg)) {
  let route = case modem.initial_uri() {
    Ok(uri) -> route.from_uri(uri)
    Error(Nil) -> route.homepage
  }

  let model = Model(route:, sidebar_expanded: False)

  #(model, modem.init(on_uri_change))
}

fn on_uri_change(uri: Uri) -> Msg {
  UserNavigatedTo(route.from_uri(uri))
}

pub type Msg {
  UserNavigatedTo(route.Route)
  UserClickedSidebarButton
  UserClickedOutsideSidebar
  UserClickedHomeLink
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    UserNavigatedTo(route) -> #(Model(..model, route:), effect.none())
    UserClickedSidebarButton -> #(
      Model(..model, sidebar_expanded: !model.sidebar_expanded),
      effect.none(),
    )
    UserClickedOutsideSidebar | UserClickedHomeLink -> #(
      Model(..model, sidebar_expanded: False),
      effect.none(),
    )
  }
}

fn view(model: Model) -> Element(Msg) {
  html.div([attribute.class("h-screen flex flex-row")], [
    sidebar.view(model.sidebar_expanded, UserClickedHomeLink),
    html.div([attribute.class("flex-1 flex flex-col")], [
      html.header([attribute.class("h-18")], [
        html.button(
          [
            event.on_click(UserClickedSidebarButton),
            attribute.aria_expanded(model.sidebar_expanded),
            attribute.aria_controls("main-sidebar"),
            attribute.class(
              "fixed left-0 top-0 rounded-full p-1 m-4 md:hidden shadow-sm bg-surface",
            ),
          ],
          [icon.menu()],
        ),
        html.h1(
          [
            attribute.class(
              "h-full flex items-center justify-center font-semibold text-lg",
            ),
            event.on_click(UserClickedOutsideSidebar),
          ],
          [html.text(model.route |> route.to_title())],
        ),
      ]),
      html.main(
        [
          attribute.class("flex-1 flex justify-center"),
          event.on_click(UserClickedOutsideSidebar),
        ],
        [],
      ),
    ]),
  ])
}
