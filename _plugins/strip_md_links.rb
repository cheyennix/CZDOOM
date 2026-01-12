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
    link_path = link_path.sub(/\/([^\/]+)\/\1$/, '/\1')
    
    # Construct the link with trailing slash
    "[#{link_text}](#{link_path}/)"
  end
  
  # Convert image paths to absolute paths
  document.content = document.content.gsub(/!\[([^\]]*)\]\(([^)]+?)\)/) do
    alt_text = $1
    image_path = $2
    
    # Skip if it's an external URL or already absolute
    next $& if image_path =~ /^https?:\/\// || image_path.start_with?('/')
    
    # Add leading slash to make it absolute
    "![#{alt_text}](/#{image_path})"
  end
end

Jekyll::Hooks.register :pages, :pre_render do |page|
  # Same conversion for pages - markdown links
  page.content = page.content.gsub(/\[([^\]]+)\]\(([^)]+?)\.md\)/) do
    link_text = $1
    link_path = $2
    
    # Skip if it's an external URL
    next $& if link_path =~ /^https?:\/\//
    
    # Add leading slash if not present
    link_path = "/#{link_path}" unless link_path.start_with?('/')
    
    # Remove redundant folder/file pattern
    link_path = link_path.sub(/\/([^\/]+)\/\1$/, '/\1')
    
    # Construct the link with trailing slash
    "[#{link_text}](#{link_path}/)"
  end
  
  # Convert image paths to absolute paths
  page.content = page.content.gsub(/!\[([^\]]*)\]\(([^)]+?)\)/) do
    alt_text = $1
    image_path = $2
    
    # Skip if it's an external URL or already absolute
    next $& if image_path =~ /^https?:\/\// || image_path.start_with?('/')
    
    # Add leading slash to make it absolute
    "![#{alt_text}](/#{image_path})"
  end
end