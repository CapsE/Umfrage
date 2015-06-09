require 'sinatra'

configure do
	enable :sessions

	set :bind, '0.0.0.0'
end

hotwheelsInteractive = "https://www.youtube.com/embed/vPGhqQ9vZPM"
hotwheels = "https://www.youtube.com/embed/peGQtWR4iys"

pepsiInteractive = "https://content_s-a.akamaihd.net/player/pepsi/release/1.5/index.html?publisherID=embedded&has_view_count=false"
pepsi = "https://www.youtube.com/embed/vn19MC0VKqg"

hondaInteractive = "http://hondatheotherside.com/index.php?x=en-gb"
hondaNormal = "https://www.youtube.com/embed/KBL05l2Epvo"

becks = "https://www.youtube.com/embed/RMheM3__tFw"
lidl = "https://www.youtube.com/embed/FeqLDkZqoUI"
iPad = "https://www.youtube.com/embed/_gUK0Dtauvo"
ikea = "https://www.youtube.com/embed/7Q0RCxxEag8"


$groupA = [becks, hondaInteractive, lidl, pepsi, iPad, ikea]
$groupB = [becks, hondaNormal, lidl, pepsiInteractive, iPad, ikea]

$times = {}
$user = {}

before do
    if !session["userID"]
        session["userID"] = Time.new.to_i
    end
end

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

get "/detailfragen" do
      if session["done"]
        redirect "/ende"
    end
    
   erb :detailfragen 
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
    params["userID"] = session["userID"]
    params["times"] = $times[session["userID"]]
    puts params
    $user[session["userID"]] = params
    
    #File.open("log.txt", 'a') { |file| file.write(params.to_s + "\n") }
    #session["done"] = true
    redirect "/detailfragen"
end
    
post "/detailData" do
    params["fragen"] = $user[session["userID"]]
    
    puts "POST 2"
    puts params
    File.open("log.txt", 'a') { |file| file.write(params.to_s + "\n") }
    session["done"] = true
    redirect "/ende"
end

post "/time" do
    puts "POST"
    puts params
    puts "UserID"
    puts session["userID"]
    if !$times[session["userID"]]
        $times[session["userID"]] = {params["video"] => params["time"]}
    else
        $times[session["userID"]][params["video"]] = params["time"]
    end
end

get "/ende" do
    erb :ende
end

get "/result" do
    
    erb :result
end