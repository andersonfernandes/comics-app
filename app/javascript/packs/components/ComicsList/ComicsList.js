import React from 'react'
import styled from 'styled-components'
import PropTypes from 'prop-types'

import FavoriteIcon from './components/FavoriteIcon'

const Root = styled.main`
  width: 85%;
  display: block;
  margin: 150px auto 0;
`

const ComicItem = styled.div`
  display: inline-block;
  position: relative;
  margin: 8px;

  &:hover .overlay {
    display: inline-block;
  }
`

const ComicOverlay = styled.div`
  width: 300px;
  height: 450px;
  background-color: rgba(32,32,32, 0.5);
  position: absolute;
  top: 0;
  left: 0;
  display: none;
  cursor: pointer;
`

const ComicTitle = styled.div`
  width: 100%;
  height: 60px;
  padding: 10px;
  background-color: #FFFFFF;
  position: absolute;
  bottom: 0;
  font-weight: 700;
  text-transform: uppercase;
  font-size: 0.9em;
`

const ComicsList = ({ comics }) => (
  <Root>
    { comics.map(comic => {
      return (
        <ComicItem key={comic.id}>
          <img src={comic.cover_url} />

          <ComicOverlay className="overlay">
            <FavoriteIcon />

            <ComicTitle>
              {comic.title}
            </ComicTitle>
          </ComicOverlay>
        </ComicItem>
      )
    }) }
  </Root>
)

ComicsList.defaultProps = {
  comics: [],
}

ComicsList.propTypes = {
  comics: PropTypes.arrayOf(Object),
}

export default ComicsList
