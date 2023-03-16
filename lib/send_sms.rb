require("bundler")
require "dotenv"
Dotenv.load("twilio_info.env")
Bundler.require()

class SMS
    def send(user_phone_number, time_estimate)
        account_sid = ENV["TWILIO_ACC_SID"]
        auth_token = ENV["TWILIO_AUTH_TOKEN"]

        @client = Twilio::REST::Client.new(account_sid, auth_token)

        @client.messages.create(
            from: "+15076154403",
            to: "+44#{user_phone_number[1..]}",
            body: "Thank you for ordering with us. Your order should arrive before #{time_estimate}",
        )
    end
end
