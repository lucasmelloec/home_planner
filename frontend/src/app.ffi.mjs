export const do_listen_to_media_size_changes = (dispatch) => {
  window.matchMedia("(width >= 48rem)")
    .addEventListener("change", (event) => {
      return dispatch(event.matches)
    })
}

export const is_above_size_breakpoint = () => {
  return window.matchMedia("(width >= 48rem)").matches
}
