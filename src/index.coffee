# tinyprofiler react ui

React = require 'react'
ReactDOM = require 'react-dom'
ReactDOMServer = require 'react-dom/server'

{tinyprofiler} = require './components'

# for use within a react project
renderComponent = (client, options) ->
  props = {client}
  props.position = options.position if options?.position?
  React.createElement tinyprofiler, props

# for use in the browser
renderElement = (client, container) ->
  component = renderComponent client
  ReactDOM.render component, container

# accepted anywhere html is sold
renderString = (client) ->
  component = renderComponent client
  ReactDOMServer.renderToString component

module.exports = {renderComponent, renderElement, renderString}
