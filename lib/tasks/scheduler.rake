require 'dotenv/tasks'

namespace :app do
  desc "This task automatically removes content that is old"
  task :disable_old_posts => :environment do
    puts "Disabling old posts..."
    Post.clean
    puts "done."
  end

  desc "This task launches a new Mechanical Turk HIT"
  task :launch_hit, [:campaign_id] => :environment do |t, args|

    puts "AMAZON ACCESS KEY: " + ENV['AMAZON_ACCESS_KEY']

    puts "Requiring needed libraries"
  	begin ; require 'rubygems' ; rescue LoadError ; end
  	require 'ruby-aws'

    # Get the Campaign
  
    puts "Acquiring Campaign object " + args.to_s
    @campaign = Campaign.find(args[:campaign_id])

  	# Create a HIT for this environment

    puts "Getting an object to use MTurk"
  	@mturk = Amazon::WebServices::MechanicalTurkRequester.new

  	# Use this line instead if you want to talk to Prod
  	#@mturk = Amazon::WebServices::MechanicalTurkRequester.new :Host => :Production

  	# Check to see if your account has sufficient funds
  	def hasEnoughFunds?
  	  puts "Checking for available MTurk balance..."
  	  available = @mturk.availableFunds
  	  puts "Got account balance: %.2f" % available
  	  return available > 0.055
  	end

  	def getHITUrl( hitTypeId )
  	  if @mturk.host =~ /sandbox/
  	    "http://workersandbox.mturk.com/mturk/preview?groupId=#{hitTypeId}" # Sandbox Url
  	  else
  	    "http://mturk.com/mturk/preview?groupId=#{hitTypeId}" # Production Url
  	  end
  	end
  
  	# Create the BestImage HIT
  	def createHIT(campaign)

  	  puts "Loading configuration properties from database."
  	  # In this sample, the qualification is defined in the properties file.
  	  props = Amazon::Util::DataReader.parse_properties(campaign.turk_properties)
  	  props[:Reward] = { :Amount => 0.50, :CurrencyCode => 'USD'}
  	  puts "Properties: " + props.to_s
  	  # Loading the question (QuestionForm) file.
  	  question = campaign.turk_question
  	  puts "Parsed all configuration information"

  	  # no validation
  	  puts "Creating HIT..."
  	  result = @mturk.createHIT( {:Question => question}.merge(props) )
  	  puts "Created HIT: " + result.to_s
  	  
  	  # Save the result to the database so we don't lose it
  	  hit = TurkHit.new
  	  hit.hit_id = result[:HITId]
  	  hit.hit_type_id = result[:HITTypeId]
  	  hit.save
  	end

  	createHIT(@campaign) if hasEnoughFunds?
  end
end

task :decode_test_data => :environment do
	require 'rack'
	puts Marshal.load(Base64.decode64("BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmdDd2MFFoZzhFYUs0UTdkM2tZbTdBOURKaG5iR203QXFFbjJrYVlZYlVJPQY7AEZJIgpvYXV0aAY7AFR7BkkiDHR3aXR0ZXIGOwBUewZJIhdjYWxsYmFja19jb25maXJtZWQGOwBUVEkiCW5hbWUGOwBGSSIPaSAjSnVzdGljZQY7AFRJIgh1aWQGOwBGaQY="))
end