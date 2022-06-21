import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import Joyride from 'react-joyride'

const UDComponent = props => {
  return <Joyride {...props} styles={{
    options: {
      zIndex: 10000,
    },
  }} />
}

export default withComponentFeatures(UDComponent)