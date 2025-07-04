import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view(value: String) -> Element(_) {
  html.li(
    [
      attribute.class(
        "p-6 md:mx-4 my-3 bg-surface/80 border border-error rounded-lg shadow-sm hover:bg-primary active:bg-primary",
      ),
    ],
    [html.p([], [html.text(value)])],
  )
}
