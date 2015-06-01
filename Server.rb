require 'sinatra'

enable :sessions

get "/" do
    erb :index
end

get "/video" do
    if session["watched"]
        if session["watched"] >= 2
            redirect "/frage"
        else
            @videoURL = "http://c.brightcove.com/services/viewer/federated_f9?&width=480&height=270&flashID=myExperience1336793692001&bgcolor=%23FFFFFF&playerID=628326721001&playerKey=AQ~~%2CAAAAipOT3SE~%2CXOUBEALy-nLVEcJyZQqZLSFOCu_qnHxq&isVid=true&isUI=true&dynamicStreaming=true&autoStart=true&%40videoPlayer=1861758658001&debuggerID=&startTime=1432713595271"
        end
    else
        @videoURL = "http://hondatheotherside.com/index.php?x=en-gb"
        session["watched"] = 0
    end
    session["watched"] += 1
    erb :video
end

get "/frage" do
   erb :frage 
end

get "/reset" do
    session["watched"] = nil
    redirect "/"
end

post "/data" do
    
    redirect "/ende"
end

get "/ende" do
    
end