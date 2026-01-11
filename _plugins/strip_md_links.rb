Jekyll::Hooks.register :documents, :pre_render do |document|
  # Convert markdown links with .md extension
  document.content = document.content.gsub(/\[([^\]]+)\]\(([^)]+?)\.md\)/) do
    link_text = $1
    link_path = $2
    
    # Skip if it's an external URL
    next $& if link_path =~ /^https?:\/\//
    
    # Add leading slash if not present
    link_path = "/#{link_path}" unless link_path.start_with?('/')
    
    # Remove redundant folder/file pattern (e.g., /cheyennix/cheyennix -> /cheyennix)
    # This handles cases like cheyennix/cheyennix.md -> /cheyennix/
    link_path = link_path.sub(/\/([^\/]+)\/\1$/, '/\1')
    
    # Construct the link with trailing slash
    "[#{link_text}](#{link_path}/)"
  end
end

Jekyll::Hooks.register :pages, :pre_render do |page|
  # Same conversion for pages
  page.content = page.content.gsub(/\[([^\]]+)\]\(([^)]+?)\.md\)/) do
    link_text = $1
    link_path = $2
    
    # Skip if it's an external URL
    next $& if link_path =~ /^https?:\/\//
    
    # Add leading slash if not present
    link_path = "/#{link_path}" unless link_path.start_with?('/')
    
    # Remove redundant folder/file pattern (e.g., /cheyennix/cheyennix -> /cheyennix)
    link_path = link_path.sub(/\/([^\/]+)\/\1$/, '/\1')
    
    # Construct the link with trailing slash
    "[#{link_text}](#{link_path}/)"
  end
end