class RetortApi
  require 'httparty'

  #TODO: Identity mirroring for retort endpoints
  #TODO: Rate limiting as needed
  #TODO: HTTPS on API
  #TODO: Handle failed requests to Retort
  #TODO: Setting to fall back on no-identity if no results found for an identity
  #TODO: Excluding specific identities (or creating inclusive identity groups)

  BASE_URL = 'http://www.retort.us/'

  def self.get_retort stimulus:
    json = JSON.parse HTTParty.get([
      BASE_URL,
      '/retort/get',
      "?stimulus=#{stimulus}"
    ].join).body

    json["response"]
  end

  def self.add_retort stimulus:, response:
    JSON.parse HTTParty.get([
      BASE_URL,
      '/retort/add',
      "?stimulus=#{stimulus}&response=#{response}"
    ].join).body
  end

  def self.get_opening_message
    json = JSON.parse HTTParty.get([
      BASE_URL,
      '/retort/random/opening'
    ].join).body

    json["response"]
  end

  def self.markov_chain identity: nil
    HTTParty.get([
      BASE_URL,
      '/markov/create',
      "?#{self.parameterize_hash identity}"
    ].join).body
  end

  def self.markov_ipsum identity: nil
    HTTParty.get([
      BASE_URL,
      '/markov/ipsum',
      "?#{self.parameterize_hash identity}"
    ].join).body
  end

  def self.get_word_before after_word, identity: {}
    json = JSON.parse HTTParty.get([
      BASE_URL,
      '/bigram/prior',
      "?after=#{after_word}#{parameterize_hash identity}"
    ].join).body

    json["prior"]
  end

  def self.get_all_words_before after_word, identity: {}
    JSON.parse HTTParty.get([
      BASE_URL,
      '/bigram/antecedents',
      "?after=#{after_word}#{parameterize_hash identity}"
    ].join).body
  end

  def self.get_word_after previous_word, identity: {}
    json = JSON.parse HTTParty.get([
      BASE_URL,
      '/bigram/next',
      "?prior=#{previous_word}#{parameterize_hash identity}"
    ].join).body

    json["after"]
  end

  def self.get_all_words_after previous_word, identity: {}
    JSON.parse HTTParty.get([
      BASE_URL,
      '/bigram/consequents',
      "?prior=#{previous_word}#{parameterize_hash identity}"
    ].join).body
  end

  def self.add_bigram prior, after, identity: {}
    JSON.parse HTTParty.get([
      BASE_URL,
      '/bigram/add',
      "?prior=#{prior}&after=#{after}#{parameterize_hash identity}"
    ].join).body
  end

  def self.parse_bigram message, identity: {}
    JSON.parse HTTParty.get([
      BASE_URL,
      '/bigram/parse',
      "?message=#{message}#{parameterize_hash identity}"
    ].join).body
  end

  private

  def self.parameterize_hash identity_hash
    # Turns {medium: 'twitter', identifier: 'drusepth'} to "&medium=twitter&identifier=drusepth"
    (identity_hash || {}).map { |key, value| "&#{key}=#{value}" }.join
  end

end