class @Progressbar

  renderProgress : (options)->
    options = options || {}
    defaults =
      steps: $("#progressBar").find "div"
      barWidth: $("#progressBar").outerWidth()
      scaleLine: $ "#scaleLine"

    options = $.extend  {}, defaults, options
    drawProgress options.steps, options.barWidth, options.scaleLine


  drawProgress = ($steps, barWidth, scaleLine)->
    prevCounter = 0
    scaleMarks = ""
    $steps.each (i, step)->
      $step = $ step
      percentage = parseInt $step.data 'percentage'
      stepMark = $step.data 'step'

      if percentage > 0
        prevCounter++
        stepWidth = percentage * barWidth / 100;
        gap = (stepWidth * prevCounter) - stepWidth
        widthCalculated = stepWidth + gap
        $step.addClass 'order-' + prevCounter
        $step.animate({ width: widthCalculated }, 500)

        widthCalculated-- if prevCounter == 5
        scaleMarks += "<div class='line-mark' style='width:" + widthCalculated  + "px;'>" + stepMark + "&nbsp;</div>"

    scaleLine.html scaleMarks

    titleUpdate prevCounter

    if prevCounter == 0
      console.log "Zero percent complete"

  titleUpdate = (counter)->
    percentage = counter * 20
    $("#percentage").html percentage + "%"

$ () ->
  progressBar = new Progressbar()
  progressBar.renderProgress()
  $(window).bind 'page:change', progressBar.renderProgress