From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 4 Feb 2013 22:11:46 +0100
Message-ID: <CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com>
References: <510C2A47.1090607@mvista.com>
	<20130201205600.GA31762@arwen.pp.htv.fi>
	<20130201213003.GW2637@n2100.arm.linux.org.uk>
	<20130204154153.GA18237@arwen.pp.htv.fi>
	<510FF1A6.403@mvista.com>
	<20130204164712.GB4269@arwen.pp.htv.fi>
	<510FF5C9.3030600@mvista.com>
	<20130204170216.GC4269@arwen.pp.htv.fi>
	<51100A72.6030909@ti.com>
	<CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
	<20130204203358.GX4720@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36112 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab3BDVLr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Feb 2013 16:11:47 -0500
Received: by mail-ie0-f177.google.com with SMTP id 16so6408124iea.36
        for <linux-mmc@vger.kernel.org>; Mon, 04 Feb 2013 13:11:46 -0800 (PST)
In-Reply-To: <20130204203358.GX4720@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cyril Chemparathy <cyril@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, balbi@ti.com, Sergei Shtylyov <sshtylyov@mvista.com>, Linux Documentation List <linux-doc@vger.kernel.org>, Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, "Nair, Sandeep" <sandeep_n@ti.com>, Chris Ball <cjb@laptop.org>, Matt Porter <mporter@ti.com>, Arnd Bergmann <arnd@arndb.de>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Linux OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Landley <rob@landley.net>, Dan Williams <djbw@fb.com>Linux

On Mon, Feb 4, 2013 at 9:33 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Feb 04, 2013 at 09:29:46PM +0100, Linus Walleij wrote:
>> On Mon, Feb 4, 2013 at 8:22 PM, Cyril Chemparathy <cyril@ti.com> wrote:
>
>> > Based on our experience with fitting multiple subsystems on top of this
>> > DMA-Engine driver, I must say that the DMA-Engine interface has proven
>> > to be a less than ideal fit for the network driver use case.
>
>> > The first problem is that the DMA-Engine interface expects to "push"
>> > completed traffic up into the upper layer as a part of its callback.
>> > This doesn't fit cleanly with NAPI, which expects to "pull" completed
>> > traffic from below in the NAPI poll.  We've somehow kludged together a
>> > solution around this, but it isn't very elegant.
>
>> I cannot understand the actual technical problem from the above
>> paragraphs though. dmaengine doesn't have a concept of pushing
>> nor polling, it basically copies streams of words from A to B, where
>> A/B can be a device or a buffer, nothing else.
>
>> The thing you're looking for sounds more like an adapter on top
>> of dmaengine, which can surely be constructed, some
>> drivers/dma/dmaengine-napi.c or whatever.
>
> Broadly speaking what NAPI wants is to never get any callbacks from the
> hardware (or DMAs).  It wants to wake up periodically, take a look at
> what packets have been read by the hardware and process them.  The goal
> is to have the DMAs sitting and running without disturbing the processor
> at all after the first packet has been handled.

OK we should definately be able to encompass that in dmaengine
quite easily.

So I think the above concerns are moot. The callback we can
set on cookies is entirely optional, and it's even implemented by
each DMA engine, and some may not even support it but *require*
polling, and then it won't even be implemented by the driver.

Which probably stems from the original design of the dmaengine
API, which was for TCP networking acceleration, mainly.

Cyril, just stack up the cookies and take a sweep over them to see
which ones are baked when the NAPI poll comes in -> problem
solved.

Yours,
Linus Walleij
