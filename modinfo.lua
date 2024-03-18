local modinfoname = {
    "Elements Energy",
    ["zh"] = "五行之力",
    ["zht"] = "五行之力"
}
modinfodesc =
"The power of the Five Elements suddenly appears in the Eternal Continent, said to bestow unexpected effects upon the player when obtained, and has now been unexpectedly discovered by players."
if locale == "zh" then
    modinfodesc = "五行之力突然出现在永恒大陆，据说得到它就给予玩家意想不到的效果，而现在被玩家意外发现。"
end
version = "0.0.1"
name = ChooseTranslationTable(modinfoname)
author = "luvsagiri & 稳健"
priority = 0
api_version = 10
dst_compatible = true
description = "Version:" .. version .. "\n " .. modinfodesc

dont_starve_compatible = false
reign_of_giants_compatible = false

all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = { "五行之力", "稳健" }
