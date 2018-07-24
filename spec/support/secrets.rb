# Mock Rails.application.secrets.secret_key_base).first.symbolize_keys
class Rails::Application
  def self.secret
    'b8f3ade070ece4ade4cdfe878e3dcce98ac7ba4b7509237bd1c95d639981b77ee49b38fc82a214519061ce45b054aafcc7a992b89ab033cdd095e83cbeac901b'
  end
end
