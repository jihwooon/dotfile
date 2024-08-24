local status, markdown = pcall(require, 'markdown')
if not status then return end

markdown.setup {}
