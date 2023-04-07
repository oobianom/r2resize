// remove the 'no-js' class to enable the split content display
document.querySelectorAll('.no-js').forEach(el => {
  el.classList.remove('no-js')
})

// Locate all the components in the page
const splitContainers = document.querySelectorAll('.split-container')

// This helper function returns the position of the cursor regardless of the event's type (mouse or touch)
function touchOrMousePosition (event) {
  if(/^touch/.test(event.type)) return event.touches[0].clientX
  return event.clientX
}

splitContainers.forEach(container => {
  // Define the variables used to calculate the dragging effect
  var positionX = 0
  var containerPositionX = container.getBoundingClientRect().left
  var containerWidth = container.clientWidth
  var active = false
  // Locate the right container
  const splitContentRight = container.querySelector('.split-content-right')
  // Add the separator
  const separator = document.createElement('div')
  separator.className = 'separator'
  separator.style.marginLeft = '50%'
  container.appendChild(separator)

  // Declare the event listeners
  container.addEventListener("touchstart", dragStart, false)
  container.addEventListener("mousedown", dragStart, false)

  container.addEventListener("touchend", dragEnd, false)
  container.addEventListener("mouseup", dragEnd, false)

  container.addEventListener("touchmove", drag, false)
  container.addEventListener("mousemove", drag, false)

  // Dragging functions
  function dragStart(e) {
    // Get the position of the cursor
    containerPositionX = container.getBoundingClientRect().left
    containerWidth = container.clientWidth
    positionX = touchOrMousePosition(e) - containerPositionX // Instead of using the offsetX property, we are using the clientX property and position of the container (offsetX would use the position of the container's child we click/hover on, resulting with a "jumpy" drag effect)
    positionX = positionX < 0 ? 0 : positionX > containerWidth ? containerWidth : positionX // this line keeps the positionX bound to the containers dimensions
    // apply the cursor's position to the right content clip path & to the separator
    setClipPath(positionX)
    setSeparator(positionX)
    // set the separator and the variable as active
    separator.classList.add('active') // will allow to maintain a "hover" effect on the separator during the dragging
    active = true // necessary for the (mouse|touche)move event (and the drag() function)
  }

  function drag(e) {
    if (active) {
      // Make sure no other event or native behavior is triggered during the dragging
      e.preventDefault()
      // Get the position of the cursor
      positionX = touchOrMousePosition(e) - containerPositionX // Instead of using the offsetX property, we are using the clientX property and the position of the container (offsetX would use the position of the container's child we click/hover on, resulting with a "jumpy" drag effect)
      positionX = positionX < 0 ? 0 : positionX > containerWidth ? containerWidth : positionX
      // apply the cursor's position to the right content clip path & to the separator
      setClipPath(positionX)
      setSeparator(positionX)
    }
  }

  function dragEnd(e) {
    // set the separator and the variable as NOT active
    separator.classList.remove('active')
    active = false
  }

  // Position functions
  function setClipPath(positionX) {
    const path = `polygon(${positionX}px 0%, 100% 0%, 100% 100%, ${positionX}px 100%)`
    splitContentRight.style.clipPath =  path
    splitContentRight.style.webkitClipPath = path // Necessary for Safari (both MacOS and iOS)
  }
  function setSeparator(positionX) {
    separator.style.marginLeft = positionX + 'px'
  }
})

