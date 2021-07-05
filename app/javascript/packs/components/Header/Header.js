import React from 'react'
import styled from 'styled-components'

import MarvelLogo from '../../assets/images/marvel_logo.png'

const Root = styled.header`
  width: 100%;
  height: 150px;
  text-align: center;
  background-color: rgba(289, 11, 5, 0.9);
  position: fixed;
  top: 0;
  padding-top: 20px;
  z-index: 1000;
`

const Logo = styled.img`
  display: block;
  margin: 0 auto;
`

const SearchBar = styled.input`
  width: 20%;
  padding: 10px;
  border-radius: 3px;
  border: none;
  margin-top: 20px;

  &:focus {
    outline: none;
  }

  @media (max-width: 768px) {
    width: 90%;
  }
`

const Header = ({ handleSearch }) => {
  const [value, setValue] = React.useState("");

  const handleKeyPress = event => {
    if (event.charCode === 13) {
      handleSearch(value)
    }
  }

  return (
    <Root>
      <Logo src={MarvelLogo} alt="Marvel Logo" />

      <SearchBar
        placeholder="Search your favorite marvel comic"
        onKeyPress={event => handleKeyPress(event) }
        onChange={event => setValue(event.target.value)}
        value={value}
      />
    </Root>
  )
}

export default Header
