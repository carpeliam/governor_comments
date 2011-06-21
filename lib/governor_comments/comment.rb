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
      
      base.scope :hidden, base.where(:hidden => true)
      base.scope :public, base.where(:hidden => false)
      
      base.validates_presence_of :content
      base.validates_presence_of :commenter
      base.validates_associated :commenter
    end
    
    def mark_spam
      update_attribute(:hidden, true)
      spam! if respond_to?(:spam!)
    end
    
    def not_spam
      update_attribute(:hidden, false)
      ham! if respond_to?(:ham!)
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