From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Thu, 7 Aug 2014 09:54:57 +0200
Message-ID: <CAL8zT=jjx0XOvtSTR14FA9=TqnD9X3imZRo1xBVykqacwKJSEw@mail.gmail.com>
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
 <CAL8zT=giMNWG+xwhcR_N8GbCCPEeucaNDG0QQfOos0v3RcwC6Q@mail.gmail.com> <53E32FE4.8060401@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49351 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbaHGHzN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Aug 2014 03:55:13 -0400
Received: by mail-ob0-f174.google.com with SMTP id vb8so2668051obc.5
        for <linux-mmc@vger.kernel.org>; Thu, 07 Aug 2014 00:55:12 -0700 (PDT)
In-Reply-To: <53E32FE4.8060401@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Fabio Estevam <festevam@gmail.com>, Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>> OK, I juste tested to get back on part of the commit
>> 79f7ae7c45a6ccf04e2908337461dee615f6afb0 :
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 1ab5f3a..e22d851 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1264,7 +1264,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>                                         goto err;
>>                         }
>>                         mmc_card_set_ddr_mode(card);
>> -                       mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
>> +                       mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
>>                         mmc_set_bus_width(card->host, bus_width);
>>                 }
>>         }
>>
>>
>> I just did the inverse, that means using MMC_TIMING_UHS_DDR50 and not
>> MMC_TIMING_MMC_DDR52 and I don't have any errors now.
>
> Is your card eMMC or SD(T-flash)? Which card do you use?
> Did you check dt-file?

The card is Sandisk SDIN5D1-2G which is a iNAND.
What should I check in DT ?

Thanks,
JM
