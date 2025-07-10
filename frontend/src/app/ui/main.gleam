import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/vdom/vattr

pub fn view(
  attributes: List(vattr.Attribute(a)),
  children: List(Element(a)),
) -> Element(a) {
  html.main([attribute.class("[grid-area:main] flex justify-center")], [
    html.div(
      [attribute.class("flex-1 flex flex-col max-w-500 mx-6")]
        |> list.append(attributes),
      children,
    ),
  ])
}
