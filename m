From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Fri, 8 Aug 2014 09:54:31 +0200
Message-ID: <CAL8zT=jfjAgoQ-HCWFxsibAHoQ5JHwZvn3Cr9TvDX9kDHGcyRQ@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
 <CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com>
 <CAC1bqKgct-Hq3+9PZ-6p79qSjf=UNhpLWykJ_e0=1ThGoMPpkg@mail.gmail.com>
 <CAL8zT=gS1rwFU1eUcYNpKmygpnmTDXeQRtg6Uxr9FVXRJ6PmeA@mail.gmail.com>
 <53E21515.3060807@samsung.com> <CAL8zT=hcYUUnP1PXYu_9+JUTx=sqBAQkiY1g7K+=TbLSx4J8-g@mail.gmail.com>
 <CAOMZO5CV7yTT5K4S7L+UcO_No2rRsPGWTqmSh79mQmoL2QKsYg@mail.gmail.com>
 <CAL8zT=h6qxPrnXeys0P48hUxsc21MfO_wWNC-g9UrLB-3YZ=Mg@mail.gmail.com>
 <CAL8zT=iaKfEW32vq5_5yXxuMEAzS8=GsJhUR16TH4bQcK9DgpQ@mail.gmail.com>
 <CAL8zT=giMNWG+xwhcR_N8GbCCPEeucaNDG0QQfOos0v3RcwC6Q@mail.gmail.com>
 <53E32FE4.8060401@samsung.com> <CAL8zT=jjx0XOvtSTR14FA9=TqnD9X3imZRo1xBVykqacwKJSEw@mail.gmail.com>
 <CAL8zT=jRJy83oNKd97m=Trx991jL-wGuq4mLgUi3cS6eCcnp_A@mail.gmail.com>
 <CAC1bqKgQZ-XweMp+mj8Bmm6b6nNzSKOsAjhZcNc=_P91nzx_vg@mail.gmail.com>
 <CAL8zT=hcJOzGbDTgbp3Z7Yc5HhtGoALQ+w1Mhb9KBYSoN7dbAQ@mail.gmail.com>
 <53E4401C.2040708@samsung.com> <CAL8zT=ikgxsK0r4qPgv3FQYtk-hMqFQcucBAVPkF=iRnPuQUDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:48368 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792AbaHHHyr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Aug 2014 03:54:47 -0400
Received: by mail-oi0-f45.google.com with SMTP id e131so3453843oig.18
        for <linux-mmc@vger.kernel.org>; Fri, 08 Aug 2014 00:54:47 -0700 (PDT)
In-Reply-To: <CAL8zT=ikgxsK0r4qPgv3FQYtk-hMqFQcucBAVPkF=iRnPuQUDg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>, Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-08-08 9:06 GMT+02:00 Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com>:
> 2014-08-08 5:12 GMT+02:00 Jaehoon Chung <jh80.chung@samsung.com>:
>> On 08/08/2014 12:44 AM, Jean-Michel Hautbois wrote:
>>> 2014-08-07 17:02 GMT+02:00 Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>:
>>>>> [    1.366291] mmcblk1: error -84 transferring data, sector 0, nr 8,
>>>>> cmd response 0x900, card status 0xb00
>>>>> [    1.374409] mmcblk1: retrying using single block read
>>>>> [    1.378810] mmcblk1: error -84 transferring data, sector 0, nr 8,
>>>>> cmd response 0x900, card status 0x0
>>>> At first, the kernel driver uses multiple read(cmd 18) to read data
>>>> from sector 0 to sector 8, but fail.
>>>> And then, retry by single read(cmd 17), but still fail...
>>>>
>>>>> [    2.050460]  mmcblk1boot0: unable to read partition table
>>>> You are trying to read boot partition data, as I remember when we
>>>> access boot partition, we need to sync the bus width, frequency and
>>>> timing(SDR, DDR).
>>
>> If you don't access at boot partition, use the MMC_CAP2_BOOTPART_NOACC.
>
> How can I do that properly ?

In modified include/linux/mmc/host.h in order to return 0 in the
function mmc_boot_partition_access().
I don't have boot partition access, but still I/O errors :


[    4.518031] mmcblk1: error -84 transferring data, sector 12, nr 4,
cmd response 0x900, card status 0x0
[    4.518063] mmc1: starting CMD17 arg 00001a00 flags 000000b5
[    4.518085] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
[    4.518147] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.518478] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00200002
[    4.518545] mmc1: req done (CMD17): 0: 00000900 00000000 00000000 00000000
[    4.518563] mmc1:     0 bytes transferred: -84
[    4.518646] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[    4.518690] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    4.518732] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[    4.518746] mmc0:     4096 bytes transferred: 0
[    4.518756] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[    4.518783] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.518826] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.518849] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    4.519005] mmc0: starting CMD18 arg 00062000 flags 000000b5
[    4.519022] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
[    4.519042] mmc0:     CMD12 arg 00000000 flags 00000095
[    4.519106] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    4.521216] mmcblk1: error -84 transferring data, sector 13, nr 3,
cmd response 0x900, card status 0x0
[    4.521247] mmc1: starting CMD17 arg 00001c00 flags 000000b5
[    4.521258] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
[    4.521309] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.521502] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[    4.521539] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    4.521566] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[    4.521575] mmc0:     4096 bytes transferred: 0
[    4.521585] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[    4.521646] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00200002
[    4.521678] mmc1: req done (CMD17): 0: 00000900 00000000 00000000 00000000
[    4.521688] mmc1:     0 bytes transferred: -84
[    4.521746] mmc1: starting CMD13 arg 00010000 flags 00000195
[    4.521790] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
[    4.521813] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    4.523600] mmcblk1: error -84 transferring data, sector 14, nr 2,
cmd response 0x900, card status 0x0


JM
