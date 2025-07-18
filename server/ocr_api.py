from flask import Flask, request, jsonify
from flask_cors import CORS
from PIL import Image
import io
import google.generativeai as genai
import easyocr
import os
import numpy as np
import json
app = Flask(__name__)
CORS(app)  # 允許跨域

# ✅ 設定 API 金鑰
genai.configure(api_key="AIzaSyBgG0Js0PwIYTRae2-mkPpV1MnDwG_ubE8")
reader = easyocr.Reader(['ch_tra', 'en'])

@app.route('/ocr', methods=['POST'])
def ocr():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400
    img = Image.open(request.files['image'].stream)
    # text = pytesseract.image_to_string(img, lang='eng+chi_tra')

    # name = "Wannaeat 好想吃甜點工作室"
    # address = "110台北市信義區永吉路30巷158弄23號"
    

    # ✅ 用 EasyOCR 讀取圖片
    # ocr_result = reader.readtext(r"D:\my_foodmap_app\test.jpg", detail=0)
    # img = Image.open(request.files['image'].stream).convert("RGB")
    ocr_result = reader.readtext(np.array(img), detail=0)
    text_input = "\n".join(ocr_result)

    # ✅ 使用 Gemini 解析
    model = genai.GenerativeModel('gemini-1.5-pro')

    prompt = f"""
    這是一段從圖片中 OCR 擷取出來的文字：

    {text_input}

    請你從中推斷出：
    1. 店家名稱（如果有的話）
    2. 店家地址（如果有的話）

    輸出格式請用 JSON（不要解釋、不加註解）：
    {{"name": "xxx", "address": "xxx"}}
    """

    response = model.generate_content(prompt)
    print("Gemini 回覆：\n", response.text)
    try:
        # 假設 response 是你原始回傳的結果
        text_output = response.candidates[0].content.parts[0].text

        # 移除 markdown 的 ```json 與 ```
        cleaned_text = text_output.strip().strip("```json").strip("```").strip()

        # 轉換成 Python 字典
        result = json.loads(cleaned_text)

        # 取出 name 和 address
        name = result.get("name", "未知")
        address = result.get("address", "未知")

        print("店名：", name)
        print("地址：", address)

    except json.JSONDecodeError:
        name = '未知店名'
        address = '未知地址'
    print(name,address)
    
    
    return jsonify({'name': name,'address': address})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


