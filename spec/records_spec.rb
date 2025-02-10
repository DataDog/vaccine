require "json"

RSpec.describe "Records" do
  def records
    Dir.glob("#{ENV["RECORDS_DIR"] || "records"}/**.json")
  end

  describe "trace records" do
    let(:trace_data) do
      records.map{ |r| JSON.parse(File.read(r), symbolize_names: true) }.find{|r|r[:request][:path].include?("/traces")}
    end

    it do
      expect(trace_data).to a_hash_including(
        request: hash_including(
          method: "POST",
          path: "/v0.4/traces",
          headers: hash_including("content-type": "application/msgpack"),
          body: an_instance_of(Array).and(having_attributes(length: 1))
        )
      )

      render_span, controller_span, rack_span = trace = trace_data[:request][:body].first

      expect(trace.map { |s| s[:trace_id] }.uniq.length).to eq(1)

      expect(render_span).to a_hash_including(name: "rails.render_template")
      expect(controller_span).to a_hash_including(name: "rails.action_controller")
      expect(rack_span).to a_hash_including(name: "rack.request")
    end
  end

  describe "crash report records" do
    it do
      crash_report = records.last

      data = JSON.parse(File.read(crash_report), symbolize_names: true)

      expect(data).to a_hash_including(
        request: a_hash_including(
          method: "POST",
          path: "/telemetry/proxy/api/v2/apmtelemetry",
          body: a_hash_including(
            request_type: "logs",
            payload: an_instance_of(Array)
          )
        )
      )

      payloads = data.dig(:request, :body, :payload)
      expect(payloads.length).to eq(1)

      payload = payloads.first
      expect(payload).to a_hash_including(
        message: an_instance_of(String),
        level: "ERROR",
        tags: a_string_matching(/SIGSEGV/)
      )

      message = JSON.parse(payload[:message], symbolize_names: true)
      expect(message).to a_hash_including(
        :additional_stacktraces,
        :files,
        metadata: a_hash_including(
          :tags,
          family: "ruby"
        )
      )
    end
  end
end
