#= require es5-shim.min
#= require es5-sham.min
#= require jquery
#= require jquery_ujs
#= require jquery-timing.min
#= require bootstrap
#= require bootstrap-switch.min
#= require scrollIt
#= require moment
#= require bignumber
#= require underscore
#= require handlebars.runtime
#= require introjs
#= require ZeroClipboard
#= require flight.min
#= require pusher.min
#= require list
#= require jquery.mousewheel
#= require jquery-timing.min
#= require qrcode
#= require cookies.min

#= require ./lib/notifier
#= require ./lib/pusher_connection

#= require highstock
#= require_tree ./highcharts/

#= require_tree ./helpers
#= require_tree ./component_mixin
#= require_tree ./component_data
#= require_tree ./component_ui
#= require_tree ./templates

@App =
  showInfo:   (msg) -> $(document).trigger 'flash-info',   msg: msg
  showNotice: (msg) -> $(document).trigger 'flash-notice', msg: msg
  showAlert:  (msg) -> $(document).trigger 'flash-alert',  msg: msg

$ ->
  BigNumber.config(ERRORS: false)

  if $('#assets-index').length
    $.scrollIt
      topOffset: -180
      activeClass: 'active'

    $('a.go-verify').on 'click', (e) ->
      e.preventDefault()

      root         = $('.tab-pane.active .root.json pre').text()
      partial_tree = $('.tab-pane.active .partial-tree.json pre').text()

      if partial_tree
        uri = 'http://syskall.com/proof-of-liabilities/#verify?partial_tree=' + partial_tree + '&expected_root=' + root
        window.open(encodeURI(uri), '_blank')

  $('[data-clipboard-text], [data-clipboard-target]').each ->
    zero = new ZeroClipboard $(@), forceHandCursor: true

    zero.on 'complete', ->
      $(zero.htmlBridge)
        .attr('title', gon.clipboard.done)
        .tooltip('fixTitle')
        .tooltip('show')
    zero.on 'mouseout', ->
      $(zero.htmlBridge)
        .attr('title', gon.clipboard.click)
        .tooltip('fixTitle')

    placement = $(@).data('placement') || 'bottom'
    $(zero.htmlBridge).tooltip({title: gon.clipboard.click, placement: placement})

  $('.qrcode-container').each (index, el) ->
    $el = $(el)
    new QRCode el,
      text:   $el.data('text')
      width:  $el.data('width')
      height: $el.data('height')

  SignUpUI.attachTo('#new_identity')
  SmsAuthVerifyUI.attachTo('#edit_sms_auth')
  FlashMessageUI.attachTo('.flash-message')
  TwoFactorAuth.attachTo('.two-factor-auth-container')
