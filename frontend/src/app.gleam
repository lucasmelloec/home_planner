import app/i18n
import app/i18n/en
import app/i18n/pt
import app/route
import app/route/details
import app/route/products
import app/route/recipes
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
  Model(
    route: route.Route,
    sidebar_expanded: Bool,
    above_size_breakpoint: Bool,
    i18n: fn(i18n.I18nKey) -> String,
  )
}

fn init(_) -> #(Model, Effect(Msg)) {
  let route = case modem.initial_uri() {
    Ok(uri) -> route.from_uri(uri)
    Error(Nil) -> route.homepage
  }

  let model =
    Model(
      route:,
      sidebar_expanded: False,
      above_size_breakpoint: False,
      i18n: en.i18n,
    )

  #(
    model,
    effect.batch([modem.init(on_uri_change), listen_to_media_size_changes()]),
  )
}

fn listen_to_media_size_changes() -> Effect(Msg) {
  use dispatch <- effect.from()
  use above_breakpoint <- do_listen_to_media_size_changes
  UserResizedAboveBreakpoint(above_breakpoint) |> dispatch
}

@external(javascript, "./app.ffi.mjs", "do_listen_to_media_size_changes")
fn do_listen_to_media_size_changes(_handler: fn(Bool) -> Nil) -> Nil {
  Nil
}

fn on_uri_change(uri: Uri) -> Msg {
  UserNavigatedTo(route.from_uri(uri))
}

pub type Msg {
  UserNavigatedTo(route.Route)
  UserClickedSidebarButton
  UserClickedOutsideSidebar
  UserResizedAboveBreakpoint(Bool)
  UserChangedLanguage(i18n.Lang)
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    UserNavigatedTo(route) -> #(
      Model(..model, route:, sidebar_expanded: False),
      effect.none(),
    )
    UserClickedSidebarButton -> #(
      Model(..model, sidebar_expanded: !model.sidebar_expanded),
      effect.none(),
    )
    UserClickedOutsideSidebar -> #(
      Model(..model, sidebar_expanded: False),
      effect.none(),
    )
    UserResizedAboveBreakpoint(above_size_breakpoint) -> #(
      Model(..model, above_size_breakpoint:),
      effect.none(),
    )
    UserChangedLanguage(lang) -> {
      let i18n = case lang {
        i18n.En -> en.i18n
        i18n.Pt -> pt.i18n
      }
      #(Model(..model, i18n:), effect.none())
    }
  }
}

fn view(model: Model) -> Element(Msg) {
  html.div(
    [
      attribute.class(
        "min-h-screen grid grid-cols-1 md:grid-cols-[calc(var(--spacing)*72)_1fr] grid-rows-[auto_1fr] [grid-template-areas:'header'_'main'] md:[grid-template-areas:'sidebar_header'_'sidebar_main']",
      ),
    ],
    [
      sidebar.view(
        model.sidebar_expanded,
        model.route,
        model.above_size_breakpoint,
        model.i18n,
        UserChangedLanguage,
      ),
      html.button(
        [
          event.on_click(UserClickedSidebarButton),
          attribute.aria_label("toggle sidebar"),
          attribute.aria_expanded(model.sidebar_expanded),
          attribute.aria_controls("sidebar"),
          attribute.class(
            "fixed z-10 top-0 rounded-full p-1 mt-[10px] ml-[10px] shadow-sm bg-surface md:hidden",
          ),
        ],
        [icon.menu()],
      ),
      html.div(
        [
          attribute.class(
            "bg-black/20 fixed inset-0 z-9 hidden peer-data-[expanded=true]:block",
          ),
          event.on_click(UserClickedOutsideSidebar),
          attribute.aria_hidden(True),
        ],
        [],
      ),
      html.header(
        [
          attribute.class(
            "p-4 sticky top-0 [grid-area:header] border-b border-b-gray-400/30",
          ),
        ],
        [
          html.h1([attribute.class("font-semibold text-lg text-center")], [
            html.text(model.route |> route.to_title(model.i18n)),
          ]),
        ],
      ),
      html.main([attribute.class("[grid-area:main] flex justify-center")], [
        case model.route {
          route.Products -> products.view(model.i18n)
          route.Recipes -> recipes.view(model.i18n)
          route.Details -> details.view(model.i18n)
          _ -> element.none()
        },
      ]),
    ],
  )
}
