require 'redcarpet'
class Artifact
  include MongoMapper::Document    
  include MongoMapperExt::Tags 
  include MongoMapperExt::Markdown
  plugin MongoMapper::Plugins::Timestamps
  
  ## 
  # Keys. 
  # 
  key :name,        String    
  key :ext_name,    String  # This is the name used manifest XML file.          
  key :type,        String, :default => :component  
  key :desc,        String    
  key :intro,       String             
  key :version,     String  
  key :package_uri, String # URL to a zip package of the artifact.              
  key :homepage,    String      
  key :slug,        String    
  key :group,       String
  key :client,      String
     
  # Other Artifacts         
  key :compatible_ids,   Array
  key :incompatible_ids, Array  
  key :dependent_ids,    Array
  key :integration_ids,  Array     
         
  # Vulnerabilities     
  key :vulnerable,     Boolean, :default => false 
  key :vulnerable_ids, Array      

  # Key Settings.  
  mount_uploader :image, ImageUploader
  timestamps!    
  markdown :desc, :intro    
  
  ##
  # Callbacks
  # 
  
  before_save :gen_slug
  
  ## 
  # Associations
  #
  many :incompatibilities, :in => :incompatible_ids, :class => Artifact   
  many :compatibilities,   :in => :compatible_ids, :class => Artifact
  many :dependencies,      :in => :dependent_ids,    :class => Artifact    
  many :integrations,      :in => :integration_ids,  :class => Artifact       
  
  many :vulnerabilities, :in => :vulnerable_ids, :class => Vulnerability 
  
  ##
  # Scopes
  #
  scope :with_integrations, where(:integration_ids => {'$not' => { '$size' => 0 } })
  scope :with_incompatibilities, where(:incompatible_ids => {'$not' => { '$size' => 0 } })
  scope :with_dependencies, where(:dependent_ids => {'$not' => { '$size' => 0 } })
  scope :with_vulnerabilities, where(:vulnerabilities => {'$not' => { '$size' => 0 } }) 
  scope :with_compatibilities, where(:vulnerabilities => {'$not' => { '$size' => 0 } })    
  
  scope :with_all, where(:integration_ids => {'$not' => { '$size' => 0 } },  
    :incompatible_ids => {'$not' => { '$size' => 0 } },   
    :compatible_ids   => {'$not' => { '$size' => 0 } },  
    :dependent_ids    => {'$not' => { '$size' => 0 } },
    :vulnerable_ids   => {'$not' => { '$size' => 0 } },      
    :integration_ids  => {'$not' => { '$size' => 0 } }   
  ) 
  
  ## 
  # Validations
  # 
  
  validates_uniqueness_of :slug, :if => :slug_required?   
  
  ##
  # Accessors
  #
  
  def package()
    return self[:package_uri] unless self.package_uri.blank?
    # return file.current_path
  end
  
  ##
  # Adders.
  #
  
  def add_compatibility(compatibility)      
    if compatibility.is_a?(Artifact)    
      self[:compatible_ids] << compatibility.id.to_s   
    elsif compatibility.is_a?(String)
      self[:compatible_ids] << compatibility
    end
  end 

  def add_incompatibility(incompatibility)      
    if incompatibility.is_a?(Artifact)    
      self[:incompatible_ids] << incompatibility.id.to_s   
    elsif incompatibility.is_a?(String)
      self[:incompatible_ids] << incompatibility
    end
  end    
  
  def add_dependency(dependency)      
    if dependency.is_a?(Artifact)    
      self[:dependent_ids] << dependency.id.to_s   
    elsif dependency.is_a?(String)
      self[:dependent_ids] << dependency
    end
  end 
  
  def add_integration(integration)      
    if integration.is_a?(Artifact)    
      self[:integration_ids] << integration.id.to_s   
    elsif integration.is_a?(String)
      self[:integration_ids] << integration
    end
  end      
  
  def add_vulnerability(vulnerability)
    self[:vulnerable] = !vulnerability.fixed?  
    if vulnerability.is_a?(Vulnerability)    
      self[:vulnerable_ids] << vulnerability.id.to_s   
    elsif vulnerability.is_a?(String)
      self[:vulnerable_ids] << vulnerability
    end
  end 
  
  def install_instructions()     
    return "forge install #{self.slug}"
  end 
  
  ##
  # Validations
  #
  
  def slug_required?() 
    return !self[:slug].blank?
  end       
  
  ##
  # Callbacks
  # 
  
  def gen_slug()         
    if self.slug.blank?         
      self[:slug] = self.ext_name.parameterize.underscore
    end
  end
end