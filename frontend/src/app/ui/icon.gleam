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

pub fn search() {
  html.svg(
    [
      attribute.height(24),
      attribute.attribute("viewBox", "0 -960 960 960"),
      attribute.width(24),
      attribute.attribute("fill", "var(--color-cyan-800)"),
      attribute.class("size-6"),
    ],
    [
      svg.path([
        attribute.attribute(
          "d",
          "M784-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l252 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T380-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Z",
        ),
      ]),
    ],
  )
}

pub fn plus() {
  html.svg(
    [
      attribute.attribute("fill", "none"),
      attribute.attribute("viewBox", "0 0 24 24"),
      attribute.attribute("stroke-width", "1.5"),
      attribute.attribute("stroke", "currentColor"),
      attribute.class("size-6 text-color"),
    ],
    [
      svg.path([
        attribute.attribute("stroke-linecap", "round"),
        attribute.attribute("stroke-linejoin", "round"),
        attribute.attribute("d", "M12 4.5v15m7.5-7.5h-15"),
      ]),
    ],
  )
}

pub fn minus() {
  html.svg(
    [
      attribute.attribute("fill", "none"),
      attribute.attribute("viewBox", "0 0 24 24"),
      attribute.attribute("stroke-width", "1.5"),
      attribute.attribute("stroke", "currentColor"),
      attribute.class("size-6 text-color"),
    ],
    [
      svg.path([
        attribute.attribute("stroke-linecap", "round"),
        attribute.attribute("stroke-linejoin", "round"),
        attribute.attribute("d", "M5 12h14"),
      ]),
    ],
  )
}
