require_relative '../models/address_book.rb'

 RSpec.describe AddressBook do
  #1, we create new instance of the AddressBook model and assign it to the variable named book using the let syntax provided by RSpec. This lets us use book in all our tests, removing the duplication of having to instantiate a new AddressBook for each test.

  let(:book) {AddressBook.new}
   # #6
  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eql expected_name
    expect(entry.phone_number).to eql expected_number
    expect(entry.email).to eql expected_email
  end
#2, we see context and it statements which are an RSpec paradigm to explain what we are testing. it explains the functionality of the method being tested in human readable form. RSpec will take the content from context and it and output them nicely to the command line when the test is executed. Read more about the differences between them.
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

       # Test that AddressBook's .import_from_csv() method is working as expected
      context ".import_from_csv" do
      it "imports the correct number of entries" do
  #3 after the context and it statements we call the import_from_csv method on the book object which is of type AddressBook (our data model). We pass import_from_csv the string entries.csv as a parameter. CSV files are a fairly typical way of dealing with data and you can read more about them here. On the next line we reference the AddressBook.entries variable to get its size. This variable will be an array. Next, we save the size of the AddressBook.entries to our local variable book_size.
      book.import_from_csv("entries.csv")
      book_size = book.entries.size

       # Check the size of the entries in AddressBook
      expect(book_size).to eql 5
     end
 # #4  we access the first entry in the array of entries that our AddressBook stores.
     it "imports the 1st entry" do
       book.import_from_csv("entries.csv")
       # Check the first entry
       entry_one = book.entries[0]
     end

     it "imports the 2nd entry" do
       book.import_from_csv("entries.csv")
       # Check the second entry
       entry_two = book.entries[1]
       check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "imports the 3rd entry" do
       book.import_from_csv("entries.csv")
       # Check the third entry
       entry_three = book.entries[2]
       check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "imports the 4th entry" do
       book.import_from_csv("entries.csv")
       # Check the fourth entry
       entry_four = book.entries[3]
       check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")

     end

    it "imports the 5th entry" do
       book.import_from_csv("entries.csv")
       # Check the fifth entry
       entry_five = book.entries[4]
       check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")

     end

      it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

          it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Billy")
       expect(entry).to be_nil
     end

     #entries from entries_2context "#import_from_csv" do
    it "imports the correct number of entries" do
    book.import_from_csv("entries_2.csv")
    book_size = book.entries.size
    expect(book_size).to eql 3
    end


    it "imports the 1st entry" do
    book.import_from_csv("entries_2.csv")
#   # Check the first entry
    entry_one = book.entries[0]
    check_entry(entry_one, "Billie", "415-555-4854", "billie@blocmail.com")
    end

    it "imports the 2nd entry" do
    book.import_from_csv("entries_2.csv")
#   # Check the second entry
    entry_two = book.entries[1]
    check_entry(entry_two, "Martha", "415-555-3660", "martha@blocmail.com")
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries_2.csv")
#   # Check the third entry
    entry_three = book.entries[2]
    check_entry(entry_three, "Rose", "415-555-5415", "rose@blocmail.com")
    end
  end

  # Test the binary_search method
   context "#binary_search" do
     it "searches AddressBook for a non-existent entry" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Dan")
       expect(entry).to be_nil
     end

      it "searches AddressBook for Bill" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Bill")
       expect entry.instance_of?(Entry)
       check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
     end
     it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

     it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Billy")
       expect(entry).to be_nil
     end
   end

#iterative search
context "#iterative_search" do
  it "searches AddressBook for a non-existent entry" do
    book.import_from_csv("entries.csv")
    entry = book.iterative_search("Dan")
    expect(entry).to be_nil
  end

   it "searches AddressBook for Bill" do
    book.import_from_csv("entries.csv")
    entry = book.iterative_search("Bill")
    expect entry.instance_of?(Entry)
    check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
  end
  it "searches AddressBook for Bob" do
    book.import_from_csv("entries.csv")
    entry = book.iterative_search("Bob")
    expect(entry).to be_a Entry
    check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
  end

  it "searches AddressBook for Joe" do
    book.import_from_csv("entries.csv")
    entry = book.iterative_search("Joe")
    expect(entry).to be_a Entry
    check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
  end

  it "searches AddressBook for Sally" do
    book.import_from_csv("entries.csv")
    entry = book.iterative_search("Sally")
    expect(entry).to be_a Entry
    check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
  end

  it "searches AddressBook for Sussie" do
    book.import_from_csv("entries.csv")
    entry = book.iterative_search("Sussie")
    expect(entry).to be_a Entry
    check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
  end

  it "searches AddressBook for Billy" do
    book.import_from_csv("entries.csv")
    entry = book.iterative_search("Billy")
    expect(entry).to be_nil
  end
end
#remove entry
     context ".remove_entry" do
      it "removes only one entry from the address book" do
      book = AddressBook.new
      entry = book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.remove_entry(entry)

      expect(book.entries.index(entry)).to be nil
      end
    end
 end
