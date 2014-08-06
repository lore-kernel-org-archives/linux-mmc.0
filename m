From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Sandisk MMC I/O errors
Date: Wed, 6 Aug 2014 10:37:12 -0300
Message-ID: <CAOMZO5CV7yTT5K4S7L+UcO_No2rRsPGWTqmSh79mQmoL2QKsYg@mail.gmail.com>
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
	<53E21515.3060807@samsung.com>
	<CAL8zT=hcYUUnP1PXYu_9+JUTx=sqBAQkiY1g7K+=TbLSx4J8-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:41202 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaHFNhO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Aug 2014 09:37:14 -0400
Received: by mail-la0-f47.google.com with SMTP id mc6so1979327lab.34
        for <linux-mmc@vger.kernel.org>; Wed, 06 Aug 2014 06:37:12 -0700 (PDT)
In-Reply-To: <CAL8zT=hcYUUnP1PXYu_9+JUTx=sqBAQkiY1g7K+=TbLSx4J8-g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Aug 6, 2014 at 10:27 AM, Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com> wrote:
> 2014-08-06 13:44 GMT+02:00 Jaehoon Chung <jh80.chung@samsung.com>:
>> Hi,
>
> Hi Jaehoon,
>
>> In my case, -84 error is related with timing.
>> I recommend to check your clock source or pin strength.
>
> Thanks for this advice.
> In fact, it seems that the clock is not correct, as stated by the kernel :
>
> $> cat /sys/kernel/debug/mmc1/ios
> clock:          52000000 Hz
> actual clock:   49500000 Hz
>
> But I can't find out why because the clock comes on the SD4_CLK pin,
> and this is directly connected to the i.MX6 processor.
> And it is not a HW problem because as I said before, on Freescale
> repository, it works...

Try to compare the mmc clock tree in the FSL kernel versus 3.16:

mount -t debugfs none /sys/kernel/debug/
cat /sys/kernel/debug/clk/clk_dump
