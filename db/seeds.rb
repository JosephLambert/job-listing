
#--------------------------new seeds.rb-------------------------

puts 'this seed will create an admin account automatically, 30 public jobs, and 30 hidden jobs'

create_account = User.create([email: 'admin@test.com', password: '123456', password_confirmation: '123456', is_admin: 'true'])

puts 'Admin account created.'

create_account_user = User.create([email: '478911359@b.com', password: '123456', password_confirmation: '123456', is_admin: 'false'])

puts 'User account created.'

company_info = [['Apple Inc.', 'Cupertino, CA, US'],
                ['Samsung Electronics', 'Suwon, South Korea'],
                ['Amazon.com', 'Seattle, WA, US'],
                ['HP Inc. + HPE', 'Palo Alto, CA, US'],
                ['Microsoft', 'Redmond, WA, US'],
                ['IBM', 'Armonk, NY, US'],
                ['Alphabet Inc.', 'Mountain View, CA, US'],
                ['Dell Technologies', 'Austin, TX, US'],
                ['Huawei', 'Shenzhen, China'],
                ['Xiaomi', 'Beijing, China']]

jobs_info = [['Web Application Developer', 'Creates, maintains and implements web-based application systems. Resolves issues and recommends enhancements, when necessary. Has knowledge of HTML, Java and related concepts. Relies on knowledge and professional discretion to plan and accomplish goals. Usually reports to a department head. Significant ingenuity and flexibility is expected. May require a bachelor’s degree in a related area and at least 2-4 years of relevant experience.'],
             ['Android Developer', 'Designs and builds applications for the Android platform. Works with outside data sources and API’s. Fixes bugs and improves application performance. Collaborates with cross-functional teams to determine and launch new features. Should have knowledge of core web technologies (HTML5, CSS3, JavaScript). Requires a bachelor’s degree in area of specialty and 2 years of relevant experience.'],
             ['iOS Developer', 'Designs and builds applications for the iOS platform. Works with outside data sources and API’s. Fixes bugs and improves application performance. Collaborates with cross-functional teams to determine and launch new features. Should have knowledge of core web technologies (HTML5, CSS3, JavaScript). Requires a bachelor’s degree in area of specialty and 2 years of relevant experience.'],
             ['Interface Designer', 'Create interfaces for a variety of web-based applications. Designs and evaluates visual human interfaces utilizing user-centric design principles. Works with the product development team to achieve desired user experience. Ensures that interfaces function to achieve desired business goals. Relies on established guidelines and instructions to perform daily job functions. Works under immediate supervision and usually reports to a supervisor. May require an associate’s degree with 0-2 years of relevant experience.'],
             ['Webmaster', 'Manages an organization’s overall web presence. Monitors web traffic and ensures website is prepared to meet traffic demands and performance expectations. Leads the development and design of the website to enhance appearance and usability. Requires a working knowledge of HTML, JavaScript and SQL. Relies on knowledge and professional discretion to plan and accomplish goals. Works under general supervision and usually reports to a supervisor, though some ingenuity and flexibility is required. May require a bachelor’s degree and 2-4 years of experience.'],
             ['Human Resources Manager', 'Managers need to develop their interpersonal skills to be effective. Organisations behaviour focuses on how to improve factors that make organisations more effective.'],
             ['Full Stack developer', 'Full stack means you do everything end to end in one area.A full stack programmer does front and back end programming and does the software architecture, coding, QA, etc. '],
             ['Accountant', 'An accountant is a practitioner of accounting or accountancy, which is the measurement, disclosure or provision of assurance about financial information that helps managers, investors, tax authorities and others make decisions about allocating resource(s).'],
             ['Teller', 'A bank teller (often abbreviated to simply teller) is an employee of a bank who deals directly with customers. In some places, this employee is known as a cashier or customer representative.[1] Most teller jobs require experience with handling cash and a high school diploma. Most banks provide on-the-job training.'],
             ['Secretary', 'A secretary or personal assistant is a person whose work consists of supporting management, including executives, using a variety of project management, communication, or organizational skills.']]

category_and_contact_info = [['IT', '111@111.com'],
                             ['None-profit', '222@222.com'],
                             ['Financial', '000@000.com'],
                             ['Education', '333@333.com'],
                             ['Administration', '444@444.com'],
                             ['Legal', '555@555.com'],
                             ['HR', '666@666.com'],
                             ['Marketing', '777@777.com'],
                             ['Health Care', '888@888.com'],
                             ['Design', '999@999.com']]

create_jobs = for i in 1..30 do
                  job_test = jobs_info[rand(0..9)]
                  company_test = company_info[rand(0..9)]
                  otherinfo_test = category_and_contact_info[rand(0..9)]
                  Job.create!([title: job_test[0], description: job_test[1], wage_upper_bound: rand(50..99) * 100,
                               wage_lower_bound: rand(10..49) * 100, is_hidden: 'false', location: company_test[1], company: company_test[0], category: otherinfo_test[0], contact_email: otherinfo_test[1]])
end

puts '30 Public jobs created.'

create_jobs = for i in 1..30 do
                  job_test = jobs_info[rand(0..9)]
                  company_test = company_info[rand(0..8)]
                  otherinfo_test = category_and_contact_info[rand(0..9)]
                  Job.create!([title: job_test[0], description: job_test[1], wage_upper_bound: rand(50..99) * 100,
                               wage_lower_bound: rand(10..49) * 100, is_hidden: 'true', location: company_test[1], company: company_test[0], category: otherinfo_test[0], contact_email: otherinfo_test[1]])
end

puts '30 Hidden jobs created.'
