import wNim
import os
import browsers
import nim_image_similar
import strutils

var app = App()
var frame = Frame(title="Nimage Searcher", size=(400, 360))
var panel = Panel(frame)

# ベース画像選択
let baseImageStaticCntrol = StaticText(panel, label="ベース画像を選択")
let baseImageTextCntrol = TextCtrl(panel, value="", style=wBorderSunken, size=(350, 23))

# 検索ディレクトリ
let searchStaticCntrol = StaticText(panel, label="検索するディレクトリの選択")
let searchImageTextCntrol = TextCtrl(panel, value="", style=wBorderSunken, size=(350, 23))

# 探索開始ボタン
let doSearch = Button(panel, label="検索開始")

# 結果用リストボックス
let resultListbox = ListCtrl(panel, style=wLcSingleSel or wLcReport, size=(350, 120))
resultListbox.appendColumn("ファイル")
resultListbox.appendColumn("スコア")

panel.layout:
    baseImageStaticCntrol:
        top = panel.top + 5
        left = panel.left + 10
    baseImageTextCntrol:
        top = panel.top + 25
        left = panel.left + 10
    searchStaticCntrol:
        top = panel.top + 65
        left = panel.left + 10
    searchImageTextCntrol:
        top = panel.top + 85
        left = panel.left + 10
    doSearch:
        top = panel.top + 120
        left = panel.left + 50
    resultListbox:
        top = panel.top + 160
        left = panel.left + 10


proc sortCmp(item1: int; item2: int; data: int): int =
    let cmp1 = resultListbox.getItemText(item1, 1)
    let cmp2 = resultListbox.getItemText(item2, 1)

    return cmp(parseInt(cmp1), parseInt(cmp2)) * -1 # 降順にするため、-1をかける


doSearch.wEvent_Button do ():
    ##
    ## 検索ボタン押下時
    ##

    # リストを先に一度空にする
    resultListbox.clearAll()
    resultListbox.appendColumn("ファイル")
    resultListbox.appendColumn("スコア")

    # 取得するディレクトリ
    let dir = searchImageTextCntrol.getValue()

    # ベース画像
    let baseImageData = getImageHistgram(baseImageTextCntrol.getValue())
    
    for f in walkDir(dir):
        let (_, _, ext) = f.path.splitFile
        if ext != ".png" and ext != ".jpg":
            continue

        let imageData = getImageHistgram(f.path)
        let hist = calcSimilarity(baseImageData, imageData)

        resultListbox.appendItem([f.path, $hist])
    
    sortItemsByIndex(resultListbox, sortCmp)


resultListbox.wEvent_ListItemActivated do(event: wEvent):
    ##
    ## 検索結果用ListView（ListCtrl）
    ##

    let index = event.getIndex()
    let imagePath = resultListbox.getItemText(index, 0)
    openDefaultBrowser(imagePath)


frame.center()
frame.show()
app.mainLoop()