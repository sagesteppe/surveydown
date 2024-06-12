function Pandoc(doc)
  -- Define the CSS styles
  local css = [[
  <style>
  #progressbar {
    background-color: #ECE8DF;
    padding: 3px;
    width: 100%;
    position: fixed;
    left: 0;
    z-index: 1000;
  }
  #progressbar.top {
    top: 0;
  }
  #progressbar.bottom {
    bottom: 0;
  }
  #progressbar > div {
    background-color: #4CAF50;
    width: 0%;
    height: 10px;
    border-radius: 0;
  }
  body {
    padding-top: 20px;
  }
  </style>
  ]]

  -- Define the HTML for the progress bar
  local progressbar_top = [[
  <div id="progressbar" class="top">
    <div id="progress"></div>
  </div>
  ]]

  local progressbar_bottom = [[
  <div id="progressbar" class="bottom">
    <div id="progress"></div>
  </div>
  ]]

  -- Convert the CSS to a pandoc element
  local css_block = pandoc.RawBlock('html', css)

  -- Insert the CSS at the beginning of the document
  table.insert(doc.blocks, 1, css_block)

  -- Get the progress bar position from the metadata
  local position = pandoc.utils.stringify(doc.meta['progressbar'] or 'none')

  -- Insert the progress bar at the specified position
  if position == "top" then
    table.insert(doc.blocks, 2, pandoc.RawBlock('html', progressbar_top))
  elseif position == "bottom" then
    table.insert(doc.blocks, pandoc.RawBlock('html', progressbar_bottom))
  end

  return doc
end
