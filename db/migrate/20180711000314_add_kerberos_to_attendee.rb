class AddKerberosToAttendee < ActiveRecord::Migration[5.2]
  def change
  	add_column :attendees, :kerberos, :string
  end
end
