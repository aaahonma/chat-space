json.(@message, :content, :image)
json.id  @message.id
json.group_id  @message.group.id
json.user_id  @message.user.id
json.user_nickname @message.user.nickname
json.user_name @message.user.name
json.created_at @message.created_at.strftime("%Y/%m/%d %H:%M")
json.image @message.image.url

# jbuilderの記述ルール
# json.KEY VALUE
# json.(@message, :content, :image)の記述が謎