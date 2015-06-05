require 'sinatra'

enable :sessions

hotwheelsInteractive = "https://www.youtube.com/embed/vPGhqQ9vZPM"
hotwheels = "https://www.youtube.com/embed/peGQtWR4iys"

hondaInteractive = "http://hondatheotherside.com/index.php?x=en-gb"
hondaNormal = "https://www.youtube.com/embed/KBL05l2Epvo"

becks = "https://www.youtube.com/embed/RMheM3__tFw"
lidl = "https://www.youtube.com/embed/FeqLDkZqoUI"
iPad = "https://www.youtube.com/embed/_gUK0Dtauvo"
ikea = "https://www.youtube.com/embed/7Q0RCxxEag8"


$groupA = [becks, hondaInteractive, lidl, hotwheels, iPad, ikea]
$groupB = [becks, hondaNormal, lidl, hotwheelsInteractive, iPad, ikea]

get "/" do
    if session["done"]
        redirect "/ende"
    end
    
    if !session["group"]
        session["group"] = rand(2)
    end
    session["watched"] = 0
    erb :index
end

get "/video/:id" do
    id = params[:id].to_i
    if session["done"]
        redirect "/ende"
    end
    
    if session["group"] == 0
        @videoURL = $groupA[id]
    elsif session["group"] == 1
        @videoURL = $groupB[id]
    end
        
    @nextId = id + 1
    if @nextId > 6
        redirect "/frage" 
    end
    erb :video
end

get "/frage" do
    if session["done"]
        redirect "/ende"
    end
    
   erb :frage 
end

get "/reset" do
    session["watched"] = nil
    session["group"] = nil
    session["done"] = false;
    redirect "/"
end

post "/data" do
    if session["done"]
        redirect "/ende"
    end
    
    puts "POST"
    params["group"] = session["group"]
    puts params
    File.open("log.txt", 'a') { |file| file.write(params.to_s + "\n") }
    session["done"] = true
    redirect "/ende"
end

get "/ende" do
    erb :ende
end

get "/result" do
    
    erb :result
end