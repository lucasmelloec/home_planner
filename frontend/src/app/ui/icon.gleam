import lustre/attribute
import lustre/element/html
import lustre/element/svg

pub fn menu() {
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
        attribute.attribute("d", "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"),
      ]),
    ],
  )
}
