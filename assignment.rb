class Assignment
  def initialize(conversation_id)
    load_config
    @base_url = "https://api.intercom.io/"
    @headers = {"Authorization" => "Bearer " + ENV['IC_ACCESS_TOKEN'], "Accept" => "application/json"}
    @conversation_id = conversation_id
    @assigner_id = ENV['ASSIGNER_ID'] || @config['assigner_id']
    @teams = @config['teams']
    process
  end
  
  def load_config
    if file = File.read('config.json')  
      @config = JSON.parse(file)
    else
      puts "An error occured, have you created a config file by running init.rb?"
      halt 500
    end
  end

  def process
    conversation = fetch_conversation
    id = find_last_inbox (conversation)
  end

  def fetch_conversation
    conversation = HTTParty.get(URI.encode(@base_url + 'conversations/' + @conversation_id), :headers => @headers)
    return conversation
  end

  def find_last_inbox (conversation)
    conversation['conversation_parts']['conversation_parts'].reverse.each_with_index do |part, i|
      assigned = part['assigned_to']['id'] unless part['assigned_to'].nil?
      if (i == 0) || (i == 1)
        next
      end
      if @teams.include? assigned || assigned.nil?
        assign(assigned) unless assigned.nil?
        break
      end
    end
  end

  def assign (id)
    params = { "body": "", "type": "admin", "admin_id": @assigner_id, "assignee_id": id, "message_type": "assignment"}
    conversation = HTTParty.post(URI.encode(@base_url + 'conversations/' + @conversation_id + '/reply'), :headers => @headers, :query => params)
  end
end
