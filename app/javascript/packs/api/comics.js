const loadComics = async (filters = {}) => {
  const { titleFilter } = filters
  let comicsUrl = `api/v1/comics?`

  if (titleFilter) comicsUrl += `title=${titleFilter}`

  return fetch(comicsUrl)
    .then(response => {
      if (response.ok) {
        return response.json()
      }
    })
}

export { loadComics }
