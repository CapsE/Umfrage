require 'axlsx'

con = File.read("./log.txt")
con = con.split("\n")

p = Axlsx::Package.new
p.workbook.add_worksheet(:name => "Basic Worksheet") do |sheet|
  sheet.add_row ["UserId", "Gender", "Produkte", "Marken"]
  con.each do |line|
      line = eval(line)
      f = line["fragen"]
      sheet.add_row [f["userID"], f["gender"], f["produkte"], f["marken"]]
  end
end
p.use_shared_strings = true
p.serialize('simple.xlsx')