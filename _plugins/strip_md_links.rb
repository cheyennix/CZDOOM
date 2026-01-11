Jekyll::Hooks.register :documents, :pre_render do |document|
  # Get the site's baseurl
  baseurl = document.site.config['baseurl'] || ''
  
  # Convert markdown links with .md extension
  # Pattern: [text](path.md) or [text](/path.md)
  document.content = document.content.gsub(/\[([^\]]+)\]\(([^)]+?)\.md\)/) do
    link_text = $1
    link_path = $2
    
    # Skip if it's an external URL
    next $& if link_path =~ /^https?:\/\//
    
    # Add leading slash if not present
    link_path = "/#{link_path}" unless link_path.start_with?('/')
    
    # Remove baseurl if it's already there to avoid doubling
    link_path = link_path.sub(/^#{Regexp.escape(baseurl)}/, '')
    
    # Construct the link with baseurl
    "[#{link_text}](#{baseurl}#{link_path}/)"
  end
end

Jekyll::Hooks.register :pages, :pre_render do |page|
  # Get the site's baseurl
  baseurl = page.site.config['baseurl'] || ''
  
  # Same conversion for pages
  page.content = page.content.gsub(/\[([^\]]+)\]\(([^)]+?)\.md\)/) do
    link_text = $1
    link_path = $2
    
    # Skip if it's an external URL
    next $& if link_path =~ /^https?:\/\//
    
    # Add leading slash if not present
    link_path = "/#{link_path}" unless link_path.start_with?('/')
    
    # Remove baseurl if it's already there to avoid doubling
    link_path = link_path.sub(/^#{Regexp.escape(baseurl)}/, '')
    
    # Construct the link with baseurl
    "[#{link_text}](#{baseurl}#{link_path}/)"
  end
end