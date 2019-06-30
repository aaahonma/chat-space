# 未更新のメッセージは配列データで受け取る
# 返された配列データに中身があった際のみデータを定義
if @new_messages.present?
    json.array! @new_messages do |message|
        json.content message.content
        json.image message.image.url
        json.created_at message.created_at.strftime("%Y/%m/%d %H:%M")
        json.user_nickname message.user.nickname
        json.group_id message.group.id
        json.user_id message.user.id
        json.id message.id
    end
end
