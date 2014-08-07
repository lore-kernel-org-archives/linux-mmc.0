From: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Subject: Re: Sandisk MMC I/O errors
Date: Thu, 7 Aug 2014 23:02:24 +0800
Message-ID: <CAC1bqKgQZ-XweMp+mj8Bmm6b6nNzSKOsAjhZcNc=_P91nzx_vg@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
	<CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com>
	<CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
	<CAL8zT=itTv9Uy4HreJQdttwhn29sKcNGc6ccynCNcScrFeWYig@mail.gmail.com>
	<CAOMZO5Dbmk3kxwn__o+fB0Wwumq5f+4tvu0m0x3aqOAZC-GWTQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:40899 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbaHGPCZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Aug 2014 11:02:25 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so4220399wes.6
        for <linux-mmc@vger.kernel.org>; Thu, 07 Aug 2014 08:02:24 -0700 (PDT)
In-Reply-To: <CAL8zT=jRJy83oNKd97m=Trx991jL-wGuq4mLgUi3cS6eCcnp_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

> [    1.366291] mmcblk1: error -84 transferring data, sector 0, nr 8,
> cmd response 0x900, card status 0xb00
> [    1.374409] mmcblk1: retrying using single block read
> [    1.378810] mmcblk1: error -84 transferring data, sector 0, nr 8,
> cmd response 0x900, card status 0x0
At first, the kernel driver uses multiple read(cmd 18) to read data
from sector 0 to sector 8, but fail.
And then, retry by single read(cmd 17), but still fail...

> [    2.050460]  mmcblk1boot0: unable to read partition table
You are trying to read boot partition data, as I remember when we
access boot partition, we need to sync the bus width, frequency and
timing(SDR, DDR).

Maybe you can turn on the MMC debug config. As a result, you can check
what kind of commands the kernel driver send.



2014-08-07 16:54 GMT+08:00 Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com>:
> 2014-08-07 9:54 GMT+02:00 Jean-Michel Hautbois
> <jean-michel.hautbois@vodalys.com>:
>>>> OK, I juste tested to get back on part of the commit
>>>> 79f7ae7c45a6ccf04e2908337461dee615f6afb0 :
>>>>
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index 1ab5f3a..e22d851 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -1264,7 +1264,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>>                                         goto err;
>>>>                         }
>>>>                         mmc_card_set_ddr_mode(card);
>>>> -                       mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
>>>> +                       mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
>>>>                         mmc_set_bus_width(card->host, bus_width);
>>>>                 }
>>>>         }
>>>>
>>>>
>>>> I just did the inverse, that means using MMC_TIMING_UHS_DDR50 and not
>>>> MMC_TIMING_MMC_DDR52 and I don't have any errors now.
>>>
>>> Is your card eMMC or SD(T-flash)? Which card do you use?
>>> Did you check dt-file?
>>
>> The card is Sandisk SDIN5D1-2G which is a iNAND.
>> What should I check in DT ?
>
> I have written too quickly, still have same problem from time to time...
> I don't have a clue, so if anybody has, I am interested...
>
> JM
