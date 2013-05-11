class AddClaimableToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :claimable, :integer
  end
end
