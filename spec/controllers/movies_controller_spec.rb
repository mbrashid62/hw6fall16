require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
   it 'should call the model method that performs TMDb search' do
      fake_results = [double('movie1'), double('movie2')]
      expect(Movie).to receive(:find_in_tmdb).with('Ted').
        and_return(fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
    end
    it 'should select the Search Results template for rendering' do
      # allow(Movie).to receive(:find_in_tmdb)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(response).to render_template('search_tmdb')
    end  

    it 'should make the TMDb search results available to that template' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(assigns(:movies)).to eq(fake_results) # Rspec 'assigns' method keeps track of what instance variables were assigned in the controller method
    end

   it 'should make the TMDb search term available to that template' do
     fake_results = [double('Movie'), double('Movie')]
     allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
     post :search_tmdb, {:search_terms => 'Ted'}
     expect(assigns(:search_term)).to eq('Ted')
   end

   it 'should return an array of hashes, where each element of the array is a hash containing information about the movie' do
     fake_results = [{
         :tmdb_id => 52,
          :title => 'Ted',
          :rating =>'R',
          :release_date => '2016-10-13 00:00:00'
         },
         {
          :tmdb_id=> 53,
          :title => 'Ted 2',
          :rating =>'R',
          :release_date => '2016-10-13 00:00:00'
         }
     ]
     allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
     post :search_tmdb, {:search_terms => 'Ted'}
     expect(assigns(:movies)).to eq(fake_results)
   end

   it 'should check for invalid search terms' do
     post :search_tmdb, {:search_terms => ''}
     expect(response).to redirect_to('/movies')
   end

    it 'should redirect to the homepage if no matching movie results are found on TMDb' do
      post :search_tmdb, {:search_terms => ';alkdjfal;kdjfl;akjdf'}
      expect(response).to redirect_to('/movies')
    end
  end

  describe 'adding TMDb' do
    it 'should call the model method that adds the movie to the db for each added movie' do
      expect(Movie).to receive(:create_from_tmdb).with('72105')
      expect(Movie).to receive(:create_from_tmdb).with('214756')
      post :add_tmdb, {:checkbox => {'72105':'1','214756':'1'}}
    end

    it 'should redirect to the movies view after adding movies to the db' do
       post :add_tmdb, {:checkbox => {'72105':'1','214756':'1'}}
       expect(response).to redirect_to('/movies')
    end

    it 'should return to movies page if no movies are selected' do
      post :add_tmdb, {:checkbox => nil}
      expect(response).to redirect_to('/movies')
    end
  end
end
