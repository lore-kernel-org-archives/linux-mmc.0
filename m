From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
Date: Fri, 22 Mar 2013 15:23:42 +0800
Message-ID: <CADz5_g+_JTafM4rLL0Qa8yOSCnoGn9R+nJ6JdqKrR7Td82BDzA@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEC869A3@SC-VEXCH1.marvell.com>
	<CADz5_gJe8xJH6FD7xwxssmWSZ2w4tvKAnYAexzTtVSyW0ovweQ@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C33B2BF@039-SN1MPN1-003.039d.mgd.msft.net>
	<CADz5_gLJvVmJa_5zAZAD-7cfbneySgH8GmwfDfj+-eT3Y80QQA@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C33B361@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:40495 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab3CVHXm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 03:23:42 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so4045591oag.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 Mar 2013 00:23:42 -0700 (PDT)
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C33B361@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>

2013/3/22 Huang Changming-R66093 <r66093@freescale.com>:
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Kevin Liu
>> Sent: Friday, March 22, 2013 2:55 PM
>> To: Huang Changming-R66093
>> Cc: linux-mmc@vger.kernel.org; Chris Ball; Ulf Hansson
>> Subject: Re: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
>>
>> 2013/3/22 Huang Changming-R66093 <r66093@freescale.com>:
>> >> Jerry,
>> >>
>> >> Function _mmc_detect_card_removed should only be called when card
>> >> insert/removal or i/o error occur unless POLLING is used(called once
>> >> per second). So it should _not_ impact performance much.
>> > [jerry]
>> > No, your understanding is wrong.
>> > Function "_mmc_detect_card_removed " is called to check if our card has
>> been removed when driver run the function "mmc_rescan" every time.
>> >
>>
>> But when will mmc_rescan be called?
>> Besides boot up, only when card status change it will be called.
>> So usually it should _not_ be called frequently.
> [jerry]
> For poll mode, how to know card status changed?
> The answer is "mmc_rescan".
> maybe you could read the last two lines of this function ago.
>

I mentioned this in my first response "unless POLLING is used(called once
per second)". I was a bit confused firstly.
I think slot-gpio is a better solution, with which you don't need the
every second polling.

>> >> POLLING is poor for performance, why not change to slot-gpio if host
>> >> is broken for card detect.
>> > [jerry]
>> > Some our boards can't support interrupt mode to detect card
>> insert/removable, so we unify the poll mode.
>> >
>>
>> Not support gpio interrupt?
>> I think you only don't support sdh host interrupt.
>
