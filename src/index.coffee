# tinyprofiler react ui

React = require 'react'

{tinyprofiler} = require './components'

# for use within a react project
renderComponent = (client) ->
  tinyprofiler {client}

# for use in the browser
renderElement = (client, container) ->
  component = renderComponent client
  React.renderComponent component, container

# accepted anywhere html is sold
renderString = (client) ->
  component = renderComponent client
  React.renderComponentToString component

module.exports = {renderComponent, renderElement, renderString}
