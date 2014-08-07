From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: Sandisk MMC I/O errors
Date: Thu, 07 Aug 2014 16:51:00 +0900
Message-ID: <53E32FE4.8060401@samsung.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23548 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbaHGHvE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Aug 2014 03:51:04 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9X00B1NF51LH10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Aug 2014 16:51:01 +0900 (KST)
In-reply-to: <CAL8zT=giMNWG+xwhcR_N8GbCCPEeucaNDG0QQfOos0v3RcwC6Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Fabio Estevam <festevam@gmail.com>
Cc: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 08/07/2014 04:18 PM, Jean-Michel Hautbois wrote:
> 2014-08-07 8:59 GMT+02:00 Jean-Michel Hautbois
> <jean-michel.hautbois@vodalys.com>:
>> 2014-08-06 16:21 GMT+02:00 Jean-Michel Hautbois
>> <jean-michel.hautbois@vodalys.com>:
>>> 2014-08-06 15:37 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
>>>> On Wed, Aug 6, 2014 at 10:27 AM, Jean-Michel Hautbois
>>>> <jean-michel.hautbois@vodalys.com> wrote:
>>>>> 2014-08-06 13:44 GMT+02:00 Jaehoon Chung <jh80.chung@samsung.com>:
>>>>>> Hi,
>>>>>
>>>>> Hi Jaehoon,
>>>>>
>>>>>> In my case, -84 error is related with timing.
>>>>>> I recommend to check your clock source or pin strength.
>>
>> I have dumped /sys/kernel/debug/mmc1/ios in both kernel releases.
>>
>> In the current kernel (3.16) :
>> $> cat /sys/kernel/debug/mmc1/ios
>> clock:          52000000 Hz
>> actual clock:   49500000 Hz
>> vdd:            21 (3.3 ~ 3.4 V)
>> bus mode:       2 (push-pull)
>> chip select:    0 (don't care)
>> power mode:     2 (on)
>> bus width:      3 (8 bits)
>> timing spec:    8 (mmc DDR52)
>> signal voltage: 0 (3.30 V)
>>
>> In the Freescale kernel (3.10.17) :
>> $> cat /sys/kernel/debug/mmc1/ios
>> clock:          52000000 Hz
>> actual clock:   49500000 Hz
>> vdd:            7 (1.65 - 1.95 V)
>> bus mode:       2 (push-pull)
>> chip select:    0 (don't care)
>> power mode:     2 (on)
>> bus width:      3 (8 bits)
>> timing spec:    7 (sd uhs DDR50)
>> signal voltage: 0 (3.30 V)
>>
>> As you can see, there is at least too differences : VDD is not the
>> same I don't know why yet, and neither is timing spec. This seems to
>> be the real cause...
>> Investigating now, but any advice is interesting ! :)
UHS mode is run the voltage-change sequence.
So printed that vdd is 1.8v at linux3.10.

>>
>> Thanks,
>> JM
> 
> OK, I juste tested to get back on part of the commit
> 79f7ae7c45a6ccf04e2908337461dee615f6afb0 :
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1ab5f3a..e22d851 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1264,7 +1264,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                                         goto err;
>                         }
>                         mmc_card_set_ddr_mode(card);
> -                       mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
> +                       mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
>                         mmc_set_bus_width(card->host, bus_width);
>                 }
>         }
> 
> 
> I just did the inverse, that means using MMC_TIMING_UHS_DDR50 and not
> MMC_TIMING_MMC_DDR52 and I don't have any errors now.

Is your card eMMC or SD(T-flash)? Which card do you use?
Did you check dt-file?

Best Regards,
Jaehoon Chung

> 
> Reverting the commit is not the solution, I need to know why the
> timings are not the good ones now...
> JM
> 

