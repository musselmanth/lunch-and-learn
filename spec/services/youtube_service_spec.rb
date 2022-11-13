require 'rails_helper'

RSpec.describe YoutubeService do
  it 'returns expected video results for mr history channel', vcr: {cassette_name: 'laos video results'} do
    videos = YoutubeService.get_mr_history_videos("laos")
    expect(videos).to have_key(:items)
    expect(videos[:items]).to be_an Array
    first_video = videos[:items].first
      expect(first_video).to be_a Hash
      expect(first_video[:id][:videoId]).to be_a String
      expect(first_video[:snippet][:title]).to be_a String
  end
end