# 用 R 排座位
## 教室建置參數
   * S: Seat 座位
   * A: Aisle 走道
   * P: Pass 跳過一格
   * C: Change row 換下一列
   
## 參數設置(Setting)
   * class: 安排座位表的教室 (教室座位的分布由 NTU.csv 中的資料匯入)
   * path: 由 R 生成的.ctx (或 .tex) 檔存放位置
   * filename: 檔名
   * data: 學生修課名單 (第一行為系所名稱，第二行為姓名)
   
## 函數介紹
   > seat(list, class, method = 1, aisleSpace = "1cm", seatSpace = TRUE): 生成座位表核心的表格部分的 tex 程式碼
   
   * list: 修課學生名單 (同上階段)
   
   * class: 安排座位表的教室 (同上階段)
   
   * method: 安排座位方式, 其中 
      * 1: 隨機亂排
      * 2: 梅花座(同系不相鄰)(待寫入)
   
   * aisleSpace: 走道寬度 (default: 1cm)
   
   * seatSpace: 座位間是否留有空隙 (default: 是)

   > code(list, class, method, date = NULL, aisleSpace = "1cm", seatSpace = TRUE): 生成整份座位表 tex 程式碼
   
   * date: 日期 (default: NULL)

## 操作流程
   * 設定基本參數 (匯入修課名單，設定路徑，檔名並選擇教室)
   * 使用 code 函數生成程式碼，並用 write 寫成 .ctx檔
   * 重新編碼 (Big5 -> Utf8) 並刪去多於檔案
