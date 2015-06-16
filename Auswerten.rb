require 'axlsx'

con = File.read("./log.txt")
con = con.split("\n")

p = Axlsx::Package.new
p.workbook.add_worksheet(:name => "Basic Worksheet") do |sheet|
  sheet.add_row ["UserId", "Gruppe", "Gender", "Produkte", "Marken", "Angesehen", "schwer Bedienbar", "Auto Farben", "Gesang", "Biere", "Bestes Video", "Zeiten"]
  con.each do |line|
      line = eval(line)
      f = line["fragen"]
      farben = "#{line["rot"]}, #{line["wei\u00DF"]}, #{line["gelb"]}, #{line["schwarz"]}, #{line["blau"]}, #{line["silber"]}"
        biere = "#{line["amberLager"]}, #{line["1873"]}, #{line["paleAle"]}, #{line["gold"]}, #{line["curuba"]}, #{line["scotch"]}"
        if f
            sheet.add_row [f["userID"], f["group"], f["gender"], f["produkte"], f["marken"], f["angesehen"], f["schwerBedienbar"], farben, line["gesangText"], biere, line["besteVideo"], f["times"]]
        end
    end
end
p.use_shared_strings = true
p.serialize('simple.xlsx')