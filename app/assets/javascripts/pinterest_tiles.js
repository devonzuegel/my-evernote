var colCount = 0;
var colWidth = 0;
var windowWidth = 0;
var blocks = [];

function positionBlocks() {
  $('.tiled').each(function () {
    var min = Array.min(blocks),
        index = $.inArray(min, blocks),
        leftPos = margin + (index * (colWidth + margin));
    $(this).css({
      'left': leftPos + 'px',
      'top': min + 'px'
    });
    blocks[index] = min + $(this).outerHeight() + margin;
  });
}

function setupBlocks() {
  windowWidth = $('.wrapper').width();
  if (windowWidth <= 768) { return; }
  colWidth = $('.tiled').outerWidth();
  margin = (windowWidth - colWidth * 3) /4;
  blocks = [];
  colCount = Math.floor(windowWidth / (colWidth + margin));
  for (var i = 0; i < colCount; i++)  blocks.push(margin);
  positionBlocks();
  $('.wrapper').height(Array.max(blocks));
}

$(function () {
  $(window).resize(setupBlocks);
});

// Function to get the Min value in Array
Array.min = function (array) {
  return Math.min.apply(Math, array);
};
// Function to get the Max value in Array
Array.max = function (array) {
  return Math.max.apply(Math, array);
};

$(document).ready(function() {
  setupBlocks();
});