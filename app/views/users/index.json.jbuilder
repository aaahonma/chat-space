json.array! @users do |user|
    json.id user.id
    json.nickname user.nickname
    json.name user.name
    json.email user.email
    json.icon_image user.icon_image
    json.introduction user.introduction
end
# 配列でjson情報を返したいときはarray!と記述([]の配列で情報が囲われる)
# array!の例：[{"id":1, "tile":"オオカミ少女と黒王子",  "image":"http://image～.jpeg", "detail": "八田鮎子の同名人気コミック～"}]