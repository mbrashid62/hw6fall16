
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
    #     allow(Tmdb::Movie).to receive(:find).and_raise(Tmdb::InvalidApiKeyError)
    #     expect {Movie.find_in_tmdb('Batman') }.to raise_error(Movie::InvalidKeyError)
    #   end
    # end
  end
end


