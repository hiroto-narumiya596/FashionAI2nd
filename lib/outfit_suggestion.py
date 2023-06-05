from urllib.request import urlopen

import demjson3
import openai
import owlready2 as or2


class OutfitSuggestion:
    def __init__(self, api_key):
        openai.api_key = api_key
        self.gap = or2.get_ontology("../data/gap.owl").load()

    def receive_response_from_API(self, prompt):
        content = (
            "次のような男性のコーデを考えてください．また，そのコーデの解説をしてください．\n"
            + prompt
            + """

        種類は次から選んでください．

        "Tシャツ",
        "シャツ",
        "ポロシャツ",
        "ニット",
        "パーカー",
        "スウェット",
        "カーディガン",
        "ジャージ",
        "デニムパンツ",
        "カーゴパンツ",
        "チノパンツ",
        "スウェットパンツ",
        "サンダル",
        "スニーカー",
        "スリッポン",
        "ローファー",
        "テーラードジャケット",
        "デニムジャケット",
        "ブルゾン",
        "MA-1",
        "ダウンジャケット",

        色は次から選んでください

        "ホワイト系",
        "ブラック系",
        "グレー系",
        "ベージュ系",
        "ブラウン系",
        "レッド系",
        "ピンク系",
        "パープル系",
        "ブルー系",
        "グリーン系",
        "イエロー系",
        "オレンジ系",
        "マルチカラー",

        デザインは次から選んでください

        "ネックライン": [
            "Vネック",
            "クルーネック",
            "オープンカラー",
            "タートルネック",
            "ヘンリーネック",
        ],
        "袖丈": [
            "半袖",
            "長袖",
            "半端袖",
            "袖なし",
        ],
        "パンツシルエット": [
            "スキニー",
            "スタンダード",
            "ワイド",
        ],
        "パンツ裾": [
            "ストレート",
            "テーパード",
            "フレア",
        ],


        """
        )
        output_type = """
        次のjson形式で答えてください．なしの場合，空欄にしてください．

        {
        "トップス": {
            "種類": 種類,
            "色": 色,
            "デザイン": デザイン,
        }
        "パンツ": {
            "種類": 種類,
            "色": 色,
            "デザイン": デザイン,
        }
        "シューズ": {
            "種類": 種類,
            "色": 色,
            "デザイン": デザイン,
        }
        "アウター": {
            "種類": 種類,
            "色": 色,
            "デザイン": デザイン,
        }
        "解説": "...",
        }
        """
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "assistant", "content": output_type},
                {"role": "system", "content": content},
            ],
            temperature=1,
        )
        return response.choices[0]["message"]["content"].strip()

    def load_json_str(self, res_json_str):
        try:
            json_data = demjson3.decode(res_json_str)
            return json_data
        except demjson3.JSONDecodeError as e:
            print("Invalid JSON format:", e)

    def get_URL_list(self, res_dict):
        cloth_list = [
            "トップス",
            "パンツ",
            "シューズ",
            "アウター",
        ]
        output_dict = {
            "トップス": {
                "ImageURL": "",
                "ItemURL": "",
                "ItemName": "",
            },
            "パンツ": {
                "ImageURL": "",
                "ItemURL": "",
                "ItemName": "",
            },
            "シューズ": {
                "ImageURL": "",
                "ItemURL": "",
                "ItemName": "",
            },
            "アウター": {
                "ImageURL": "",
                "ItemURL": "",
                "ItemName": "",
            },
            "解説": res_dict["解説"],
        }
        for tgt_cloth in cloth_list:
            if (
                (type(res_dict[tgt_cloth]) == dict)
                & (len(res_dict[tgt_cloth]) > 0)
                & isinstance(self.gap[res_dict[tgt_cloth]["種類"]], self.gap.商品)
            ):
                search_list = self._search_on_sparql(res_dict[tgt_cloth])
                if len(search_list) > 0:
                    search_res = search_list[0]
                    output_dict[tgt_cloth]["ItemURL"] = search_res[2].name
                    output_dict[tgt_cloth]["ImageURL"] = search_res[3].name
                    output_dict[tgt_cloth]["ItemName"] = search_res[4].name
        return output_dict

    def _search_on_sparql(self, tgt_dict):
        design_list = []
        if type(tgt_dict["デザイン"]) == dict:
            if len(tgt_dict["デザイン"]) > 0:
                for design_type, design_content in tgt_dict["デザイン"].items():
                    if isinstance(design_content, self.gap.デザイン):
                        design_list.append(
                            f"?Item gap:has_Design gap:{design_content} ."
                        )
        color_type = (
            f"?Color rdf:type gap:{tgt_dict['色']} .\n"
            if isinstance(self.gap[tgt_dict["色"]], self.gap.色)
            else ""
        )

        return list(
            or2.default_world.sparql(
                """
                    SELECT ?Item ?Color ?ItemURL ?ImageURL ?ItemName
                    {   
                    """
                + f"?Item rdf:type gap:{tgt_dict['種類']} .\n"
                + f"{color_type}"
                + "\n".join(design_list)
                + """
                        ?Item gap:has_Color ?Color .
                        ?Item gap:has_ImageURL ?ImageURL .
                        ?Item gap:has_ItemURL ?ItemURL .
                        ?Item gap:has_ItemName ?ItemName .
                    }
                    """
            )
        )
