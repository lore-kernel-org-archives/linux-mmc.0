From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: sdhci-esdhc-imx : cannot read eMMC
Date: Wed, 3 Sep 2014 17:11:05 +0200
Message-ID: <CAL8zT=gUZd294v1w_PGgfg6kmPK9OuxuO3xd0tJWvSQE+RFQ9A@mail.gmail.com>
References: <CAL8zT=gJtnyGSnVz+YWW3Z1LPXPp-Oe3SsGqvBvV=2LBpZ-t9Q@mail.gmail.com>
 <CAL8zT=gpiV9OMToH80Qr5B7HUUbVDp0m_WK9PaCvuaMGwrBSJA@mail.gmail.com> <CAA+hA=QQ=AYnKts0cq0VpWkWUyt-r1v-LxCk1pQiyo=CFSCurA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:51981 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641AbaICPLZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 11:11:25 -0400
Received: by mail-oa0-f54.google.com with SMTP id g18so6032988oah.13
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 08:11:20 -0700 (PDT)
In-Reply-To: <CAA+hA=QQ=AYnKts0cq0VpWkWUyt-r1v-LxCk1pQiyo=CFSCurA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-09-03 10:15 GMT+02:00 Dong Aisheng <dongas86@gmail.com>:
> Hi JM,
>
> On Tue, Sep 2, 2014 at 11:10 PM, Jean-Michel Hautbois
> <jhautbois@gmail.com> wrote:
>> 2014-09-02 11:20 GMT+02:00 Jean-Michel Hautbois
>> <jean-michel.hautbois@vodalys.com>:
>>> Hi there,
>>>
>>> I start a new thread, as I have done lots of test and this will be clearer.
>>> I have problems reading and writing eMMC on my i.MX6 board with 3.17-rc3.
>>> Sometimes I don't have read errors explicitly in dmesg, but fdisk has
>>> no effects.
>>> I activated MMC debug in my config file, and here is an extract of
>>> mmc0 register dump and all mmc1 part.
>>> On Freescale kernel, I confirm it works well with the same board and
>>> sample, I can write a partition on mmc1.
>>
>
> My iMX6Q SabreSD board seems ok.
> What board did you use?
> What reading/writing problems did you meet?
> I did not see errors in your log.
> Can you paste the error log?

When CONFIG_MMC_DEBUG=y there is no error.
When CONFIG_MMC_DEBUG=n then, I get :

[    2.036958] SW2: Restricting voltage, 3300000-1950000uV
[    2.036965] mmc1: Switching to 1.8V signalling voltage  failed
[    2.043714] mmc1: new DDR MMC card at address 0001
[    2.044738] mmcblk1: mmc1:0001 SEM02G 1.82 GiB
[    2.045007] mmcblk1rpmb: mmc1:0001 SEM02G partition 3 128 KiB
[    2.048345] mmcblk1: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0xb00
[    2.048352] mmcblk1: retrying using single block read
[    2.048858] mmcblk1: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0x0
[    2.048933] end_request: I/O error, dev mmcblk1, sector 0
[    2.049449] mmcblk1: error -84 transferring data, sector 1, nr 7,
cmd response 0x900, card status 0x0
[    2.049459] end_request: I/O error, dev mmcblk1, sector 1
[    2.049969] mmcblk1: error -84 transferring data, sector 2, nr 6,
cmd response 0x900, card status 0x0
[    2.049978] end_request: I/O error, dev mmcblk1, sector 2
[    2.050484] mmcblk1: error -84 transferring data, sector 3, nr 5,
cmd response 0x900, card status 0x0
[    2.050493] end_request: I/O error, dev mmcblk1, sector 3
[    2.050998] mmcblk1: error -84 transferring data, sector 4, nr 4,
cmd response 0x900, card status 0x0
[    2.051008] end_request: I/O error, dev mmcblk1, sector 4
[    2.051512] mmcblk1: error -84 transferring data, sector 5, nr 3,
cmd response 0x900, card status 0x0
[    2.051521] end_request: I/O error, dev mmcblk1, sector 5
[    2.052028] mmcblk1: error -84 transferring data, sector 6, nr 2,
cmd response 0x900, card status 0x0
[    2.052038] end_request: I/O error, dev mmcblk1, sector 6
[    2.052542] mmcblk1: error -84 transferring data, sector 7, nr 1,
cmd response 0x900, card status 0x0
[    2.052551] end_request: I/O error, dev mmcblk1, sector 7
[    2.052620] Buffer I/O error on device mmcblk1, logical block 0
[    2.053338] mmcblk1: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0xb00
[    2.053345] mmcblk1: retrying using single block read
[    2.053849] mmcblk1: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0x0
[    2.053859] end_request: I/O error, dev mmcblk1, sector 0
[    2.054378] mmcblk1: error -84 transferring data, sector 1, nr 7,
cmd response 0x900, card status 0x0
[    2.054388] end_request: I/O error, dev mmcblk1, sector 1
[    2.054892] mmcblk1: error -84 transferring data, sector 2, nr 6,
cmd response 0x900, card status 0x0
[    2.055403] mmcblk1: error -84 transferring data, sector 3, nr 5,
cmd response 0x900, card status 0x0
[    2.055917] mmcblk1: error -84 transferring data, sector 4, nr 4,
cmd response 0x900, card status 0x0
[    2.056428] mmcblk1: error -84 transferring data, sector 5, nr 3,
cmd response 0x900, card status 0x0
[    2.056937] mmcblk1: error -84 transferring data, sector 6, nr 2,
cmd response 0x900, card status 0x0
[    2.057446] mmcblk1: error -84 transferring data, sector 7, nr 1,
cmd response 0x900, card status 0x0
[    2.057460] Buffer I/O error on device mmcblk1, logical block 0
[    2.057506]  mmcblk1: unable to read partition table

So, I can't get MMC_DEBUG info when the problem occurs, as it disappears :/.
Thanks,
JM
