class Guest < Hobo::Model::Guest

  def administrator?
    false
  end

  def is_voter?(election)
    false
  end
end

