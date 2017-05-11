# Retort

This gem wraps the Retort API available at http://www.retort.us.

# How to use

`require 'retort'`

# Example usage

Including the gem
```
~/Code/indent/retort-gem (master *)$ irb
irb(main):001:0> require 'retort'
=> true
```

Getting a response to a stimulus
```
irb(main):002:0> Retort.get_retort stimulus: 'hey'
=> "sup"
```

Adding a shared response to a stimulus
```
irb(main):003:0> Retort.add_retort stimulus: 'hey dogman', response: "I'm more of a catman"
=> {"id"=>86, "stimulus"=>"hey dogman", "response"=>"I'm more of a catman", "created_at"=>"2017-05-11T14:45:30.807Z", "updated_at"=>"2017-05-11T14:45:30.807Z"}
```

Getting another response to a stimulus
```
irb(main):004:0> Retort.get_retort stimulus: 'hey dogman'
=> "I'm more of a catman"
```

Get a random message that can open a cold conversation
```
irb(main):005:0> Retort.get_opening_message
=> "hey man, what's up?"
```

Generate a random markov chain, optionally styled to a particular identity
```
irb(main):006:0> Retort.markov_chain identity: { medium: 'bible' }
=> "Learn the Nemuelites: of God, keep me back again: wherefore consider, and justice: for morning light."

irb(main):022:0> Retort.markov_chain identity: { medium: 'music', channel: 'lyrics', identifier: 'kanyewest' }
=> "Never, ever, never over a spit my mom break it down (get down)."
```

Get a random word seen used before "cow"
```
irb(main):007:0> Retort.get_word_before 'cow'
=> "meaty"
irb(main):008:0> Retort.get_word_before 'cow'
=> "Holy"
```

Get a list of all words seen used before "cow" (warning: very large list)
```
irb(main):009:0> Retort.get_all_words_before('cow').count
=> 199662
```

Get a random word seen used after "holy"
```
irb(main):010:0> Retort.get_word_after 'holy'
=> "shit."
```

Get a list of all words seen used after "turtles" (warning: very large list)
```
irb(main):011:0> Retort.get_all_words_after('turtles').count
=> 153719
```

Manually add a bigram to Retort
```
irb(main):012:0> Retort.add_bigram 'there', "aren't"
=> {"id"=>2315831, "prior"=>nil, "after"=>nil, "created_at"=>"2016-05-22T08:47:02.840Z", "updated_at"=>"2016-05-22T08:47:02.840Z", "identifier"=>nil, "medium"=>nil, "channel"=>nil}
```

Parse a string into its constituent bigrams
```
irb(main):013:0> Retort.parse_bigram "The one and only", identity: { medium: 'test', identifier: 'readme' }
=> [
  {"id"=>3462984, "prior"=>nil, "after"=>"The", "created_at"=>"2017-05-11T14:50:23.961Z", "updated_at"=>"2017-05-11T14:50:23.961Z", "identifier"=>"readme", "medium"=>"test", "channel"=>nil},
  [
    {"id"=>3462985, "prior"=>"The", "after"=>"one", "created_at"=>"2017-05-11T14:50:25.054Z", "updated_at"=>"2017-05-11T14:50:25.054Z", "identifier"=>"readme", "medium"=>"test", "channel"=>nil},
    {"id"=>3462986, "prior"=>"one", "after"=>"and", "created_at"=>"2017-05-11T14:50:26.087Z", "updated_at"=>"2017-05-11T14:50:26.087Z", "identifier"=>"readme", "medium"=>"test", "channel"=>nil},
    {"id"=>3462987, "prior"=>"and", "after"=>"only", "created_at"=>"2017-05-11T14:50:26.442Z", "updated_at"=>"2017-05-11T14:50:26.442Z", "identifier"=>"readme", "medium"=>"test", "channel"=>nil}
  ],
  {"id"=>3462988, "prior"=>"only", "after"=>nil, "created_at"=>"2017-05-11T14:50:26.869Z", "updated_at"=>"2017-05-11T14:50:26.869Z", "identifier"=>"readme", "medium"=>"test", "channel"=>nil}
]
```
