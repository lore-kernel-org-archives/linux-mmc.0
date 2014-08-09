From: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Subject: Re: Sandisk MMC I/O errors
Date: Sat, 9 Aug 2014 17:05:39 +0800
Message-ID: <CAC1bqKjDHgcqJ9uwS0ELpkfRTm5ZGzPHeYxYPdShBe_r+XA2SA@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
	<CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com>
	<CAC1bqKgct-Hq3+9PZ-6p79qSjf=UNhpLWykJ_e0=1ThGoMPpkg@mail.gmail.com>
	<CAL8zT=gS1rwFU1eUcYNpKmygpnmTDXeQRtg6Uxr9FVXRJ6PmeA@mail.gmail.com>
	<53E21515.3060807@samsung.com>
	<CAL8zT=hcYUUnP1PXYu_9+JUTx=sqBAQkiY1g7K+=TbLSx4J8-g@mail.gmail.com>
	<CAOMZO5CV7yTT5K4S7L+UcO_No2rRsPGWTqmSh79mQmoL2QKsYg@mail.gmail.com>
	<CAL8zT=h6qxPrnXeys0P48hUxsc21MfO_wWNC-g9UrLB-3YZ=Mg@mail.gmail.com>
	<CAL8zT=iaKfEW32vq5_5yXxuMEAzS8=GsJhUR16TH4bQcK9DgpQ@mail.gmail.com>
	<CAL8zT=giMNWG+xwhcR_N8GbCCPEeucaNDG0QQfOos0v3RcwC6Q@mail.gmail.com>
	<53E32FE4.8060401@samsung.com>
	<CAL8zT=jjx0XOvtSTR14FA9=TqnD9X3imZRo1xBVykqacwKJSEw@mail.gmail.com>
	<CAL8zT=jRJy83oNKd97m=Trx991jL-wGuq4mLgUi3cS6eCcnp_A@mail.gmail.com>
	<CAC1bqKgQZ-XweMp+mj8Bmm6b6nNzSKOsAjhZcNc=_P91nzx_vg@mail.gmail.com>
	<CAL8zT=hcJOzGbDTgbp3Z7Yc5HhtGoALQ+w1Mhb9KBYSoN7dbAQ@mail.gmail.com>
	<53E4401C.2040708@samsung.com>
	<CAL8zT=ikgxsK0r4qPgv3FQYtk-hMqFQcucBAVPkF=iRnPuQUDg@mail.gmail.com>
	<CAL8zT=jfjAgoQ-HCWFxsibAHoQ5JHwZvn3Cr9TvDX9kDHGcyRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59797 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaHIJFl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Aug 2014 05:05:41 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so3500331wiw.3
        for <linux-mmc@vger.kernel.org>; Sat, 09 Aug 2014 02:05:40 -0700 (PDT)
In-Reply-To: <CAL8zT=jfjAgoQ-HCWFxsibAHoQ5JHwZvn3Cr9TvDX9kDHGcyRQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Could you change another sample to test?
As a result, we can check this is a driver issue or sample issue.

> [    4.518732] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> [    4.518746] mmc0:     4096 bytes transferred: 0
> [    4.518756] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
the eMMC has change state to data state(0xb00) and the data transferred 0...
It means the cmd and clk pin work well. I will check the DMA and data
lines(pin).
> [    4.518545] mmc1: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> [    4.518563] mmc1:     0 bytes transferred: -84
No data transferred from your platform to eMMC....even use single block read.
