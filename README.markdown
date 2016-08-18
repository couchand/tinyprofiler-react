tinyprofiler-react
==================

ReactJS front-end for TinyProfiler

  * introduction
  * getting started
  * documentation

introduction
------------

[tinyprofiler][0] is a minimal isomorphic JavaScript profiler.  This
package is a front-end for *tinyprofiler* built using the
[React.js][1] framework.  It is primarily intended to be part of a
larger application built with React, but can be used independently
in any front-end as well.

getting started
---------------

First you'll need to set up *tinyprofiler* on the server and the
shared [tinyprofiler-client][2] in the browser.  Then simply create
the markup for your client instance with code such as this:

```javascript
var ui = require('tinyprofiler-react');
var reactComponent = ui.renderComponent(
  tinyprofilerClient,
  { position: 'sw' }
);
```

or this,

```javascript
ui.renderElement(
  tinyprofilerClient,
  document.getElementById("tp")
);
```

or this,

```javascript
var stringValue = ui.renderString(
  tinyprofilerClient
);
```

documentation
-------------

*coming soon*

##### ╭╮☲☲☲╭╮ #####

[0]: https://github.com/couchand/tinyprofiler
[1]: https://facebook.github.io/react
[2]: https://github.com/couchand/tinyprofiler-client
