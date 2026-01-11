Jekyll::Hooks.register :documents, :pre_render do |document|
  # Convert links with .md extension to Jekyll permalinks
  # Handles both absolute (/path/file.md) and relative (path/file.md) links
  document.content = document.content.gsub(/\[([^\]]+)\]\(([^):]+)\.md\)/) do |match|
    link_text = $1
    link_path = $2
    
    # Add leading slash if not present and not a URL (no http/https)
    link_path = "/#{link_path}" unless link_path.start_with?('/')
    
    # Convert to permalink format
    "[#{link_text}](#{link_path}/)"
  end
end

Jekyll::Hooks.register :pages, :pre_render do |page|
  # Same conversion for pages
  page.content = page.content.gsub(/\[([^\]]+)\]\(([^):]+)\.md\)/) do |match|
    link_text = $1
    link_path = $2
    
    # Add leading slash if not present and not a URL (no http/https)
    link_path = "/#{link_path}" unless link_path.start_with?('/')
    
    # Convert to permalink format
    "[#{link_text}](#{link_path}/)"
  end
end