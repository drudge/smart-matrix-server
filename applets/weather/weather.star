load("render.star", "render")
load("encoding/base64.star", "base64")
load("encoding/json.star", "json")
load("cache.star", "cache")
load("http.star", "http")
load("schema.star", "schema")
load("time.star", "time")
load("math.star", "math")

icons = {
    "thunderstorms": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACl1BMVEUAAAD///////+/v7/////////s7Ozv7+/v7+/w8PDv7+/v7+/v7+/t7e3////////v7+/v7+/v7+/w8PDu7u7v7+/v7+/v7+/v7+/v7+/u7u7o6Ojv7+/w8PDv7+/v7+/v7+/v7+/v7+/x8fHw8PDv7++AgIDw8PDw8PDx8fHt7e3q6urw8PDv7+/u7u7v7+/r6+vv7+/w8PDu7u7w8PDh4eHh4eHs7Ozv7+/w8PDw8PDw8PDx8fHr6+vt7e3x8fGqqqrv7+/w8PDv7+/t7e3w8PDv7+/z8/PMzMzw8PDv8PHv7+/f3//w7e35yqT9unb4z6/v8vPs6+vo6Ojp6enq6urs7Ozu7u7v7++qqv/2177/r0f/qin/qBH/r0r+sFL5y6bp8vjs6+rs7u7u7u7v7+/y8vL/gED/rkv/r0n/sEr/sEj/sEj/sEn/sUv/r0n/sEb/27b/r0n/rkj/mTP/qlX/v0D//4D/n0D/r0n/r0n/tkn//wD/AAD/r0n/rUf/r0n/rkn/r0n/qkT/gID/qkT/sUr/gAD////9/f35+fn4+Pj6+vr+/v7w8PD19fX8/Pzv7+/y8vLu7u739/fv7+7v7/Dv8PDw7Onv7u7h4eHm5ubs7Oz7+/vv8PHw6+j4zqvg4ODj4+Pn5+fp6env7u3t9Pf8voHu8vXr6+vf39/k5OTo6Ojq6urt7e3u8fPx5+D/qiX7w5Hu8fT6w5D/pgD6xJLi4uLl5eXu8/b12sb/qij/rDf7wo7x8fH+tGL/rkb/qy/7wo/u8fL6////qRn/sVL/rkT+s1z7v4T7v4b/ulP/r0n/r0r/rDT/t03/8+r4+/339/b/tEv/sTn/yVn/tkz/uU3/sEn/skr/sUr/uk7/vk8UWNQgAAAAiHRSTlMAAgQEAQMbbazL08WeVwcFjfjkYx7Z+vv8/akW6Pj++bLAfVr5HwLIhSTvur69uY4zUPuaZ/v8/Lxl94lKGh1ZA7v6b0em9RYFzfuBCLr8/Pv7+/v7+/v7sQOO+/3B+f3GrbKxsa0oBIj80UdRTVLpNwfdkQUDBAII3OEHAQHZS+2xzh4CDz4CK4SdUwAAAAFiS0dEAf8CLd4AAAAJcEhZcwAAHCAAABwgAc0Pm54AAAAHdElNRQfmDBYEHTkbK/u1AAAAAW9yTlQBz6J3mgAAAjdJREFUOMtjYIAARiZmFiDBxMKAFbAwwZlM2ORZGRjY2Dk4ubh5ePkYGDENYWLgFxDs6Ozq7unoFRIGWocmz8wgItrRJyYuISkhLt7fIYWugpFBWmaCrNxECJCU71BgQLWEhUGxQ3YiAgh2KKG4lIlBuUMFSX6iXJ+4KgMTIysTK0SBGoN6jwSygoliHRpQz0Gs0pScKIeiQG6SlraOrp6+AdS1hhOMJqICub7J3RMmdEwxhqgw6RCHiE+dBldhamYuISbRYQHyAoMlVMHU6TNmwlTMmjV7zsSJVh3WIP/YzIW4cd78BdOh8pMXLlq8ZDLQKkFboBV2sn0gRy5dtmD5CogRfStXrV6zdt3EieK99gwMDgyOE4B2zFy/YeOmzVAFi2fNXrNy8sSJTh3OoJh06QQr2LJ123qIgsnbd4ANmCjeyQuOa9cOwaU7d+3es3f9zKlgA1YvXjIHaIDcPjd3cFx4eHZ4zdh/4OChFdMPT5zat3LHmiUgC+SsOrzBseLA4ON7xO/oseMnTp7yDwgMCg4JDQsXFxeT64hggERsJAND1OnoM2ePn4s5f+Hipa6euRM6Ozs7JgmAYgoa47GX486cORt/JSExKTklJQIIUr3T4CknnSHj6rXrN85kXstCTYqIhJOdk5uXfzPzcgFDISsUMHugJ82iW7eLGUqwZwuG0rLyisrrVdUMNTgUMNQylNbdqWcoY8CtgKGhEY88UEF1UzNDCz4FrW0MpQz4QQ0B+XbswgDfH/kLl59ZOwAAAKhlWElmTU0AKgAAAAgABQESAAMAAAABAAEAAAEaAAUAAAABAAAASgEbAAUAAAABAAAAUgExAAIAAAAkAAAAWodpAAQAAAABAAAAfgAAAAAAAABIAAAAAQAAAEgAAAABQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKE1hY2ludG9zaCkAAAOgAQADAAAAAQABAACgAgAEAAAAAQAAACCgAwAEAAAAAQAAACAAAAAA09ORzgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMi0xMi0yMlQwNDoyOTo0NyswMDowMEWu74gAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjItMTItMjJUMDQ6Mjk6NDcrMDA6MDA081c0AAAAEXRFWHRleGlmOkNvbG9yU3BhY2UAMQ+bAkkAAAATdEVYdGV4aWY6RXhpZk9mZnNldAAxMjZGGY88AAAAF3RFWHRleGlmOlBpeGVsWERpbWVuc2lvbgAzMoisZxcAAAAXdEVYdGV4aWY6UGl4ZWxZRGltZW5zaW9uADMyVTq+kgAAADF0RVh0ZXhpZjpTb2Z0d2FyZQBBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoTWFjaW50b3NoKcYLodkAAAAASUVORK5CYII="),
    "breezy": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAQAAADZc7J/AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfmDBYEHTkbK/u1AAADcElEQVRIx8XVSWyVVRQH8N/XPiB0oLS2tNAGCkhbmSIIFaqIsdGaVJBY0wDBlUZZm5joyoUL3bg00UQ2BSIYBwwQg6AGkUE0DQ1VA6G2yGNoK7xCKZT2PZ6L9/EGhjVn8937/c9wz/mfew8PW4I7i9g9UGnWOvZALLgLniAiYSxbMY3mmSgwJpHaLtODIJYxXanVfMVGnfGDnw1nhazRapXpAoOO2+NU+gQxIoot8IZ1StIGow763FFDmKbVmxZlueuzzVf6jIgHMTZ5xywlSBowpECliRhz1iV5qs2UhxH9EipMBYOiPrY9gtkWY9xx2x10RYHHtXtemXnmhTEv2OVrpyXUaNFugQoV5hBBv07d9jiQrtc/dltqjRUqJV30q126JcFFv9uixQsa9KdqUGCCYbfvQ/JkhZJGjN4Hy1Ns3I0gi8JSSzUoccMZnS7cpd5giWqBAV26M0RHwm+JNTZbajIYc9pWO/wbGi+02TpVYdtddsBnjqbOFcRo0maFZSaCuPxQ8ZTDeuVpsNoMcFtSPrjqmC7fORLBc94GQ36233lTNWlRq159OoWkbnt1iqv3okYlWrS4lnIQd8t5P9nqWJhbh3letVadQlz3p512pavyiWdt0KRKPJXCXNX6RO/hYapalZIu6c1p61TtaswS1ZPNQkStWkVGndNzD3VlHlUpz3/O6M82Skm+Rm9pVm6ChCHHbbHfSIhOs94m9Qowqs83OvRkLlOdVVZpVZ4T8aZD9usVeMxaT2ReDtBjr05HnQ5ivOtDkNDtkKhSjZYrCv8JiRt02Anj6j1tTujmPR9FwjSGdeqwN8yu0EqvaVYlH3FRu3XoMo7AbK9oN1+h/FQKT1rsLyddyzlkvrkWq5Z0Tpfe8CplSrpIvS6/BTmvXcQUk4y7lun1LClUJHAjN1AkvSrxkpfVKXDLWft8K5qlt8R6TSoEruj0pSPGMywUmW651z2T5Y6TtjpgADO12Wh6FnbVbjv8bcD1IMZm7ysXwU09BhWbowxcERMoNwVc0CuuxiwR3HLZBz6NoEIVYvbp8Idhk9Rp02austBRQrdt9oi67RGrbfKUIjNUpFLYoN0J+3TmlK5Ws5UhC7/40aWccjZqttBOXwSxVKMk7mCluVMo9TqnsZwhFJGUyKLxexuzLB88zO43Bh+m/A85hRxbJUHeCgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMi0xMi0yMlQwNDoyOTo0OCswMDowMLPmn2EAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjItMTItMjJUMDQ6Mjk6NDgrMDA6MDDCuyfdAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAABJRU5ErkJggg=="),
    "clear": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAz1BMVEUAAAD81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX///9lDb4tAAAAQ3RSTlMAAAMaOlVkEaTa8/0GVMP6F5b2ILYYt5dW91cTxln7BKkd3T/1W/5qa11B3wWtXvwWy/kJoMAnHqJhzmKy4vgjRmNynOrq1QAAAAFiS0dERPm0mMEAAAAHdElNRQfmDBYEHTRlmocIAAABI0lEQVQ4y33TZ5OCMBAGYFbFBoqC6HlW7BULYu/5///JjR6caJb3U5J9ZjKT7EqSFwhE+gw/jERjcjwux6KRL8IPEnIylVYYU9KppJwIEtyomazG/GjZjPomcJnL6ywQPZ/zBS6MAvtKwfAEgFlkghTNF8D7S0yYkvoUAD9lMSj/cgBQqTIi1QoKgFqdAvUaB40mI9NsILBaNGhZCNodGnTaCLo9GvS6CPosJH0EgzAwQDAMu2KIYKTTQB8hMMY0GBsIJlMaTCf8qe0ZVZ/Zz7+YLyiwmL++016K60v7rx+clRisHK+lLFdUdy2/J2EtEO76va03Wy1Y1rab4GA4u73yX1b2O+dztMA8HE9nXj2fjgdTOJ3q5Xq732/Xi0rOt2D8H3b4q5HrfaQDAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTEyLTIyVDA0OjI5OjM4KzAwOjAwuSOWeAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0xMi0yMlQwNDoyOTozOCswMDowMMh+LsQAAAAZdEVYdFNvZnR3YXJlAEFkb2JlIEltYWdlUmVhZHlxyWU8AAAAAElFTkSuQmCC"),
    "clear-night": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAABWVBMVEUAAADK3fwuMjnK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fz////DCuWnAAAAcXRSTlMAAAAPLUsmBDiIye3gMS6fkmLwOwd+9sINAnn6ilTy/l0f0kGC8TUe2jZe/fdFAZ5mDpvf2Bwo6Wop0R0Qy1Gi2zlj1yLdeheJzXMqJOa2gFMzA/uaCYP81grVbue6L6vz3hMIQ5bTwHYlFldrcE0rDGz/Pc4AAAABYktHRHI2Dg1YAAAAB3RJTUUH5gwWBB00ZZqHCAAAAUBJREFUOMt102dfglAUBnBOk5SWEpUYaMvKJCuLyva0vffee5zv/yZAGReOzzt4/vwuF87lOCdghyNjVZVV1TVlgNHW8nWhsFBPggqjb2gMI2ITvYTxeLNg1BiJlunFFsnssbWNAgDtMdnqMU730KEUezVBg2RnsUepiwbdpR57esk+1eeAfhIMpG0wmCGWAG0InWQpMBxywQgFUqMuyI0FBYzrLkhPBP8FTHoATuWDICl4AMY1v4DpGS+IzPoXAW3OC3B+wScAFlVGLGXYwQRYXmEA6qtrzPQCFFiA6vrGpugagK0c+rO9s7u3nz8oAUhIGMyhcnQM9sienBLizDkCAOcFOdBfRMEFIF5e+frrG89mzfflb+889X3sgf1extXj0/OLYg6XrL++vQdOsbXrD/7z6zv78/tHHnJgYt/9B5W9nEvJ+WlOAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTEyLTIyVDA0OjI5OjM4KzAwOjAwuSOWeAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0xMi0yMlQwNDoyOTozOCswMDowMMh+LsQAAAAZdEVYdFNvZnR3YXJlAEFkb2JlIEltYWdlUmVhZHlxyWU8AAAAAElFTkSuQmCC"),
    "mostlyclear": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAChVBMVEUAAAD81jX81jT43nTv7/Dv7+/u6tfrxzHpxjHqxzH/5C7ryDH71TXtyjLtyTLuyjLvyzLwzDPxzTPyzjPzzzPnxTH81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81jX81TD81zr81jX81jX71z/05qn81jXv7/Dv7/H81jXv7+/v7+/81jXv7+/v7+/v7+/81jX81jXv7+/v7+/v7+/v7+/v7+/v7+/v7+781jXv7+/v7+/v7/Du7ejq14jq0Wn81jXnswDpxSnqxi3rxy781jX81jX81jXryDHryDHsyTLtyTLuyjLxzTPyzjP50zT81jXtyTLtyTLuyjLvyzLvyzLwzDPxzTPxzTPyzjPvzDL81jX81jT81jP710D62k/72Ur81jj34Hzy6cXw7Nzx7Nf05qz62lfw7ujv7/Lv7/Dv7/Hx6s742FP81TLv7+/u4Kb21k7s6+jq5tj05aL72Ebs7Ozk5ebs7e7y4Zv61DXq6urm5ubv8PLu58jvzTz50zTu7u7o6Oju7u/v8PPu4avryTXvyzLu7enr6ufu7erv7unu5b/sz1LsyTDtyTLwyzL40zTr0mjs02ns0mHsy0DsyTHuyjLwzDLryC/vyzPxzTPwzDP///9rslbGAAAAlHRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAhg3UmA4GQ9RoNfx/PKiUxAFUL/5wRWR9PWTFh6ytB+ztReWBvZVEcLFEvr7WAOlqAQb2t0dPD/9/ltnamhrWV0+QR3c3yAHua4n4V9Y/cxdM+2hCQSQEYnk+fsoAiZGTqL5owlfzf3OYQoXYrHi+PjjsmMGI0ZjcnJjRyMHxMp3eQAAAAFiS0dE1ue1aqkAAAAHdElNRQfmDBYEHTUSnbeeAAABz0lEQVQ4y2NggAFGFMCADkCCYuISklJSktIyYhhKQAKycvIKikpTpigpK6ioqqEqAXLUNTS1psCBlrakOpIKIFNHV28KCtA3MISrADKMjKdgABNTmApGRkOzKViAuQVEAdB+gylYgaUVWAUjo6Q+dgXWNiAFjIy2dlNwAHsHoApGRhtHXAqcnEEKXFyn4ARu7kAFHp64FXh5AxX46OFWoO8LVODsh1uBfwBQQeAUPCAIqCAYn4IQoIJQ/ylTp03FYUUYUEG4/rTpM2bOmoY1LCMYGZgio2bPmTtv/gJshkTHMDIwx8YtXLR4yaKly5ZjKolXZ2RgSUhcAQKLVq6aOQtNiVISMKhZk1PAChavXjNv7TpUFamGIAVpKyBg/YaNizZtRpbXAhnAwJqeAVGwZev6bdt37ERSkJkFVpCdA5bftXvLnr379h9AqNA2AicoVtbcvPyCwoOHDh0+cvTY8RMnT8HkixihCliLS0rLyitOnzl77vyJCxcuglU4VhrBEjUrCLBVVdfUXgLJH7h85dQUv7r6BpSsxc7BwdHY1NzSeuHA1att7R2d4hi5k5OLm7uru6e3r3/CxEmTebDlb14+Pj5+fgFBQSFhEVGENAArwpOPDZdyHAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMi0xMi0yMlQwNDoyOTozOSswMDowMB9UncwAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjItMTItMjJUMDQ6Mjk6MzkrMDA6MDBuCSVwAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAABJRU5ErkJggg=="),
    "mostlyclear-night": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAACT1BMVEUAAADK3fw2O0Th6PTm6vLv7+/s7e////u7zem9zuvC1/TA0u++0O2/0e7A0/DB0/HC1PLO4f/H2fjK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzG2/3K3fzg6PTK3fzv7+/v7+/K3fzK3fzv7+/v7+/K3fzK3fzv7+/v7+/K3fzK3fzK3fzK3fzK3fzK3fzv7+/v7+/K3fzK3fzK3fzK3fzv7+/v7+/K3fzv7+/v7+/v7+/v7+/v7+/t7e7K3fzv7+/v7+/w8O/W3uvI1erK3fy4y+m7zOq8zevK3fzK3fzK3fy9zuu9zuu9z+y+0O2+0O2/0e7B0/HB0/HG2PfK3fzK3fy+0O2/0e6/0e7A0u/A0/DA0/DB0/HC1PLB0/DK3fzM3vvQ4PrV4vjl6vLs7fDs7vDn6/LX4/fw7+/v7+/t7vDV4fXJ3Pvm6e7N2/Lu7u7m5+jr7O/m6/LS4fnl5eXq6urm6vDK2/ft7e3r6+vs7e/J1u3F2Pbq6enp6enu7e3w8O/C0uy+0O3q6+zp6uvr7O3t7u/M2Oy9z+y/0e7I1erJ1uvJ1uzA0u+8zuvA0/DK3Pv///+5R/3jAAAAknRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAETBPJwY8jczv4DKjkAVn4vA6CIP3wQwDfvuJWfT+XCLV9kCGNSHc8TZiRQKiZhCc2Bwr6mvr0h6LzVICO3tGDLp7GCfoz3Up6ee3glQ0BA7C/POdClTx1wJZzPL2/tYUNz9357s5rPPeehQIRJfT8v366cB3JRY4V2twZk0rDOE0CAMAAAABYktHRMQUDBvhAAAAB3RJTUUH5gwWBB01Ep23ngAAAbpJREFUOMtjYIADRhhgwArAUsIiomI4FABlxSUkpaRlRLAqAOmWlZOeNGmSPFYrmBgZFRSVgNKTlFVwGKCqpg6Sn6ShiU0BI6OWtg5YfpIudnlGPX2IvIEhdgVGxhD5SSam2BWYQeUnKZtjlbewhCmwssaqwMYApkDdFosVjHb2k+DAAZsCRymEAidsCiyUEAqcXTBVMLq6IRQYuGPGBaOrB0LBJE8vTAXIVkya5G2HroJR2GfS5ClTJsOCwhfdEkY/uanTps+YOQuqwtIfTQUzS8D02XPmzJ47bz7UJ4GoCZM1KHgOCMxesBBqj1tIKHLqZQ0LByuYs2jxkqXLIIZERLqqwtWwRkVDFSxfMXvlKqhLYmLj4hO8EsEKkpIhClYvXzNn7br1cA+npKalgxWwZmSCFWzYuGnzgi1bESqyZCFWsGbn5OblF2zbvmPngl27t+6BqSiUgLqTlZW1qLiktGzvvv1bdm/duucAREW5CMIfQMDGXlFZdRAsf+DQ+sOTqmtqUcOLg4Ojrr6hsakZKN/S2tbegZGLOYGAq7Oru6e3r3/CRKyZnJuHh4eXl5uPj19AQFAIJgoAwKjiCq+o2cIAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjItMTItMjJUMDQ6Mjk6MzkrMDA6MDAfVJ3MAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIyLTEyLTIyVDA0OjI5OjM5KzAwOjAwbgklcAAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAAASUVORK5CYII="),
    "partlycloudy": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH5gwWBB01Ep23ngAABIFJREFUWMOtl12IVGUYx3/P+87nzjrtVgplSSla+UXm2pWYn5EXLUIh2EVehjcVgQR1WRdCIFRQQdJlUSoRXSxkdxFFuqHGemHImlZafoyt4+zsnPO+TxdnzsyZcXZ3ZvSBw3AO57z/3/M57yv0aOGZDfO+k1p5vOv15A5FDWABD7h+YOYE6CCcAVYAI8Bq4CFgAAiBq8BZYBw4BVzvBmRWgDbxHLAD2AtsBBbN8W0FmAAOA18Af84F0nGRNvFVwNvALiBPb3YaOFCHCTtBmHnEdwJHgD19iAOsBQ4B7wCD8cOF96Y6R6BNfBT4BHigD+F2U+Aj4E3gVjIKZpYPNgDv3yXx2NF9wBux07GzDYCE98PAu8Ajd0k8NlMHeLb9YbvtAbZHUXP1y9NsdX8nEEPAfqAYO90SDuB+0DHQETX34NLL8allqB0GdRj3DyY4iw0nQWeYPYNzWg14CTgK0CzHyMuNSH5tkNtEMDCKSy8DydGsVY/4KWztJJlbR7G1CbocpknLAC8C3wBhCsBOHaf0hLLg0nNbaoO7M7WB5+vCt4dcTZEwtxmXWUV26jPS08eI0tWTPQ08CFywpVIJVxghXfl6MBjcvT/Ib16CpOfJtYIUCDNrIPgLG55HpKdI5IAx4HwKIMhvhfy2HSDrGgLzmgdTZGbwZcLKWQbsZUS6rok8sAQaVWQGQF4BCr1F0iPZR5nJPEO5EqLaU7cMQbMIHycaPn2YYId2EpghprMGa0F8CTtzGhv8TvQXMHt6YoDHiAZQH+YhvZhgcBSTzWKtBVWk8B/p6e/JlD9H/I1OEDcSKeA++uinRgwEXFhjplrBuwDwqClSK7xAtbgPlQJtdTUNXEgCVPsVB1DVxm8YhvV7BTxhfgvTmW143wJwCTiXBJi8E4gYIG5F7xMFKClcfhPVIJeE+AX4OwkwERP1Y85F20FjDCLSOhNUIbUQLwVmah7ntUa0xwiTAJeBL/v1PgxDrLUN8duGklYRDVCFWqA/OKfHQhdFIzk5DgE/9goQhtFOy1qLMaYRhWYKBKn+huhNELmhynuB06lsxpBaebwF4BLwGtE+ruvQO+ew1jYuY5JLWqj9gUx9CzgvcNAK36mHm7fqaRsebmn/caL9wBGiViHqTtN2Cc4pzivWprGpNMamMMa2vhdMYq59gASTKpiPgYNeo34sPjXeWB2AUqmUBBkAtgKjGl7bjq88msyW9x5FESSR93g5BV9Gpk8i5TEkuFARzIdEu6wywNLtp7hyPWwF6ABBeWyY7OpXV2vt/Fui1V3g8xLnVaKP2+8REK0ivgyip8EcMHBY46o3QuHJE80S6ZTbUqmEhtcxhaXUzr2Ov/JpTnLLdoiYvSKyUUQWSVM7IS6IUBGYQKRxMIlF0mkht+ZEi9ac4/ffn9ahiQFmDRlEVgAjAmtEWCwSHc1E5KpIdDQTaR7NVn11kTO7H2ZBPeft1tX8v/rzusYkb7SYgrUYESyI9x5nTCIiEs2g4izCPQEk7eav6wlCpbXVo5tzF5XlS4Ti+vGu1/sfBeSxBrVMYXcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjItMTItMjJUMDQ6Mjk6NDArMDA6MDCACdEGAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIyLTEyLTIyVDA0OjI5OjQwKzAwOjAw8VRpugAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAAASUVORK5CYII="),
    "partlycloudy-night": base64.decode("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"),
    "mostlycloudy": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAB3VBMVEUAAAD81jXv7+/62Uv81jTw7Nz24o7u7u7t7e381jX81jX81jX81jX81jX81jXv7+/v7+/v7+/v7+/v7+/v7+/v7+//pQD81jX81jX81jX81jX81jX81jX81jX81jXv7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7/L62lT81jP81jX81jXv7+/v7+/v7+/v7/Dy6cP81jX81jXv7+/v7+/81jXv7+/81jXv7+/v7+/81jXv7+/81jXv7+/v7+/62U771z7v7+/v7+/w7d7v7uvv7/Dv7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/u7u7t7e3r6+vs7Ozv7+/v7+/v7+/v7+/v7+/u7u7t7e3v7+/v7+/81jXv7+/53GD81jTv7/Hx7Nn43Wzx7Nf521v81jPv7/Lz57f71z3v7ur43m781TD81jLy57X43GX53Wb53GHt7Ovo5+Lv7unw7uft7e3i4uLn5+ju7u/v7/Du7u7j4+Pp6enh4eHn5+fr6+vs7Ozk5OTo6Ojq6url5eXm5ub///+3m6vEAAAAdHRSTlMAAAAAAAAAAAAMMkpDIAESM01URykKAUu77vr33owcJ4PN7/r8+Oi7ZG/vviEFY9z8+p8Gfvc3aGot4XyPZxrY7TNC9vaeLmDdT2rkPF60Cz708ToX04Ul2TlZ8rMCbPDiAVDbuuPz9vb29pgsCSNBQUE7Hw3PYUMAAAABYktHRJ6fsqMLAAAAB3RJTUUH5gwWBB01Ep23ngAAAYtJREFUOMvNk1dXwjAARiWiuPfCjXvvvaXuLbgV3AJOHBHcCyeKopVV/a8mLRRofdf70px+N19y0tTH5x8iYPF8C1h8hYLAoOCQ0DAvAyfhEZFR0TGxfnHxCeLEpOSUVLeB47R0SUZmVnZObl5+wQFNYZGHUFxSCp2UlR/qGKOiUsDmVdWQRX90zBjiGqYC9ddmQw/0J6dntFHnEuoboBfnF5d0R6NLaIIcrq5vDAaDrlkIaKGllSvob+/u7x/a2v0BNoCU4Arw8clofO7o7ALYAN28HL6YXt/MZtjTiw3QxxfeTR/kO3r2D2Bh8JeGzw+LFQ+GhpEwMsoTbJ92B4UrZHIkjI3zBNL05bBiAQ4iAUzwtvBlt1A2yAqTUxzBav8mmQLZNBbAzKz3Fi0W0vpCD+di8UEAhXLecwHSgXK6YEHOnCVYXJK451MkZWPmL0fSR0l/8RblyupaNUGo1BrNulpFEMRaz8amM2cu3da2XLqj3UVotTuIvX0Fm7uvtSgAIRKxd/yv/0EnP1IX5UfwmaswAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTEyLTIyVDA0OjI5OjQwKzAwOjAwgAnRBgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0xMi0yMlQwNDoyOTo0MCswMDowMPFUaboAAAAZdEVYdFNvZnR3YXJlAEFkb2JlIEltYWdlUmVhZHlxyWU8AAAAAElFTkSuQmCC"),
    "mostlycloudy-night": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAB0VBMVEUAAADK3fzv7+/M3vvc5vYEBARqdITJ3fzm6/Lu7u7t7e3K3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzK3fzv7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/J3fzK3fzK3fzv7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/u7u/P3/rK3fzv7+/v7+/v7+/n6/LK3fzv7+/v7+/K3fzK3fzv7+/K3fzK3fzv7+/v7+/K3fzK3fzK3fzv7+/v7+/J3fzJ3PzJ3PzJ3fzv7+/v7+/S4fnU4vjv7+/v7+/u7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/u7u7t7e3r6+vs7Ozv7+/v7+/v7+/v7+/v7+/v7+/u7u7t7e3v7+/K3fzv7+/U4vnw7+/s7fDW4/jr7fDS4fnk6vPM3vvu7+/J3PzJ3fzk6fLV4vfV4vjs7Ozn5+fu7u7t7e3i4uLj4+Pp6enh4eHr6+vk5OTo6Ojq6urm5ubl5eX///+jbf3nAAAAfHRSTlMAAAAAAAAAAAAAAAspDgNRvcAadfOSARtBXGRVNBBL8mUzlNn2/vzvxna9YQlz5v6IjfvTHHaOBTbo+IkbApnUkVsRH968FEj47KY3ZeRYbmC4DD708joW0YFZItXtUqkHYuswRsPQPxNfrdrs8fDw8PDw0ocFGi41NDQVZwKMkgAAAAFiS0dEmpjfZxIAAAAHdElNRQfmDBYEHTaLlOYkAAABiUlEQVQ4y8WTVVcDMRBG20GLuxYpUNzd3d3dXcriUkgoxa3UhX9LsoWlu8vpI3xPOefeTLKzE4nkHyJl45b7BwRK3fCg4JDQMKEAXDyCwiNQpPAIAqKiY2Lj4uUJnolJCCXzBbpRkZKapsTpGZlZ2QihHJ7gBZCbl4+/U3CFUCHvMwgvKuY41lxrUUmpVOrtckBZOnbNzS0qr/jpBUBlFY9jzd19dU0tZ0BdPRbkQfv41NDY1OwDrNDSKhTw84tW+9rW7gvUgI5OkfCme8cPXd09QA3oFXGsNxAD475+asCAWHg3GE3UqIqhwuAvFcxGnYUuhoaJMDIqEixmq81OS4yNE2FiUiTYDA6ThQrKWCLAlOgKH1adXU9XymkqzMwKBLtV5yyA5xRUgPkM/hUdhLMF8MIibQRELS27cpPtm6euOHsJsLrG/VC93WR5c/L1DbaVrLG5tb2j2mWYvf2Dw8P9PYZhVEfHM1/cOXQnp2fncvUFiVotJzm7BI7/jLXMj0Qm42b8b57qJwbH5I7Ayd+cAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTEyLTIyVDA0OjI5OjQxKzAwOjAwJn7asgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0xMi0yMlQwNDoyOTo0MSswMDowMFcjYg4AAAAZdEVYdFNvZnR3YXJlAEFkb2JlIEltYWdlUmVhZHlxyWU8AAAAAElFTkSuQmCC"),
    "drizzle": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAABlVBMVEUAAAACAgLv7+/s7OwBAQHt7e3u7u4d///v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/t7e3t7e3v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/t7e3s7Ozu7u7v7+/v7+8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d///v7+/r6+vm5ubu7u7s7Ozh4eHn5+fk5OTp6eno6Ojl5eXj4+Pq6urt7e0d///////0WWVeAAAAd3RSTlMAAAAAAAAAABE1VGBWNxIadsnw/P3xzHseRMrPS07l6lcw3eM4B6exCjz1RYLCioyLRg0F9rYMxt5Cx84dsnODsz7DCwiprAQy3/5lUui7E0fNLXry5pYiOltpaGdnZ2cqAxocG7q/HwGOlgMPztQUk5oFE2BiFUmknf4AAAABYktHRIaM3jtdAAAAB3RJTUUH5gwWBB03/JPWsgAAAXBJREFUOMulkmdbwjAUheutiAsVBHGLE/cAt7j3RNyD4V64V1pKKQr93zYFpbQ8+eL5lNzzPie5yaUorCxQiNIKl3Pz8gsKDUUZCalWXGI0lSKzpcxariWkSkUl+lVVtZqQ9jW1KKU6m4oAqG9ASjU2pQEAzS0oXfZWZTsAbSYV0N5BKzoG6ERqdXX39Fr7HAkCnHYNwLAhhPoHDDIBg0MagAvzEoGGRwCyKXCMZgAiAibGXFIEOMe1R4QjUQ4vJjAAkxogGmYFDkdMOTEwbVH5oa9vPhbHq5lZDMzNq0+IsAKDA9DCIm4DlpbTA3g2ysgBK6tynwBr60pf4AUmLgdsuBNPBbDpSfkxIZb0jVvJ/5AI17ZnZwUX4wzDybZ5d29f8WEA7oPDo2Ovz+/3BQJeSbaTU8Vc/A2sjqZpXQ5pfv8rvSyif3ZOIvT6i8uraxJwcyuKd0ECcP8gio9PBCD4LIovr6Q7vL1/fBIvqe3zB4TswZ8wDtaCAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTEyLTIyVDA0OjI5OjQzKzAwOjAwseHLmwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0xMi0yMlQwNDoyOTo0MyswMDowMMC8cycAAAAZdEVYdFNvZnR3YXJlAEFkb2JlIEltYWdlUmVhZHlxyWU8AAAAAElFTkSuQmCC"),
    "cloudy": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAQAAADZc7J/AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfmDBYEHTaLlOYkAAABuklEQVRIx+2UPUgcQRTHf7N7wcNGtjAoBE4O/KhtTBHSi3VsBU+wEAR7QcXaj8JGkkawSmMKQbARRCWIIdjJaXEgwoHiiiLueXczFrN7u3t37myfvK1m5/1/b957Mw/+m4gv3RYHJy1AcB/+zWBRQ6aBiKbIn/jCCDmyPHHJMb+DLScJ0PApMMkAdmPX44wNdnh9HyEa8n5WGWuuCeCxySIPJkAfW3x9N9HvzPHcHmG5AFmWEuQwyXSsUlEAAKOMk2Q2swxphP7yMUAHE2RJthzfyiCCGv3B9c8jXBjkgF4DAHktjzIKqHDBPuco3Rnhwhg7fDACeCEbdLjMD1Z4CFLoNstBIPGo60UP86zTFRYxpUmq4f2eYCYA3FI1ixUKAdR18gAF8hpwxV2a6LoJIgTkGNaAEqdmQA2B5SN8s/moARW28Ezx69jNAMl9UMQ9fqaLb0Vf2w1/wXIAPBY4TJLr+HYcsE0xbGOJKXbD+kSt3l7+izWUaaCgkEg/80j2j2yzTBnaj7TP5OhEoZTQ1yYmrlBklxN9d5zomSKvPYONkigsP4aAID9JLXBzSBzrypeIVjfM4/5fsjf4D4DjycRRPAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMi0xMi0yMlQwNDoyOTo0MSswMDowMCZ+2rIAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjItMTItMjJUMDQ6Mjk6NDErMDA6MDBXI2IOAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAABJRU5ErkJggg=="),
    "rain": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAB+1BMVEUAAADv7+8sLCzs7OwGBgaDg4P27u668/OP9vbG8vLr7u7Dw8O0tLT///8A//8W//8D///17+8d//8p/v6n9PTv7u7u7u7t7e357u5E/Pwj///v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/t7e3v7+/v7+/v7+/v7+/v7+/o6Ojt7e3v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/u7u7s7Ozt7e3v7+/v7+8d//8d//8W//8d//8c//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d//8d///v7+/u7u7l5eXt7e3i4uLo6Ojk5OTj4+Pn5+fr6+vq6urm5ubp6ens7Owd///////Yv+nCAAAAmXRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEJUtgXEEaAT+l5Pr+9teKCHntToL76U9T9BHDSPfcTT0+NRZ/9/X18dF2nasXoZNY/GsddXRRD8cVG6rmR3LVzFWGnqCfn5+flBkXKgIxDRCq2TVU54cFZv6tBxjQ8kGEyg8m6FkruFt51qIMEgECFXhjYvruRQi7mZL8cWQa3dKNAAAAAWJLR0QN9rRh9QAAAAd0SU1FB+YMFgQdOGwsyyMAAAG3SURBVDjLY2AAA0YkwIAJmIDC0jKycvIKilhVAMWUlFVU1Waqa2hqyWBRwcioraM7Ewo09TBUAI3XN5gJB4ZG6CoYGY1NZiIBTRlUBYyMpmYzUYAWM8Q7LDAF5haoCiytrG1s7eD+YWS0R5WfOcvB0cnZxdUUqoKR0Q1NwczZs+cASXcPmAJPDAVz580CUl7SUAVa6ArmL1i4CEjp2oKNYGT09kGVn7Ng/rxFICN8oQr8NFEVLF6wZDHIETP9YY4IUEfxxJLZEAPUAmEKgtxRDFgybxHYgOAQRlZoSISGIcxYNG8pRD48AhbkwAAJioyCxNesZYsXLQOZrx5tjog0UKiGxsTGxSckJiUlJScmJCSkyKWiRCojIxs7BycXNw8vCPDxCwiiJy0hobR0YRFRMXFxMQnJjMwsKSHUNCEklJ2TmyckBGHnFxQWCTGgKSguWV5aBlFQXrG8sgpDQfXy5TW1EAV19cuXN2AoaGyqaBaCgKKW1rY0DAVC7R0gyU4Q0dVdJoSmgAGquayntxPKxJLBgKr6+idMxC4HUTBp8vLlU/Ap6Jq6fNp0fAqEumc0tONVgOk8AMY14tOTtocoAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTEyLTIyVDA0OjI5OjQ0KzAwOjAwdEb1FQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0xMi0yMlQwNDoyOTo0NCswMDowMAUbTakAAAAZdEVYdFNvZnR3YXJlAEFkb2JlIEltYWdlUmVhZHlxyWU8AAAAAElFTkSuQmCC"),
    "haze": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAQAAADZc7J/AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfmDBYEHTkbK/u1AAADcElEQVRIx8XVSWyVVRQH8N/XPiB0oLS2tNAGCkhbmSIIFaqIsdGaVJBY0wDBlUZZm5joyoUL3bg00UQ2BSIYBwwQg6AGkUE0DQ1VA6G2yGNoK7xCKZT2PZ6L9/EGhjVn8937/c9wz/mfew8PW4I7i9g9UGnWOvZALLgLniAiYSxbMY3mmSgwJpHaLtODIJYxXanVfMVGnfGDnw1nhazRapXpAoOO2+NU+gQxIoot8IZ1StIGow763FFDmKbVmxZlueuzzVf6jIgHMTZ5xywlSBowpECliRhz1iV5qs2UhxH9EipMBYOiPrY9gtkWY9xx2x10RYHHtXtemXnmhTEv2OVrpyXUaNFugQoV5hBBv07d9jiQrtc/dltqjRUqJV30q126JcFFv9uixQsa9KdqUGCCYbfvQ/JkhZJGjN4Hy1Ns3I0gi8JSSzUoccMZnS7cpd5giWqBAV26M0RHwm+JNTZbajIYc9pWO/wbGi+02TpVYdtddsBnjqbOFcRo0maFZSaCuPxQ8ZTDeuVpsNoMcFtSPrjqmC7fORLBc94GQ36233lTNWlRq159OoWkbnt1iqv3okYlWrS4lnIQd8t5P9nqWJhbh3letVadQlz3p512pavyiWdt0KRKPJXCXNX6RO/hYapalZIu6c1p61TtaswS1ZPNQkStWkVGndNzD3VlHlUpz3/O6M82Skm+Rm9pVm6ChCHHbbHfSIhOs94m9Qowqs83OvRkLlOdVVZpVZ4T8aZD9usVeMxaT2ReDtBjr05HnQ5ivOtDkNDtkKhSjZYrCv8JiRt02Anj6j1tTujmPR9FwjSGdeqwN8yu0EqvaVYlH3FRu3XoMo7AbK9oN1+h/FQKT1rsLyddyzlkvrkWq5Z0Tpfe8CplSrpIvS6/BTmvXcQUk4y7lun1LClUJHAjN1AkvSrxkpfVKXDLWft8K5qlt8R6TSoEruj0pSPGMywUmW651z2T5Y6TtjpgADO12Wh6FnbVbjv8bcD1IMZm7ysXwU09BhWbowxcERMoNwVc0CuuxiwR3HLZBz6NoEIVYvbp8Idhk9Rp02austBRQrdt9oi67RGrbfKUIjNUpFLYoN0J+3TmlK5Ws5UhC7/40aWccjZqttBOXwSxVKMk7mCluVMo9TqnsZwhFJGUyKLxexuzLB88zO43Bh+m/A85hRxbJUHeCgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMi0xMi0yMlQwNDoyOTo0OCswMDowMLPmn2EAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjItMTItMjJUMDQ6Mjk6NDgrMDA6MDDCuyfdAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAABJRU5ErkJggg=="),
    "snow": base64.decode("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAQAAADZc7J/AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfmDBYEHTqCIqoPAAACeElEQVRIx5XUT2wUdRjG8c/MbmmRRFmzKdGYwEGR0BPl4gEJ9GBDPEjiwZMYDtwQPUBIiOd60gNB4wESA+FPNFESINGY0CBXT+BB6QkwVVrpxhYo3e7scJju7G//y3Oa3Xmf7+99n9/kjQSq6K6S3oo6zEWbvaEsMeuOvwchohZ7bLdD3rbJEJbddc1pf/ZDhIANjvqko3LGZ76X9kJEuX3YlE/FXWoqPna+VxdNw4cOd7VT8rmdfTKowGt+MtYn7HPRwTQJmc3MM71ju36arE/EM2kssWApO7QUACK7mxfaVaOrF4pPYxL3/eisf6ko5YD1thigennZejGb7TLpsJkwxIKRQQASVWlj4JNezgbJAKsWBwNI1RqISR+EHTz1x8ARxGFMkX3WNQH8YqW/PQMEiFHDIeCGm/0ANZFYHHbxMDsyXrvPRVPmeseXKLTa+Vk17IBpxzzsFV2soBACpl0KQlz7MM/6yG+d09dE7effdMRc5mtfKK/Y711velEsTaXqIkSNABOzLjtjtnFwMFS+k4aVM0A9v7O8LDFvIXssrb1rUSW3HItvp1fTaO1X6onXo5X0nhcMqTfHbgdcl/9/QsXX+YvYiB1W/W5ZOhE4itoVGVLFuH/AOlUUvG+PxLTvJGF55w7a6lvvGVZTM+KAM15FzX/GbFdRby3v7GDJkq/8aouyS8ZdtIyiB76xakFBrbXhzgwie3xhB244GnwZm9TNQ5hBtzVaNu4lVStG7bQxtzwwz0SLvdsI25xWdsqkituO2++Qv7TZ+gEW/eCKGW+ZM+WqvR7ro07ArC8RKSrills8H6Chix75H+q6zK8HzxMDAM8AAnSwkVwtpqkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjItMTItMjJUMDQ6Mjk6NDkrMDA6MDAVkZTVAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIyLTEyLTIyVDA0OjI5OjQ5KzAwOjAwZMwsaQAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAAASUVORK5CYII=")
}

def errorView(message):
    return render.WrappedText(
        content=message,
        width=64,
        color="#fff",
    )

def main(config):
    #**REDACTED**
    if 'jwt' not in config:
        return render.Root(child=errorView("no jwt"))

    loc = None
    if 'location' in config:
        loc = config["location"]
    else:
        loc = {
            "lat": 37.206629,
            "lng": -79.979439,
            "timezone": "America/New_York"
        }

    now = time.now().in_location(loc["timezone"])
    currentHour = now.hour

    currentWeather_dto = cache.get("weatherData")
    currentWeather = None
    if currentWeather_dto == None:
        print("Getting weather")
        rep = http.get("https://weatherkit.apple.com/api/v1/weather/English/" + str(loc['lat']) + "/" + str(loc['lng']) + "?timezone="+ loc['timezone'] + "&dataSets=currentWeather%2CforecastDaily", headers={
            "Authorization": "Bearer " + config["jwt"]
        })
        if rep.status_code != 200:
            return render.Root(
                child=errorView("error getting weather data")
            )

        currentWeather = rep.json()
        cache.set("currentWeather", json.encode(currentWeather), ttl_seconds=600)
    else:
        currentWeather = json.decode(currentWeather_dto)
    print(currentWeather)

    currentWeatherIcon = currentWeather["currentWeather"]["conditionCode"].lower()
    if currentHour > 18 or currentHour < 6:
        if currentWeatherIcon + "-night" in icons.keys():
            currentWeatherIcon = currentWeatherIcon + "-night"
    
    lastColumn = None
    #if album != trackTitle:
        #lastColumn = [detailText(artist), render.Padding(pad=(0,1,0,0), child=detailText(album))]
    #else:
        #lastColumn = [detailText(artist)]

    return render.Root(
        child=render.Row(children=[
            render.Column(children=[
                render.Padding(pad=(-2,0,0,0), child=render.Image(src=icons[currentWeatherIcon], height=22, width=22)),
                render.Text(cToF(currentWeather["currentWeather"]["temperature"]))
            ], cross_align="center"),
            render.Column(children=[
                render.Text(cToF(currentWeather["forecastDaily"]["days"][0]["temperatureMax"]), color="#F44"),
                render.Text(cToF(currentWeather["forecastDaily"]["days"][0]["temperatureMin"]), color="#66F")
            ], main_align="space_evenly", expanded=True, cross_align="center")
        ], cross_align="center", expanded=True, main_align="space_evenly")
    )

def cToF(c):
    fahrenheit = (c * 1.8) + 32
    return str(int(math.round(fahrenheit))) + "°"

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [
            schema.Text(
                id = "jwt",
                name = "JWT for WeatherKit",
                desc = "",
                icon = "user",
            ),
            schema.Location(
                id = "location",
                name = "Location",
                desc = "Location for which to display weather radar.",
                icon = "locationDot",
            ),
        ],
    )