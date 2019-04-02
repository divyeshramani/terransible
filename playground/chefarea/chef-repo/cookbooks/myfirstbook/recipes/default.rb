file "/tmp/testfile.txt" do
  content "Hello World! - This is Chef managed file."
  action :create
end
