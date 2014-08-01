# react tinyprofiler ui components

React = require 'react'

{div, span} = React.DOM

tinyprofiler = React.createClass
  displayName: "TinyProfiler"

  propTypes:
    # requires a TinyProfilerClient instance
    client: React.PropTypes.object.isRequired
    position: React.PropTypes.oneOf ['nw', 'ne', 'se', 'sw']

  getDefaultProps: ->
    position: 'sw'

  handleProfile: (req) ->
    @forceUpdate()

  componentWillMount: ->
    @props.client.on 'profile', @handleProfile

  componentWillUnmount: ->
    @props.client.off 'profile', @handleProfile

  handleRemove: (request) ->
    @props.client.remove request.getId()
    @forceUpdate()

  render: ->
    div
      className: "tinyprofiler tinyprofiler-#{@props.position}"
      div
        className: "tinyprofiler-requests"
        (@renderRequest req for req in @props.client.getRequests())

  renderRequest: (req) ->
    request
      key: req.getId()
      request: req
      onRemove: @handleRemove

request = React.createClass
  displayName: "TinyProfiler Request"

  getDefaultProps: ->
    onRemove: ->

  getInitialState: ->
    collapsed: yes

  toggleCollapsed: ->
    @setState collapsed: not @state.collapsed

  handleRemove: ->
    @props.onRemove @props.request

  render: ->
    req = @props.request
    children = req.getSteps()
    div
      className: "tinyprofiler-request tinyprofiler-" +
        if @state.collapsed then "collapsed" else "expanded"
      id: req.getId()
      div
        className: "tinyprofiler-header"
        div
          className: "tinyprofiler-target"
          onClick: @toggleCollapsed
          div
            className: "tinyprofiler-expand"
            title: "expand"
            dangerouslySetInnerHTML: __html: "&plus;"
          div
            className: "tinyprofiler-collapse"
            title: "collapse"
            dangerouslySetInnerHTML: __html: "&minus;"
          div
            className: "tinyprofiler-name"
            req.getName()
          div
            className: "tinyprofiler-length"
            req.getLength()
        div
          className: "tinyprofiler-request-remove"
          title: "remove this profile"
          dangerouslySetInnerHTML: __html: "&times;"
          onClick: @handleRemove
      div
        className: "tinyprofiler-body"
        div
          className: "tinyprofiler-details"
          req.getDetails()
        div
          className: "tinyprofiler-start"
          req.getStart().toISOString()
        if children.length
          div
            className: "tinyprofiler-steps"
            (@renderStep i, child for i, child of children)

  renderStep: (i, child) ->
    step
      key: i
      step: child

step = React.createClass
  displayName: "TinyProfiler Step"

  getInitialState: ->
    collapsed: yes

  toggleCollapsed: ->
    @setState collapsed: not @state.collapsed

  render: ->
    st = @props.step
    children = st.getSteps()
    details = st.getDetails()
    cls = "tinyprofiler-step tinyprofiler-" +
      if @state.collapsed then "collapsed" else "expanded"
    cls += " tinyprofiler-leaf" unless children.length or details?
    div
      className: cls
      div
        className: "tinyprofiler-header"
        onClick: @toggleCollapsed
        div
          className: "tinyprofiler-expand"
          title: "expand"
          dangerouslySetInnerHTML: __html: "&plus;"
        div
          className: "tinyprofiler-collapse"
          title: "collapse"
          dangerouslySetInnerHTML: __html: "&minus;"
        div
          className: "tinyprofiler-name"
          st.getName()
        div
          className: "tinyprofiler-length"
          st.getLength()
      div
        className: "tinyprofiler-body"
        if details?
          div
            className: "tinyprofiler-details"
            details
        if children.length
          div
            className: "tinyprofiler-steps"
            (@renderStep i, child for i, child of children)

  renderStep: (i, child) ->
    step
      key: i
      step: child

module.exports = {tinyprofiler, request, step}
