require 'spec_helper'

describe CoinRPC do
  describe '#http_post_request' do
    it 'raises custom error on connection refused' do
      Net::HTTP.any_instance.stubs(:request).raises(Errno::ECONNREFUSED)

      rpc_client = CoinRPC['btc']

      expect {
        rpc_client.http_post_request ''
      }.to raise_error(CoinRPC::ConnectionRefusedError)
    end
  end
end
