From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
Date: Fri, 22 Mar 2013 23:27:02 +0800
Message-ID: <CADz5_gJiV4R0tkmcX-_oY-m64_ETtcGW5bg8euq_rDHGLuFa=Q@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEC869A3@SC-VEXCH1.marvell.com>
	<CADz5_gJe8xJH6FD7xwxssmWSZ2w4tvKAnYAexzTtVSyW0ovweQ@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C33B2BF@039-SN1MPN1-003.039d.mgd.msft.net>
	<CADz5_gLJvVmJa_5zAZAD-7cfbneySgH8GmwfDfj+-eT3Y80QQA@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C33B361@039-SN1MPN1-003.039d.mgd.msft.net>
	<CADz5_g+_JTafM4rLL0Qa8yOSCnoGn9R+nJ6JdqKrR7Td82BDzA@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C33B46A@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAPDyKFrHvg6inGahDwz0dsqBbrzJF4p0oW1PEVxSLEq0Mq-s=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40336 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab3CVP1D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 11:27:03 -0400
Received: by mail-ob0-f171.google.com with SMTP id x4so4096906obh.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 Mar 2013 08:27:02 -0700 (PDT)
In-Reply-To: <CAPDyKFrHvg6inGahDwz0dsqBbrzJF4p0oW1PEVxSLEq0Mq-s=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huang Changming-R66093 <r66093@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

2013/3/22 Ulf Hansson <ulf.hansson@linaro.org>:
> On 22 March 2013 08:42, Huang Changming-R66093 <r66093@freescale.com> wrote:
>>
>> <r66093@freescale.com>:
>>> >> >> Jerry,
>>> >> >>
>>> >> >> Function _mmc_detect_card_removed should only be called when card
>>> >> >> insert/removal or i/o error occur unless POLLING is used(called
>>> >> >> once per second). So it should _not_ impact performance much.
>>> >> > [jerry]
>>> >> > No, your understanding is wrong.
>>> >> > Function "_mmc_detect_card_removed " is called to check if our card
>>> >> > has
>>> >> been removed when driver run the function "mmc_rescan" every time.
>>> >> >
>>> >>
>>> >> But when will mmc_rescan be called?
>>> >> Besides boot up, only when card status change it will be called.
>>> >> So usually it should _not_ be called frequently.
>>> > [jerry]
>>> > For poll mode, how to know card status changed?
>>> > The answer is "mmc_rescan".
>>> > maybe you could read the last two lines of this function ago.
>>> >
>>>
>>> I mentioned this in my first response "unless POLLING is used(called once
>>> per second)". I was a bit confused firstly.
>>> I think slot-gpio is a better solution, with which you don't need the
>>> every second polling.
>> [jerry]
>> Not all Soc has GPIO to do this. our controller has the pin to detect the card status, need the external hardware to support it.
>> But due to some reasons, some boards don't do this work, so need the poll mode for all boards.
>>
>>> >> >> POLLING is poor for performance, why not change to slot-gpio if
>>> >> >> host is broken for card detect.
>>> >> > [jerry]
>>> >> > Some our boards can't support interrupt mode to detect card
>>> >> insert/removable, so we unify the poll mode.
>>> >> >
>>> >>
>>> >> Not support gpio interrupt?
>>> >> I think you only don't support sdh host interrupt.
>>> >
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org More majordomo info at
>>> http://vger.kernel.org/majordomo-info.html
>>
>>
>
> A suggestion; the poll time out is 1s today. We could make some more
> intelligent update to the timeout value so we decrease the number of
> timeouts to happen. In other words minimize the number of mmc_rescan
> to be executed.
>
> 1. When no card is inserted, use 1 s.
> 2. When card is inserted, switch to 30 s timeout. The card removal
> will be detected anyway when a blk err occurs, due to that
> mmc_detect_card_removed will be called from the block layer at error
> handling path.
>

Ulf,

Sounds good! But I have one concern:
If the card is removed when there is no i/o access. Then the
mmc_rescan won't run until 30 seconds later (just imagine the worst
case). If within 30 seconds, the card is inserted again or another
different card is inserted, then issue may occur.

Then I have a suggestion as below:
1. keep current code as 1 second in mmc_rescan for polling.
2. When an i/o request come, we can cancel current delay work and
reschedule the delay detect work after 1 second from that point.
3. If next i/o request come within 1 second, we can reschedule the
detect work after 1 second from that point again.

So during continuous i/o operations, there will be no mmc_rescan execution.
Once i/o operation stopped, the mmc_rescan will be called every 1 second.
This way can solve above issue.
How do you think?

Thanks
Kevin

> Any thoughts?
>
> Kind regards
> Ulf Hansson
