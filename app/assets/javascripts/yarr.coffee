#= require 'ContentTools/content-tools'

styleSet = [
  {name: 'Lead', cssClass: 'lead', elements: ['p']},
  {name: 'Uppercase', cssClass: 'text-lowercase', elements: ['p']},
  {name: 'Lowercase', cssClass: 'text-uppercase', elements: ['p']},
  {name: 'Capitalize', cssClass: 'text-capitalize', elements: ['p']},

  {name: 'Attribute', cssClass: 'attribute', elements: ['abbr']},
  {name: 'Initialism', cssClass: 'initialism', elements: ['abbr']},

  {name: 'Reverse', cssClass: 'blockquote-reverse', elements: ['blockquote']},

  {name: 'Unstyled', cssClass: 'list-unstyled', elements: ['li', 'ul']},
  {name: 'Inline', cssClass: 'list-inline', elements: ['li', 'ul']},

  {name: 'Horizontal', cssClass: 'dl-horizontal', elements: ['dl']},

  {name: 'Formatted', cssClass: 'table', elements: ['table']},
  {name: 'Striped', cssClass: 'table-striped', elements: ['table']},
  {name: 'Bordered', cssClass: 'table-bordered', elements: ['table']},
  {name: 'Hover', cssClass: 'table-hover', elements: ['table']},
  {name: 'Condensed', cssClass: 'table-condensed', elements: ['table']},

  {name: 'Active', cssClass: 'active', elements: ['tr']},
  {name: 'Success', cssClass: 'success', elements: ['tr']},
  {name: 'Info', cssClass: 'info', elements: ['tr']},
  {name: 'Warning', cssClass: 'warning', elements: ['tr']},
  {name: 'Danger', cssClass: 'danger', elements: ['tr']},

  {name: 'Button Default', cssClass: 'btn btn-default', elements: ['a']},
  {name: 'Button Primary', cssClass: 'btn btn-primary', elements: ['a']},
  {name: 'Button Success', cssClass: 'btn btn-success', elements: ['a']},
  {name: 'Button Info', cssClass: 'btn btn-info', elements: ['a']},
  {name: 'Button Warning', cssClass: 'btn btn-warning', elements: ['a']},
  {name: 'Button Danger', cssClass: 'btn btn-danger', elements: ['a']}
]

window.addEventListener 'load', ->

  for style in styleSet
    ctStyle = new ContentTools.Style(style['name'], style['cssClass'], style['elements'])
    ContentTools.StylePalette.add ctStyle

  editor = ContentTools.EditorApp.get()
  editor.init('*[data-editable]', 'data-name')

  editor.bind 'save', (regions)->
    # Set the editor as busy while we save our changes
    @busy(true)

    # Collect the contents of each region into a FormData instance
    payload = new FormData

    for name of regions
      if regions.hasOwnProperty(name)
        payload.append(name, regions[name])

    csrfToken = document.querySelector('head > meta[name=csrf-token]')

    payload.append('authenticity_token', csrfToken.content) if csrfToken.content?

    # Send the update content to the server to be saved
    onStateChange = (ev)->
      # Check if the request is finished
      if ev.target.readyState == 4
        editor.busy(false)

        if (ev.target.status.toString() == '200')
          # Save was successful, notify the user with a flash
          new ContentTools.FlashUI('ok')
        else
          # Save failed, notify the user with a flash
          new ContentTools.FlashUI('no')

    xhr = new XMLHttpRequest
    xhr.addEventListener('readystatechange', onStateChange)
    xhr.open('POST', '/yarr/page/save')
    xhr.send(payload)
