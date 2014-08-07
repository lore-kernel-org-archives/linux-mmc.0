From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Thu, 7 Aug 2014 08:59:55 +0200
Message-ID: <CAL8zT=iaKfEW32vq5_5yXxuMEAzS8=GsJhUR16TH4bQcK9DgpQ@mail.gmail.com>
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
 <CAOMZO5CV7yTT5K4S7L+UcO_No2rRsPGWTqmSh79mQmoL2QKsYg@mail.gmail.com> <CAL8zT=h6qxPrnXeys0P48hUxsc21MfO_wWNC-g9UrLB-3YZ=Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:59706 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbaHGHAL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Aug 2014 03:00:11 -0400
Received: by mail-oa0-f45.google.com with SMTP id i7so2692458oag.18
        for <linux-mmc@vger.kernel.org>; Thu, 07 Aug 2014 00:00:10 -0700 (PDT)
In-Reply-To: <CAL8zT=h6qxPrnXeys0P48hUxsc21MfO_wWNC-g9UrLB-3YZ=Mg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-08-06 16:21 GMT+02:00 Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com>:
> 2014-08-06 15:37 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
>> On Wed, Aug 6, 2014 at 10:27 AM, Jean-Michel Hautbois
>> <jean-michel.hautbois@vodalys.com> wrote:
>>> 2014-08-06 13:44 GMT+02:00 Jaehoon Chung <jh80.chung@samsung.com>:
>>>> Hi,
>>>
>>> Hi Jaehoon,
>>>
>>>> In my case, -84 error is related with timing.
>>>> I recommend to check your clock source or pin strength.

I have dumped /sys/kernel/debug/mmc1/ios in both kernel releases.

In the current kernel (3.16) :
$> cat /sys/kernel/debug/mmc1/ios
clock:          52000000 Hz
actual clock:   49500000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    8 (mmc DDR52)
signal voltage: 0 (3.30 V)

In the Freescale kernel (3.10.17) :
$> cat /sys/kernel/debug/mmc1/ios
clock:          52000000 Hz
actual clock:   49500000 Hz
vdd:            7 (1.65 - 1.95 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    7 (sd uhs DDR50)
signal voltage: 0 (3.30 V)

As you can see, there is at least too differences : VDD is not the
same I don't know why yet, and neither is timing spec. This seems to
be the real cause...
Investigating now, but any advice is interesting ! :)

Thanks,
JM
