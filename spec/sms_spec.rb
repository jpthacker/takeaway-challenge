require "sms"

RSpec.describe SMS do
    it "sends a confirmation message to the user" do
        twilio_mock = double :fake_twilio
        messages_mock = double :messages
        expect(messages_mock).to receive(:create).with({:body=>"Thank you for ordering with us. Your order should arrive before 10:45", :from=>"+15076154403", :to=>"+447527393010"})
        client_mock = double :fake_client, messages: messages_mock
        expect(twilio_mock).to receive(:new).and_return(client_mock)
        sms = SMS.new(twilio_mock)
        sms.send("07527393010", "10:45")
    end
end