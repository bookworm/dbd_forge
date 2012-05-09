require 'ffaker'
plan = Plan.first(:name => 'main')        

unless plan
  shell.say "Creating THE plan."  

  plan = Plan.new(:amount => 2500, :interval => "month", :title => "The one and only plan", :name => 'main') 
  plan.save     
end

unless Padrino.env == :production      
  if Account.all.count < 3
    shell.say "Creating some accounts. 3 to be exact"
    
    3.times do |i|    
      account = Account.new(:email => Faker::Internet.email, :username => Faker::Internet.user_name, :name => Faker::Name.name, :password => 'testpass', 
        :password_confirmation => 'testpass')    
      account.save 
         
      account = Account.find_by_id(account.id)  
      card = {
        :number    => 4242424242424242,
        :exp_month => 8,
        :exp_year  => 2013
      } 
      account.update_stripe(:card => card)
    end    
  end
  
  shell.say "Creating some artifacts. 10 to be exact"
  
  10.times do |i|         
    tags = Faker::Lorem.words(3).push('cats')
    artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master', :tags => tags)  
    artifact.save
  end
  
  shell.say "Creating some artifacts with integrations. 2 to be exact"  
  
  2.times do |i| 
    artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
    artifact.save
  
    integration = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    integration.save  
  
    integration2 = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    integration2.save
  
    artifact.add_integration(integration)     
    artifact.add_integration(integration2)
    artifact.save
  end  
  
  shell.say "Creating some artifacts with vulnerabilites. 2 to be exact"  
  
  2.times do |i| 
    artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
    artifact.save
  
    vulnerability = Vulnerability.new(:details => Faker::Lorem.paragraphs(2).join(" "), 
      :fix_url => 'https://github.com/miniJs/miniCount/zipball/master',
      :artifact_id => artifact.id 
    ) 
    vulnerability.save  
  
    vulnerability2 = Vulnerability.new(:details => Faker::Lorem.paragraphs(2).join(" "), 
      :fix_url => 'https://github.com/miniJs/miniCount/zipball/master',
      :fixed  => true, :artifact_id => artifact.id 
    )
    vulnerability2.save
  
    artifact.add_vulnerability(vulnerability)       
    artifact.add_vulnerability(vulnerability2)
    artifact.save
  end  
  
  shell.say "Creating some artifacts with dependencies. 2 to be exact"  
  
  2.times do |i| 
    artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
    artifact.save
  
    dependency = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    dependency.save  
  
    dependency2 = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    dependency2.save
  
    artifact.add_dependency(dependency)
    artifact.add_dependency(dependency2)
    artifact.save
  end  
  
  shell.say "Creating some artifacts with compatibilities. 2 to be exact"  
  
  2.times do |i| 
    artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
    artifact.save
  
    compatibility = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    compatibility.save        
  
    compatibility2 = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    compatibility2.save
  
    artifact.add_compatibility(compatibility)      
    artifact.add_compatibility(compatibility2)
    artifact.save
  end
  
  shell.say "Creating some artifacts with incompatibilities. 2 to be exact"  
  
  2.times do |i| 
    artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
    artifact.save
  
    incompatibility = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    incompatibility.save        
  
    incompatibility2 = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    incompatibility2.save
  
    artifact.add_incompatibility(incompatibility)      
    artifact.add_incompatibility(incompatibility2)
    artifact.save
  end   
  
  shell.say "Creating some artifacts ith integrations, vulnerabilites, dependencies, compatibilities and incompatibilities. 3 to be exact"  
  
  3.times do |i| 
    artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
    artifact.save   
  
    integration = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    integration.save   
  
    vulnerability = Vulnerability.new(:details => Faker::Lorem.paragraphs(2).join(" "), 
      :fix_url => 'https://github.com/miniJs/miniCount/zipball/master',
      :artifact_id => artifact.id)
    vulnerability.save  
  
    dependency = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    dependency.save   
  
    compatibility = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    compatibility.save
  
    incompatibility = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
      :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
      :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
    incompatibility.save       
  
    artifact.add_integration(integration) 
    artifact.add_dependency(dependency)   
    artifact.add_compatibility(compatibility)     
    artifact.add_incompatibility(incompatibility) 
    artifact.add_vulnerability(vulnerability) 
    artifact.save
  end   
  
  artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => 'bob',
    :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
    :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
  artifact.save   
  
  integration = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
    :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
    :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
  integration.save   
  
  vulnerability = Vulnerability.new(:details => Faker::Lorem.paragraphs(2).join(" "), 
    :fix_url => 'https://github.com/miniJs/miniCount/zipball/master',
    :artifact_id => artifact.id)
  vulnerability.save  
  
  dependency = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
    :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
    :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
  dependency.save 
  
  compatibility = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
    :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
    :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
  compatibility.save 
  
  incompatibility = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => Faker::Internet.domain_word,
    :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
    :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')
  incompatibility.save       
  
  artifact.add_integration(integration) 
  artifact.add_dependency(dependency)     
  artifact.add_compatibility(compatibility)    
  artifact.add_incompatibility(incompatibility)     
  artifact.add_vulnerability(vulnerability) 
  artifact.save   
  
  shell.say "Create a few artifacts whose names we know"
  
  artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => 'george',
    :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
    :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
  artifact.save
  
  artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => 'joe',
    :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
    :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
  artifact.save
  
  artifact = Artifact.new(:name => Faker::Lorem.words(3).join(" "), :ext_name => 'sam',
    :desc => Faker::Lorem.paragraphs(2).join(" "), :version => '0.0.1', 
    :package_uri => 'https://github.com/miniJs/miniCount/zipball/master')  
  artifact.save
end