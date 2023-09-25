# 接口文件名:/root/sh/SendMsg
# 接口描述:利用企业微信发送报警
#
# 脚本中的调用方式:
#    . /root/sh/SendMsg
#
# 语法:
#    - 给单人或多人发企业微信消息(类似短信群发)
#        send_msg <消息接收者> <消息内容>
#        <消息接受者>:即成员ID列表,多个接收者用|分隔,最多支持1000个,如果指定为@all,则向该企业应用的全部成员发送
#        <消息内容>:纯文本
#
#    - 给企业微信群发消息
#        send_chat <消息内容>
#
#    - 手动更新企业微信群的信息
#        update_chat
#
#
# Tyler Wang
# 2018/9/11
#


check_token(){
  #检查access_token有效性,valid为1失效

  echo "$(date "+%F %T") | 检查access_token有效性..."
  if [ -f "${tokentmp}" ];then
    mytime1=`awk '{print $1}' ${tokentmp}`
    mytime2=`date +%s`
    mytime=$((mytime2-mytime1))
    if [ "${mytime}" -ge 7200 ];then
      echo "token超时."
      valid=1
    else
      valid=0
    fi
  else
    echo "token文件不存在."
    valid=1
  fi

  if [ "${valid}" -eq 1 ];then
    get_token
  else
    echo "token有效."
  fi

}


get_token(){
  #获取access_token

  echo "$(date "+%F %T") | 获取access_token..."
  #企业ID
  corpid="xxx"
  #secret是企业应用里保障数据安全的独立的访问密钥,务必不能泄漏
  secrect="xxx"
  #获取access_token并保存到文件,文件格式为:"当前系统时间戳 errcode access_token"
  geturl="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=${corpid}&corpsecret=${secrect}"
  # return like following
  # {"errcode":0,"errmsg":"ok","access_token":"aMlur5DlHxuvlkxcQYzcizdueYVyq5YDj32N5lvqSrGAZ4bl17u6tzgO8_X-zJjv7CXijULq8j_R4QIusbuFeyp4XtvgXXgOx2f-MKj_qjoJaEWDMXuBBWkRyf_-e_ooBaAiJNq7MqZAyzBsxeKzrdOf1g9JtoUQbKEJhYc-2XCCTvr1qpk1ot0iQW9YKtasWpa9V7vGXEtw5DqQY-ZAOg","expires_in":7200}
  curl "${geturl}"|tee t1.txt|awk '{match($0,"errcode\042:([^,]+).*access_token\042:\042([^\042]+)",a);print systime()" "a[1]" "a[2]>"'"${tokentmp}"'"}'
  #保证tokentmp能被其他用户写入
  chmod 777 ${tokentmp}
  #errcode非零则获取access_token失败
  errcode=`awk '{print $2}' ${tokentmp}`
  if [ "${errcode}" -ne 0 ];then
    echo "获取token失败."
    return 1
  else
    echo "获取token成功."
  fi

}


check_chat(){
  #检查群聊状态

  echo "$(date "+%F %T") | 检查群聊状态..."

  #调用check_token函数
  check_token

  case "$?" in
    0)
      #token有效
      access_token=`awk '{print $3}' ${tokentmp}`
      chaturl="https://qyapi.weixin.qq.com/cgi-bin/appchat/get?access_token=${access_token}&chatid=${chatid}"
      chatinfo=`curl "${chaturl}"`
      errcode=`echo ${chatinfo}|awk '{match($0,"errcode\042:([^,]+)",a);print a[1]}'`

      if [ "${errcode}" -eq 0 ];then
        #群聊存在
        valid=0
      else
        #无此群聊
        valid=1
      fi

      if [ "${valid}" -eq 1 ];then
        #创建群聊
        create_chat
      else
        echo "${chatinfo},群聊有效."
      fi
      ;;
    *)
      #get_token()-获取token失败时函数返回1
      echo "get_token()-获取token失败(返回码:$?),导致检查群聊状态失败."
      return 2
      ;;
  esac

}


create_chat(){
  #创建群聊,专门用于接收"运维报警"

  #群成员的id列表,格式:"hwang","jianguang.wu","yang.liu"
  chatuserlist=`echo ${chatusers}|awk -F"|" '{for(i=1;i<=NF;i++){printf("\042%s",i<NF?$i"\042,":$i"\042\n")}}'`

  echo "$(date "+%F %T") | 创建群聊..."

  mydata="{\"name\" : \"${chatname}\", \"owner\" : \"${chatowner}\", \"userlist\" : [${chatuserlist}], \"chatid\" : \"${chatid}\"}"
  createchaturl="https://qyapi.weixin.qq.com/cgi-bin/appchat/create?access_token=${access_token}"
  createchatinfo=`curl -X POST -H "Content-Type: application/json" -d "${mydata}" "${createchaturl}"`
  errcode=`echo ${createchatinfo}|awk '{match($0,"errcode\042:([^,]+)",a);print a[1]}'`

  if [ "${errcode}" -ne 0 ];then
    echo "${createchatinfo},创建群聊失败."
    return 3
  else
    echo "创建群聊成功."
  fi

}


send_msg(){
  #发送应用消息-消息类型-文本消息(给用户分别发消息,类似短信群发)

  #调用check_token函数
  check_token

  #get_token()-获取token失败时"return 1",即"$?"为1,其他情况token均有效,即"$?"为0
  if [ "$?" -eq 0 ];then
    echo "$(date "+%F %T") | 发送报警给用户..."
    access_token=`awk '{print $3}' ${tokentmp}`
    sendurl="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=${access_token}"
    #每个应用都有唯一的agentid
    agentid="1000006"
    mydata="{\"touser\" : \"$1\", \"msgtype\" : \"text\", \"agentid\" : ${agentid}, \"text\" : {\"content\" : \"$2\"}, \"safe\" : 0}"
    curl -X POST -H "Content-Type: application/json" -d "${mydata}" "${sendurl}"
  else
    echo "get_token()-获取token失败,导致无法发送报警给用户."
  fi

}


send_chat(){
  #发送应用消息到群聊会话-消息类型-文本消息(向群里发消息,便于协同工作)

  #调用check_chat函数
  check_chat

  case "$?" in
    0)
      #token有效
      echo "$(date "+%F %T") | 发送报警给群..."

      sendurl="https://qyapi.weixin.qq.com/cgi-bin/appchat/send?access_token=${access_token}"
      mydata="{\"chatid\": \"${chatid}\", \"msgtype\": \"text\", \"text\": {\"content\": \"$1\"}, \"safe\": 0}"
      curl -X POST -H "Content-Type: application/json" -d "${mydata}" "${sendurl}"
      ;;

    2)
      #check_chat()-检查群聊状态失败
      echo "get_token()-获取token失败,导致check_chat()-检查群聊状态失败(返回码:$?),导致无法发送报警给群."
      ;;

    3)
      #create_chat()-创建群聊失败
      echo "create_chat()-创建群聊失败(返回码:$?),导致无法发送报警给群."
      ;;

    *)
      echo "其他错误(返回码:$?),导致无法发送报警给群."
      ;;
  esac

}


update_chat(){
  #手动更新报警群信息

  #添加成员的id列表,格式:"hwang","jianguang.wu","yang.liu"
  addchatuserlist=`echo ${addchatusers}|awk -F"|" '{for(i=1;i<=NF;i++){printf("\042%s",i<NF?$i"\042,":$i"\042\n")}}'`
  #踢出成员的id列表,格式:"hwang","jianguang.wu","yang.liu"
  delchatuserlist=`echo ${delchatusers}|awk -F"|" '{for(i=1;i<=NF;i++){printf("\042%s",i<NF?$i"\042,":$i"\042\n")}}'`

  #调用check_chat函数
  check_chat

  case "$?" in
    0)
      #token有效
      echo "$(date "+%F %T") | 更新报警群信息..."

      mydata="{\"chatid\":\"${chatid}\",\"name\":\"${newchatname}\",\"owner\":\"${newchatowner}\",\"add_user_list\":[${addchatuserlist}],\"del_user_list\":[${delchatuserlist}]}"
      sendurl="https://qyapi.weixin.qq.com/cgi-bin/appchat/update?access_token=${access_token}"
      updatechatinfo=`curl -X POST -H "Content-Type: application/json" -d "${mydata}" "${sendurl}"`
      errcode=`echo ${updatechatinfo}|awk '{match($0,"errcode\042:([^,]+)",a);print a[1]}'`

      if [ "${errcode}" -ne 0 ];then
        echo "${updatechatinfo},更新群信息失败."
      else
        check_chat
        echo "更新群信息完成."
      fi
      ;;

    2)
      #check_chat()-检查群聊状态失败
      echo "get_token()-获取token失败,导致check_chat()-检查群聊状态失败(返回码:$?),导致无法更新报警群信息."
      ;;

    3)
      #create_chat()-创建群聊失败
      echo "create_chat()-创建群聊失败(返回码:$?),导致无法更新报警群信息."
      ;;

    *)
      echo "其他错误(返回码:$?),导致无法更新报警群信息."
      ;;
  esac

}

#token临时文件保存位置,文件内容:"时间戳 errcode码(0为成功) access_token"
tokentmp="/tmp/tokentmp11"
#报警群id
chatid="pingtaimis20180828"


################################### 创建报警群的信息 ###################################

#报警群名字
chatname="明珠监控报警"
#群主的id
chatowner="hwang"
#群成员的id(多人用"|"分隔)
chatusers="hwang|jianguang.wu|yang.liu"


################################### 更新报警群的信息 ###################################

#新的报警群名字
newchatname="明珠监控报警"
#新群主的id
newchatowner="hwang"
#添加成员的id(多人用"|"分隔)
addchatusers="jianguang.wu|yan.li|lighthu"
#踢出成员的id(多人用"|"分隔)
delchatusers="qmliu|mingming.xu|yang.liu"


#the end
