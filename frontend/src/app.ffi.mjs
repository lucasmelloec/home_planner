export const do_listen_to_media_size_changes = (dispatch) => {
  const media = window.matchMedia("(width >= 48rem)")
  media.addEventListener("change", (event) => {
    return dispatch(event.matches)
  })
  return dispatch(media.matches)
}
