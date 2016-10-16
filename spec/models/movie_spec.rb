
describe Movie do
  describe 'searching Tmdb by keyword' do
    context 'with valid key' do

      it 'should return an array of hashes containing movies after a search' do
        matching_movies = Movie.find_in_tmdb('star wars')
        expect(matching_movies).not_to be_empty
      end

      it 'should return an empty array if search is empty' do
        matching_movies = Movie.find_in_tmdb('')
        expect(matching_movies).to be_empty
      end
    end


    # context 'with invalid key' do
    #   it 'should raise InvalidKeyError if key is missing or invalid' do
    #     # search = Tmdb::Search.new
    #     allow(Tmdb::Search.new).to receive(:fetch).and_raise(Tmdb::InvalidApiKeyError)
    #     expect {Movie.find_in_tmdb('Batman') }.to raise_error(Movie::InvalidKeyError)
    #   end
    # end
  end

  describe 'creating movie by selection' do
    it 'should call create method' do
      # movie_params = {
      #     :title => 'Ted',
      #     :rating =>'R',
      #     :release_date => '2012-06-29 00:00:00 UTC'
      # }
      #
      # allow(Movie).to receive(:create_from_tmdb).with('72105')
      # expect(Movie).to receive(:create).with(movie_params)
    end
  end
end


