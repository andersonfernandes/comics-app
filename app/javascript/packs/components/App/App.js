import React from 'react'
import styled, { css } from 'styled-components'

import GlobalStyle from '../GlobalStyle'
import Header from '../Header'
import ComicsList from '../ComicsList'
import { loadComics } from '../../api/comics'

const Loader = styled.div`
  width: 80px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translateX(-50%) translateY(-50%);

  &:after {
    content: " ";
    display: block;
    width: 64px;
    height: 64px;
    margin: 8px;
    border-radius: 50%;
    border: 6px solid #fff;
    border-color: #fff transparent #fff transparent;
    animation: dual-ring 1.5s linear infinite;
  }

  @keyframes dual-ring {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
`

const App = () => {
  const [comics, setComics] = React.useState([])
  const [requestMeta, setRequestMeta] = React.useState({})
  const [loading, setLoading] = React.useState(false)

  React.useEffect(() => {
    setLoading(true)

    loadComics()
      .then(responseData => {
        const { meta, data } = responseData.table

        setRequestMeta(meta)
        setComics(data)
      })
      .finally(() => setLoading(false))
  }, [])

  const handleSearch = (title) => {
    setLoading(true)
    setComics([])

    loadComics({ titleFilter: title })
      .then(responseData => {
        const { data } = responseData.table

        setComics(data)
      })
      .finally(() => setLoading(false))
  }

  return (
    <>
      <GlobalStyle />

      {loading && <Loader />}
      <Header handleSearch={handleSearch} />
      <ComicsList comics={comics} />
    </>
  )
}

export default App
