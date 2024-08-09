require 'json'

RSpec.describe "Crashtracking" do
  it "sends crash report via telemetry error logs" do
    dir = ENV['CRASH_REPORTS_DIR'] || 'records'

    records = Dir.glob("#{dir}/**.json").sort

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
        family: "ruby",
      )
    )
  end
end
