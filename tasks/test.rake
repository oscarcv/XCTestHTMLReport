namespace :test do

desc "Run the UI Tests"

  desc 'Run the UI Tests and create an HTML Report'
  task :ui  do
    puts "Deleting previous test results"
    system "rm -rf 'TestResults'"

    puts "Running tests"
    system "xcodebuild test -workspace XCTestHTMLReport.xcworkspace -scheme XCTestHTMLReportSampleApp -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.3' -verbose -resultBundlePath TestResults | xcpretty"

    puts "Generating report"
    system "xchtmlreport -r TestResults -v"
  end

  desc 'Run the UI Tests in // in multiple devices and create an HTML Report'
  task :ui_parallel  do
    puts "Deleting previous test results"
    system "rm -rf 'TestResults'"

    puts "Running tests"
    system "xcodebuild test -workspace XCTestHTMLReport.xcworkspace -scheme XCTestHTMLReportSampleApp -destination 'platform=iOS Simulator,name=iPhone X,OS=11.3' -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.3' -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.3' -verbose -resultBundlePath TestResults | xcpretty"

    puts "Generating report"
    system "xchtmlreport -r TestResults -v"
  end

  desc 'Run the UI Tests in split in multiple devices and create an HTML Report'
  task :ui_split  do
    puts "Deleting previous test results"
    system "rm -rf 'TestResults1'"
    system "rm -rf 'TestResults2'"

    puts "Running tests"
    system "xcodebuild test -workspace XCTestHTMLReport.xcworkspace -scheme XCTestHTMLReportSampleApp -only-testing:XCTestHTMLReportSampleAppUITests/FirstSuite -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.3' -verbose -resultBundlePath TestResults1 | xcpretty"
    system "xcodebuild test -workspace XCTestHTMLReport.xcworkspace -scheme XCTestHTMLReportSampleApp -only-testing:XCTestHTMLReportSampleAppUITests/SecondSuite -destination 'platform=iOS Simulator,name=iPhone X,OS=11.3' -verbose -resultBundlePath TestResults2 | xcpretty"

    puts "Generating report"
    system "xchtmlreport -r TestResults1 TestResults2 -v"
  end

end
