module GovernorComments
  module Comment
    require 'md5'
    def self.included(base)
      base.belongs_to :commenter, :polymorphic => true
      if defined?(Rakismet)
        base.send :include, Rakismet::Model
        base.rakismet_attrs :author => proc { commenter.name },
                            :author_email => proc { commenter.email },
                            :author_url => proc { commenter.website },
                            :comment_type => 'comment'
      end
      
      base.validates_presence_of :content
    end
    
    def gravatar_url(size = 48, default = "http://github.com/images/gravatars/gravatar-#{size}.png")
      if commenter.respond_to? :email
        hash = MD5::md5 commenter.email.downcase
        "http://www.gravatar.com/avatar/#{hash}?s=#{size}&r=pg&d=#{CGI::escape(default)}"
      else
        default
      end
    end
  end
end