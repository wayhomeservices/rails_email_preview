require 'rails_email_preview/engine'

module RailsEmailPreview
  mattr_accessor :preview_classes

  class << self
    def run_before_render(mail)
      (defined?(@hooks) && @hooks[:before_render] || []).each do |block|
        block.call(mail)
      end
    end

    def before_render(&block)
      ((@hooks ||= {})[:before_render] ||= []) << block
    end

    def setup
      yield self
    end
  end

  # = Editing settings
  # edit link is rendered inside an iframe, so these options are provided for simple styling
  mattr_accessor :edit_link_text
  self.edit_link_text  = '✎ Edit Text'
  mattr_accessor :edit_link_style
  self.edit_link_style = <<-CSS.strip.gsub(/\n+/m, ' ')
    display: block;
    font-family: "Monaco", "Helvetica", sans-serif;
    color: #7a4b8a;
    border: 2px dashed #7a4b8a;
    font-size: 20px;
    padding: 8px 12px;
    margin-top: 1em;
  CSS
end
