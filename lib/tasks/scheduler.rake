desc "This task automatically removes content that is old"
task :disable_old_posts => :environment do
  puts "Disabling old posts..."
  Post.clean
  puts "done."
end

# TODO: Generalize this to a campaign and add a campaign id argument
task :launch_hit => :environment do

	begin ; require 'rubygems' ; rescue LoadError ; end

	# Create a HIT for this environment

	require 'ruby-aws'
	@mturk = Amazon::WebServices::MechanicalTurkRequester.new :Host => :Production

	# Use this line instead if you want to talk to Prod
	#@mturk = Amazon::WebServices::MechanicalTurkRequester.new :Host => :Production


	# Check to see if your account has sufficient funds
	def hasEnoughFunds?
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
	def createHIT

	  # Defining the location of the file containing the QuestionForm and the properties of the HIT
	  rootDir = File.dirname $0;
	  #questionFile = "/home/pkinnair/.rvm/gems/ruby-2.0.0-p247/gems/ruby-aws-1.6.0/samples/mturk/best_image/best_image.question";
		questionFile = "config/recruit_twitterer.question";
	  propertiesFile = "config/recruit_twitterer.properties";

	  # Loading configuration properties from a HIT properties file.
	  # In this sample, the qualification is defined in the properties file.
	  props = Amazon::Util::DataReader.load( propertiesFile, :Properties )
	  props[:Reward] = { :Amount => 0.50, :CurrencyCode => 'USD'}
	  # Loading the question (QuestionForm) file.
	  question = File.read( questionFile )
	  # no validation
	  result = @mturk.createHIT( {:Question => question}.merge(props) )
	  puts "Created HIT: #{result[:HITId]}"
	  puts "Url: #{getHITUrl( result[:HITTypeId] )}"

	  # save the HIT Id to a file so we don't lose it...
	  Amazon::Util::DataReader.save( File.join( rootDir, "hits_created" ), [{:HITId => result[:HITId] }], :Tabular )
	end

	createHIT if hasEnoughFunds?

end

task :decode_test_data => :environment do
	require 'rack'
	puts Marshal.load(Base64.decode64("BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjFmdDd2MFFoZzhFYUs0UTdkM2tZbTdBOURKaG5iR203QXFFbjJrYVlZYlVJPQY7AEZJIgpvYXV0aAY7AFR7BkkiDHR3aXR0ZXIGOwBUewZJIhdjYWxsYmFja19jb25maXJtZWQGOwBUVEkiCW5hbWUGOwBGSSIPaSAjSnVzdGljZQY7AFRJIgh1aWQGOwBGaQY="))
end