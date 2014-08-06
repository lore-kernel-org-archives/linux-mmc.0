From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Wed, 6 Aug 2014 16:21:25 +0200
Message-ID: <CAL8zT=h6qxPrnXeys0P48hUxsc21MfO_wWNC-g9UrLB-3YZ=Mg@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
 <CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
 <CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
 <CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com>
 <CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
 <CAL8zT=itTv9Uy4HreJQdttwhn29sKcNGc6ccynCNcScrFeWYig@mail.gmail.com>
 <CAOMZO5Dbmk3kxwn__o+fB0Wwumq5f+4tvu0m0x3aqOAZC-GWTQ@mail.gmail.com>
 <CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com>
 <CAC1bqKgct-Hq3+9PZ-6p79qSjf=UNhpLWykJ_e0=1ThGoMPpkg@mail.gmail.com>
 <CAL8zT=gS1rwFU1eUcYNpKmygpnmTDXeQRtg6Uxr9FVXRJ6PmeA@mail.gmail.com>
 <53E21515.3060807@samsung.com> <CAL8zT=hcYUUnP1PXYu_9+JUTx=sqBAQkiY1g7K+=TbLSx4J8-g@mail.gmail.com>
 <CAOMZO5CV7yTT5K4S7L+UcO_No2rRsPGWTqmSh79mQmoL2QKsYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:61844 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaHFOVl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Aug 2014 10:21:41 -0400
Received: by mail-ob0-f182.google.com with SMTP id wm4so1814264obc.13
        for <linux-mmc@vger.kernel.org>; Wed, 06 Aug 2014 07:21:41 -0700 (PDT)
In-Reply-To: <CAOMZO5CV7yTT5K4S7L+UcO_No2rRsPGWTqmSh79mQmoL2QKsYg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-08-06 15:37 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
> On Wed, Aug 6, 2014 at 10:27 AM, Jean-Michel Hautbois
> <jean-michel.hautbois@vodalys.com> wrote:
>> 2014-08-06 13:44 GMT+02:00 Jaehoon Chung <jh80.chung@samsung.com>:
>>> Hi,
>>
>> Hi Jaehoon,
>>
>>> In my case, -84 error is related with timing.
>>> I recommend to check your clock source or pin strength.
>>
>> Thanks for this advice.
>> In fact, it seems that the clock is not correct, as stated by the kernel :
>>
>> $> cat /sys/kernel/debug/mmc1/ios
>> clock:          52000000 Hz
>> actual clock:   49500000 Hz
>>
>> But I can't find out why because the clock comes on the SD4_CLK pin,
>> and this is directly connected to the i.MX6 processor.
>> And it is not a HW problem because as I said before, on Freescale
>> repository, it works...
>
> Try to compare the mmc clock tree in the FSL kernel versus 3.16:
>
> mount -t debugfs none /sys/kernel/debug/
> cat /sys/kernel/debug/clk/clk_dump

I have the following on 3.10.17 for usdhc4 :
"usdhc4_sel": { "enable_count": 0,"prepare_count": 0,"rate":
396000000,"usdhc4_podf": { "enable_count": 0,"prepare_count":
0,"rate": 198000000,"usdhc4": { "enable_count": 0,"prepare_count":
0,"rate": 198000000,"gpmi_bch": { "enable_count": 0,"prepare_count":
0,"rate": 198000000}}}},

And for 3.16 :
"usdhc4_sel": { "enable_count": 0,"prepare_count": 0,"rate":
396000000"accuracy": 0,"usdhc4_podf": { "enable_count":
0,"prepare_count": 0,"rate": 198000000"accuracy": 0,"usdhc4": {
"enable_count": 0,"prepare_count": 0,"rate": 198000000"accuracy":
0,"gpmi_bch": { "enable_count": 0,"prepare_count": 0,"rate":
198000000"accuracy": 0}}}},


The only difference is the presence of "accuracy:0" in 3.16 and not
the previous one.
It seems to be linked to timing because on another board, with 3.16,
it works correctly.
Is it possible to modify the clocks or to know if the MMC is maybe
corrupted in one way ?

Thanks,
JM
