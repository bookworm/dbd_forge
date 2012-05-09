require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
  
describe "Artifact Model" do        
  setup do   
    @artifact = Artifact.with_all.first
  end       
  
  should "create a new artifact" do 
    artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
    artifact.save     
    assert artifact.errors.size == 0
  end  

  should "return incompatible extensions" do 
    assert @artifact.incompatibilities.count > 0
  end     
  
  should "add incompatibility" do  
    prev_count = @artifact.incompatibilities.count 
    incompatibility = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    incompatibility.save  
    
    @artifact.add_incompatibility(incompatibility)
    @artifact.save
    assert @artifact.incompatibilities.count > prev_count
  end 
  
  should "return compatible extensions" do 
    assert @artifact.compatibilities.count > 0
  end     
  
  should "add compatibility" do  
    prev_count = @artifact.compatibilities.count 
    compatibility = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    compatibility.save  
    
    @artifact.add_compatibility(compatibility)
    @artifact.save
    assert @artifact.compatibilities.count > prev_count
  end
  
  should "return dependencies" do  
    assert @artifact.dependencies.count > 0
  end     
  
  should "add dependency" do  
    prev_count = @artifact.dependencies.count 
    dependency = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    dependency.save  
    
    @artifact.add_dependency(dependency)
    @artifact.save
    assert @artifact.dependencies.count > prev_count
  end
  
  should "return integrations" do   
    assert @artifact.integrations.count > 0
  end       
  
  should "add integration" do 
    prev_count = @artifact.integrations.count 
    integration = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    integration.save  
    
    @artifact.add_integration(integration)
    @artifact.save
    assert @artifact.integrations.count > prev_count
  end
    
  should "return vulnerabilites" do  
    assert @artifact.vulnerabilities.count > 0
  end  
  
  should "add vulnerabilities" do 
    prev_count = @artifact.vulnerabilities.count 
    vulnerability = Vulnerability.new(:details => Faker::Lorem.paragraphs(2).join(" "), 
      :fix_url => 'https://github.com/miniJs/miniCount/zipball/master',
      :artifact_id => @artifact.id)
    vulnerability.save  
    
    @artifact.add_vulnerability(vulnerability)
    @artifact.save
    assert @artifact.vulnerabilities.count > prev_count
  end
end