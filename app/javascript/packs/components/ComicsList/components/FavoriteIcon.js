import React from 'react'
import styled from 'styled-components'

import OffIcon from '../../../assets/images/heart_off.png'
import OnIcon from '../../../assets/images/heart_on.png'
import HoverIcon from '../../../assets/images/heart_hover.png'

const IconStatus = {
  ON: 'ON',
  OFF: 'OFF',
  HOVER: 'HOVER'
}

const Root = styled.div`
  width: 20px;
  height: 20px;
  position: absolute;
  top: 10px;
  right: 20px;
`

const FavoriteIcon = ({ status }) => {
  const [iconStatus, setIconStatus] = React.useState(status)

  React.useEffect(() => {
    setIconStatus(status)
  }, [status])

  const iconByStatus = {
    [IconStatus.OFF]: OffIcon,
    [IconStatus.ON]: OnIcon,
    [IconStatus.HOVER]: HoverIcon,
  }

  const handleMouseOver = () => {
    if (iconStatus === IconStatus.OFF) {
      setIconStatus(IconStatus.HOVER)
    }
  }

  const handleMouseOut = () => {
    if (iconStatus === IconStatus.HOVER) {
      setIconStatus(IconStatus.OFF)
    }
  }

  return (
    <Root
      onMouseOver={() => handleMouseOver()}
      onMouseOut={() => handleMouseOut()}
      onClick={() => setIconStatus(IconStatus.ON)}
    >
      <img src={iconByStatus[iconStatus]} />
    </Root>
  )
}

FavoriteIcon.defaultProps = {
  status: IconStatus.OFF,
}

export { IconStatus }
export default FavoriteIcon
