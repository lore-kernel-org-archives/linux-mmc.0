From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] MMC: error handling improvements
Date: Wed, 16 Feb 2011 22:01:52 +0100
Message-ID: <AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	<8ya8vxf4w4w.fsf@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35609 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab1BPVBx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 16:01:53 -0500
Received: by pxi15 with SMTP id 15so259701pxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 13:01:52 -0800 (PST)
In-Reply-To: <8ya8vxf4w4w.fsf@huya.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

2011/2/16 David Brown <davidb@codeaurora.org>:
> On Wed, Feb 16 2011, Linus Walleij wrote:
>> 2011/2/16 David Brown <davidb@codeaurora.org>:
>
>>> It's also possible this is finding problems in our SDCC driver.
>>
>> The SDCC is obviously an MMCI derivate, VHDL hacking
>> on top of ARMs source code for PL180/PL181.
>>
>> Why do you insist on maintaining a forked driver?
>
> Well, it's not me insisting on it. =A0I'll let the maintainers of the
> driver chime in.

Yeah OK. I tried writing them last week on linux-arm-kernel
with more or less the same question.

>=A0The driver doesn't directly
> access the registers of the controller, but all accesses go through a
> custom DMA engine.
> (...)
> The SDCC block is shared between
> the modem processor and the processor running Linux.  If the driver
> doesn't go through the DMA engine, which coordinates this, the regist=
ers
> will be stomped on by the other CPU whenever it decides to access it'=
s
> parts of the flash device.

That's significant, I agree. That the DMA engine is custom
instead of using the <linux/dmaengine.h> interface is not
making things easier, but it's another issue. If it did, I think it
could quite easily use mmci.c.

At the same time what you're saying sounds very weird:
the ios handler in mmc_sdcc does not request any DMA
channel before messing with the hardware, it simply just write
into registers very much in the style of mmci.c. Wouldn't that
disturb any simultaneous access to the MMC from another
CPU?

The DMA code path doesn't look one bit different from
what we currently do for the generic DMA engine in
mmci.c, it sets up a DMA job from the sglist in the datapath,
but maybe I'm not looking close enough?

> I suspect the changes to mmci would be fairly drastic.

I don't think so, but the changes to the DMA engine
(I guess mach-msm/dma.c) would potentially be pretty drastic,
apart from just moving the thing to drivers/dma.

Actually when I look at the code in msm_sdcc.c it looks
like some of the code we usually centralize into the
DMA engine (like the thing iterating over a sglist and
packing it into some custom struct called "box") is instead
spread out in the client drivers.

I just wanted to raise the issue because I see that the
msm_sdcc driver is trying to e.g. synchronize against
dataend signals and such stuff that we've worked with
recently in mmci.c, and I really think it would be in the
MSM platforms best interest to use this driver rather than
its own.

Yours,
Linus Walleij
