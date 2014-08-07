From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Thu, 7 Aug 2014 17:44:32 +0200
Message-ID: <CAL8zT=hcJOzGbDTgbp3Z7Yc5HhtGoALQ+w1Mhb9KBYSoN7dbAQ@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
 <CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com>
 <CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
 <CAL8zT=itTv9Uy4HreJQdttwhn29sKcNGc6ccynCNcScrFeWYig@mail.gmail.com>
 <CAOMZO5Dbmk3kxwn__o+fB0Wwumq5f+4tvu0m0x3aqOAZC-GWTQ@mail.gmail.com>
 <CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com>
 <CAC1bqKgct-Hq3+9PZ-6p79qSjf=UNhpLWykJ_e0=1ThGoMPpkg@mail.gmail.com>
 <CAL8zT=gS1rwFU1eUcYNpKmygpnmTDXeQRtg6Uxr9FVXRJ6PmeA@mail.gmail.com>
 <53E21515.3060807@samsung.com> <CAL8zT=hcYUUnP1PXYu_9+JUTx=sqBAQkiY1g7K+=TbLSx4J8-g@mail.gmail.com>
 <CAOMZO5CV7yTT5K4S7L+UcO_No2rRsPGWTqmSh79mQmoL2QKsYg@mail.gmail.com>
 <CAL8zT=h6qxPrnXeys0P48hUxsc21MfO_wWNC-g9UrLB-3YZ=Mg@mail.gmail.com>
 <CAL8zT=iaKfEW32vq5_5yXxuMEAzS8=GsJhUR16TH4bQcK9DgpQ@mail.gmail.com>
 <CAL8zT=giMNWG+xwhcR_N8GbCCPEeucaNDG0QQfOos0v3RcwC6Q@mail.gmail.com>
 <53E32FE4.8060401@samsung.com> <CAL8zT=jjx0XOvtSTR14FA9=TqnD9X3imZRo1xBVykqacwKJSEw@mail.gmail.com>
 <CAL8zT=jRJy83oNKd97m=Trx991jL-wGuq4mLgUi3cS6eCcnp_A@mail.gmail.com> <CAC1bqKgQZ-XweMp+mj8Bmm6b6nNzSKOsAjhZcNc=_P91nzx_vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34442 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbaHGPos (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Aug 2014 11:44:48 -0400
Received: by mail-ob0-f181.google.com with SMTP id va2so3076984obc.40
        for <linux-mmc@vger.kernel.org>; Thu, 07 Aug 2014 08:44:47 -0700 (PDT)
In-Reply-To: <CAC1bqKgQZ-XweMp+mj8Bmm6b6nNzSKOsAjhZcNc=_P91nzx_vg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-08-07 17:02 GMT+02:00 Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>:
>> [    1.366291] mmcblk1: error -84 transferring data, sector 0, nr 8,
>> cmd response 0x900, card status 0xb00
>> [    1.374409] mmcblk1: retrying using single block read
>> [    1.378810] mmcblk1: error -84 transferring data, sector 0, nr 8,
>> cmd response 0x900, card status 0x0
> At first, the kernel driver uses multiple read(cmd 18) to read data
> from sector 0 to sector 8, but fail.
> And then, retry by single read(cmd 17), but still fail...
>
>> [    2.050460]  mmcblk1boot0: unable to read partition table
> You are trying to read boot partition data, as I remember when we
> access boot partition, we need to sync the bus width, frequency and
> timing(SDR, DDR).
>
> Maybe you can turn on the MMC debug config. As a result, you can check
> what kind of commands the kernel driver send.
>

I don't have a big enough log buffer, but here is what I get after booting :
[  258.901572] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  258.901632] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  259.893768] mmc0: starting CMD13 arg 00020000 flags 00000195
[  259.893867] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  259.894909] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  259.894938] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  259.901578] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  259.901637] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  260.893767] mmc0: starting CMD13 arg 00020000 flags 00000195
[  260.893865] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  260.894906] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  260.894937] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  260.901582] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  260.901641] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  261.893765] mmc0: starting CMD13 arg 00020000 flags 00000195
[  261.893864] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  261.894905] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  261.894935] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  261.901576] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  261.901636] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  262.893769] mmc0: starting CMD13 arg 00020000 flags 00000195
[  262.893867] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  262.894908] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  262.894938] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  262.901583] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  262.901642] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  263.893763] mmc0: starting CMD13 arg 00020000 flags 00000195
[  263.893861] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  263.894903] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  263.894932] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  263.901576] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  263.901637] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  264.893758] mmc0: starting CMD13 arg 00020000 flags 00000195
[  264.893856] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  264.894898] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  264.894928] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  264.901574] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  264.901634] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  265.893769] mmc0: starting CMD13 arg 00020000 flags 00000195
[  265.893867] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  265.894908] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  265.894939] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  265.901585] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  265.901646] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  266.893766] mmc0: starting CMD13 arg 00020000 flags 00000195
[  266.893864] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  266.894905] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  266.894935] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  266.901612] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  266.901672] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  267.893768] mmc0: starting CMD13 arg 00020000 flags 00000195
[  267.893865] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  267.894907] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  267.894937] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  267.901580] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  267.901640] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  268.893769] mmc0: starting CMD13 arg 00020000 flags 00000195
[  268.893867] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  268.894909] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  268.894938] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  268.901579] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  268.901638] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  269.893765] mmc0: starting CMD13 arg 00020000 flags 00000195
[  269.893864] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000
[  269.894905] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 2
[  269.894935] sdhci-esdhc-imx 2198000.usdhc: desired SD clock:
50000000, actual: 49500000

Is this normal to get an interrupt every second, and change pinctrl
state each time ?
JM
