require "rails_helper"

RSpec.describe "Movies CRUD", type: :request do
  let(:valid_attrs) do
    {
      title: "Inception",
      rating: "PG-13",
      description: "Dream within a dream.",
      release_date: "2010-07-16"
    }
  end

  let(:invalid_attrs) do
    {
      title: "",
      rating: "X",
      description: "",
      release_date: ""
    }
  end

  it "GET /movies (index) works" do
    get movies_path
    expect(response).to have_http_status(:ok)
  end

  it "GET /movies/new works" do
    get new_movie_path
    expect(response).to have_http_status(:ok)
  end

  it "POST /movies creates with valid params and redirects to show" do
    expect {
      post movies_path, params: { movie: valid_attrs }
    }.to change(Movie, :count).by(1)

    movie = Movie.last
    expect(response).to redirect_to(movie_path(movie))
    follow_redirect!
    expect(response.body).to include("Movie created!").or include(movie.title)
  end

  it "POST /movies with invalid params re-renders new" do
    expect {
      post movies_path, params: { movie: invalid_attrs }
    }.not_to change(Movie, :count)

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "GET /movies/:id (show) works" do
    movie = Movie.create!(valid_attrs)
    get movie_path(movie)
    expect(response).to have_http_status(:ok)
  end

  it "GET /movies/:id/edit works" do
    movie = Movie.create!(valid_attrs)
    get edit_movie_path(movie)
    expect(response).to have_http_status(:ok)
  end

  it "PATCH /movies/:id updates and redirects" do
    movie = Movie.create!(valid_attrs)
    patch movie_path(movie), params: { movie: { title: "Inception (2010)" } }
    expect(response).to redirect_to(movie_path(movie))
    expect(movie.reload.title).to eq("Inception (2010)")
  end

  it "PATCH /movies/:id with invalid params re-renders edit" do
    movie = Movie.create!(valid_attrs)
    patch movie_path(movie), params: { movie: { rating: "X" } }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(movie.reload.rating).to eq("PG-13")
  end

  it "DELETE /movies/:id destroys and redirects to index" do
    movie = Movie.create!(valid_attrs)
    expect {
      delete movie_path(movie)
    }.to change(Movie, :count).by(-1)

    expect(response).to redirect_to(movies_path)
  end
end
