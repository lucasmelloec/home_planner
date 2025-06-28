import app/route
import app/ui/sidebar
import gleam/uri.{type Uri}
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/element/svg
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
  OnRouteChange(route.from_uri(uri))
}

pub type Msg {
  OnRouteChange(route.Route)
  OnSidebarToggle
  OnClickOutsideSidebar
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    OnRouteChange(route) -> #(Model(..model, route:), effect.none())
    OnSidebarToggle -> #(
      Model(..model, sidebar_expanded: !model.sidebar_expanded),
      effect.none(),
    )
    OnClickOutsideSidebar -> #(
      Model(..model, sidebar_expanded: False),
      effect.none(),
    )
  }
}

fn view(model: Model) -> Element(Msg) {
  html.div([attribute.class("h-screen flex flex-row")], [
    sidebar.view(model.sidebar_expanded),
    html.div([attribute.class("flex-1 flex flex-col")], [
      html.header([attribute.class("h-18")], [
        html.button(
          [
            event.on_click(OnSidebarToggle),
            attribute.class(
              "fixed left-0 top-0 bg-surface rounded-full p-1 m-4 sm:hidden shadow-sm",
            ),
          ],
          [
            html.svg(
              [
                attribute.attribute("fill", "none"),
                attribute.attribute("viewBox", "0 0 24 24"),
                attribute.attribute("stroke-width", "1.5"),
                attribute.attribute("stroke", "currentColor"),
                attribute.class("size-8 text-cyan-800"),
              ],
              [
                svg.path([
                  attribute.attribute("stroke-linecap", "round"),
                  attribute.attribute("stroke-linejoin", "round"),
                  attribute.attribute(
                    "d",
                    "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5",
                  ),
                ]),
              ],
            ),
          ],
        ),
        html.h1(
          [
            attribute.class(
              "h-full flex items-center justify-center font-semibold text-lg",
            ),
            event.on_click(OnClickOutsideSidebar),
          ],
          [html.text(model.route |> route.to_title())],
        ),
      ]),
      html.main(
        [attribute.class("flex-1 flex"), event.on_click(OnClickOutsideSidebar)],
        [],
      ),
    ]),
  ])
}
