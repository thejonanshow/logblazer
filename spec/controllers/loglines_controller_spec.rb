require 'rails_helper'

RSpec.describe LoglinesController, type: :controller do
  describe "POST #create" do
    let(:data) {
      { id: "0006b9:27:eb:be", level: "debug", line: "test log line" }
    }

    let(:line) {
      "id:#{data[:id]} - #{data[:line]}"
    }
    
    it "returns created" do
      post :create, params: data
      expect(response).to have_http_status(:created)
    end

    ["debug", "warn", "error"].each do |level|
      it "logs a line at #{level} level" do
        data[:level] = level
        data[:line] = "#{data[:line]} for #{level}"

        expect(Rails.logger).to receive(level.to_sym).with(line)
        post :create, params: data
      end
    end
  end

end
