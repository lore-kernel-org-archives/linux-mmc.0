From: Brian Swetland <swetland@google.com>
Subject: Re: [RFC] MMC: error handling improvements
Date: Wed, 16 Feb 2011 15:06:06 -0800
Message-ID: <AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	<8ya8vxf4w4w.fsf@huya.qualcomm.com>
	<AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:24484 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab1BPXGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 18:06:13 -0500
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p1GN69xo011040
	for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 15:06:10 -0800
Received: from gwj20 (gwj20.prod.google.com [10.200.10.20])
	by hpaq12.eem.corp.google.com with ESMTP id p1GN5dsk030870
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 15:06:08 -0800
Received: by gwj20 with SMTP id 20so851713gwj.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 15:06:08 -0800 (PST)
In-Reply-To: <AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: David Brown <davidb@codeaurora.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

On Wed, Feb 16, 2011 at 1:01 PM, Linus Walleij <linus.walleij@linaro.or=
g> wrote:
> 2011/2/16 David Brown <davidb@codeaurora.org>:
>>=C2=A0The driver doesn't directly
>> access the registers of the controller, but all accesses go through =
a
>> custom DMA engine.
>> (...)
>> The SDCC block is shared between
>> the modem processor and the processor running Linux. =C2=A0If the dr=
iver
>> doesn't go through the DMA engine, which coordinates this, the regis=
ters
>> will be stomped on by the other CPU whenever it decides to access it=
's
>> parts of the flash device.
>
> That's significant, I agree. That the DMA engine is custom
> instead of using the <linux/dmaengine.h> interface is not
> making things easier, but it's another issue. If it did, I think it
> could quite easily use mmci.c.
>
> At the same time what you're saying sounds very weird:
> the ios handler in mmc_sdcc does not request any DMA
> channel before messing with the hardware, it simply just write
> into registers very much in the style of mmci.c. Wouldn't that
> disturb any simultaneous access to the MMC from another
> CPU?

On MSM7x01,7x2x,8x50,8x55,7x30 the overall design involves both the
baseband cpu (running AMSS) and the apps cpu (running Linux) sharing a
single SDCC to read/write different partitions on NAND.

The way register access for the SDCC is synchronized between these two
cores is by using a locking primitive built into the MSM DMA
controller.  If you don't use this indirect access model (via DMA
transactions to the registers), you end up tripping over the baseband
or the other way 'round.  It's not fun.

Later Qualcomm chipsets move away from this model (yay) and that
should simplify things quite a bit.

Brian

>
> The DMA code path doesn't look one bit different from
> what we currently do for the generic DMA engine in
> mmci.c, it sets up a DMA job from the sglist in the datapath,
> but maybe I'm not looking close enough?
>
>> I suspect the changes to mmci would be fairly drastic.
>
> I don't think so, but the changes to the DMA engine
> (I guess mach-msm/dma.c) would potentially be pretty drastic,
> apart from just moving the thing to drivers/dma.
>
> Actually when I look at the code in msm_sdcc.c it looks
> like some of the code we usually centralize into the
> DMA engine (like the thing iterating over a sglist and
> packing it into some custom struct called "box") is instead
> spread out in the client drivers.
>
> I just wanted to raise the issue because I see that the
> msm_sdcc driver is trying to e.g. synchronize against
> dataend signals and such stuff that we've worked with
> recently in mmci.c, and I really think it would be in the
> MSM platforms best interest to use this driver rather than
> its own.
>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
