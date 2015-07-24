require_relative '../models/address_book.rb'

RSpec.describe AddressBook do

  let(:book) { AddressBook.new }

   context "attributes" do
     it "should respond to entries" do
       expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
       expect(book.entries).to be_a(Array)
    end

    it "should initialize entries as empty" do
       expect(book.entries.size).to eq 0
    end
   end

   context "#add_entry" do
     it "adds only one entry to the address book" do
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

       expect(book.entries.size).to eq 1
     end

     it "adds the correct information to entries" do
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       new_entry = book.entries[0]

       expect(new_entry.name).to eq 'Ada Lovelace'
       expect(new_entry.phone_number).to eq '010.012.1815'
       expect(new_entry.email).to eq 'augusta.king@lovelace.com'
      end
    end

      context ".import_from_csv" do
     it "imports the correct number of entries" do
 # #3
       book.import_from_csv("entries.csv")
       book_size = book.entries.size

       # Check the size of the entries in AddressBook
       expect(book_size).to eql 5
      end
      end

       context ".import_from_csv" do
     it "imports the correct number of entries" do
 # #3
       book.import_from_csv("entries_2.csv")
       book_size = book.entries.size

       # Check the size of the entries in AddressBook
       expect(book_size).to eql 3
      end
      end

     context ".remove_entry" do
      it "removes only one entry from the address book" do
      book = AddressBook.new
      entry = book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.remove_entry(entry)

      expect(book.entries.index(entry)).to be nil
      end
    end
end

