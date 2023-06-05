from pydantic import BaseModel

class ChatHistory(BaseModel):
    id: str
    chatid: str
    chattimestamp: str
    chatspeaker: str
    chatcontent: str


class UserData(BaseModel):
    userid: str
    username: str
    chathisrories: list[ChatHistory] = []


class ItemData(BaseModel):
    id: str
    name: str
    description: str
    url: str
    imageurl: str


class Sent2ClientMessage(BaseModel):
    AIchathistory: ChatHistory
    itemdatas: list[ItemData] = []


class ResponseDataSet(BaseModel):
    id: str
    AIChatData: ChatHistory
    TopsWear: ItemData
    BottomsWear: ItemData
    ShoesWear: ItemData
    OuterWear: ItemData