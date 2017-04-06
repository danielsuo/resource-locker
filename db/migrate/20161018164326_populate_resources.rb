class PopulateResources < ActiveRecord::Migration[5.0]
  def change
    Resource.create(name: 'pni-fat')
    Resource.create(name: 'mmx-fat')
    Resource.create(name: 'xeonphi-li')
  end
end
