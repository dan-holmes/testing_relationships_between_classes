require_relative "../lib/secret_diary"

### WARNING ###
# For the purposes of this exercise, you are testing after
# the code has been written. This means your tests are prone
# to false positives!
#
# Make sure your tests work by deleting the bodies of the
# methods in `secret_diary.rb`, like this:
#
# ```ruby
# def write(new_message)
# end
# ```
#
# If they fail, then you know your tests are working
# as expected.
### WARNING ###

RSpec.describe SecretDiary do
  let(:diary) { double(:diary) }
  let(:secret_diary) { SecretDiary.new(diary) }
  context "when locked" do
    before { secret_diary.lock }
    it "refuses to be read" do
      expect(secret_diary.read).to eq "Go away!"
      expect(diary).not_to receive(:read)
      secret_diary.read
    end

    it "refuses to be written" do
      expect(secret_diary.write("test")).to eq "Go away!"
      expect(diary).not_to receive(:write)
      secret_diary.write("test")
    end
  end

  context "when unlocked" do
    before { secret_diary.unlock }
    it "gets read" do
      expect(diary).to receive(:read)
      secret_diary.read
    end

    it "gets written" do
      expect(diary).to receive(:write).with("test")
      secret_diary.write("test")
    end
  end
end
