module ChromeRemote
  class Client
    def send_cmd_async(command, params = {})
      msg_id = generate_unique_id
      payload = {method: command, params: params, id: msg_id}.to_json

      logger.info "SEND ► #{payload}"
      ws.send_msg(payload)
      msg_id
    end

    def send_cmd(command, params = {})
      msg_id = send_cmd_async command, params

      msg = read_until { |msg| msg["id"] == msg_id }
      msg["result"]
    end
  end
end
