require_relative "entry.rb"

require "csv"

 class AddressBook
   attr_accessor :entries

   def initialize
     @entries = []
   end

   def add_entry(name, phone, email)
 # #9
     index = 0
     @entries.each do |entry|
 # #10
       if name < entry.name
         break
       end
       index += 1
     end
 # #11
     @entries.insert(index, Entry.new(name, phone, email))
   end

def binary_search(name)
 # #1
     lower = 0
     upper = entries.length - 1

 # #2
     while lower <= upper
 # #3
       mid = (lower + upper) / 2
       mid_name = entries[mid].name

 # #4
       if name == mid_name
         return entries[mid]
       elsif name < mid_name
         upper = mid - 1
       elsif name > mid_name
         lower = mid + 1
       end
     end

 # #5
     return nil
   end

def iterative_search(name)
  @entries.each do |entry|
    if entry.name == name
      return entry
    end
  end
  return nil
end

   def remove_entry(entry)
    @entries.delete(entry)
  end
#7, we defined import_from_csv. The method starts by reading the file, using File.read. The file will be in a CSV format. We use the CSV class to parse the file. The result of CSV.parse is an object of type CSV::Table.
  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
 # #8  we iterate over the CSV::Table object's rows. On the next line we create a hash for each row. We convert each row_hash to an Entry by using the add_entry method which will also add the Entry to the AddressBook's entries.
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end

  end

 end
