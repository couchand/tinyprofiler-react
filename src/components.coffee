# react tinyprofiler ui components

React = require 'react'

{div} = React.DOM

tinyprofiler = React.createClass
  displayName: "TinyProfiler"

  propTypes:
    # requires a TinyProfilerClient instance
    client: React.PropTypes.object.isRequired

  render: ->
    div
      className: "tinyprofiler"
      div
        className: "requests"
        (@renderRequest req for req in @props.client.getRequests())

  renderRequest: (req) ->
    request
      key: req.getId()
      request: req

request = React.createClass
  displayName: "TinyProfiler Request"

  render: ->
    req = @props.request
    div
      className: "request"
      id: req.getId()
      div
        className: "name"
        req.getName()
      div
        className: "details"
        req.getDetails()
      div
        className: "start"
        req.getStart()
      div
        className: "length"
        req.getLength()
      div
        className: "steps"
        (@renderStep i, child for i, child of req.getSteps())

  renderStep: (i, child) ->
    step
      key: i
      step: child

step = React.createClass
  displayName: "TinyProfiler Step"

  render: ->
    st = @props.step
    div
      className: "step"
      div
        className: "name"
        st.getName()
      div
        className: "details"
        st.getDetails()
      div
        className: "start"
        st.getStart()
      div
        className: "length"
        st.getLength()
      div
        className: "steps"
        (@renderStep i, child for i, child of st.getSteps())

  renderStep: (i, child) ->
    step
      key: i
      step: child

module.exports = {tinyprofiler, request, step}
