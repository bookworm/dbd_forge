task :emptydb => :environment do   
  unless Padrino.env == :production
    AccessKey.all.each { |a| a.destroy }  
    Account.all.each { |a| a.destroy }
    Artifact.all.each { |a| a.destroy }
    Plan.all.each { |a| a.destroy }
    Vulnerability.all.each { |a| a.destroy }
  end
end