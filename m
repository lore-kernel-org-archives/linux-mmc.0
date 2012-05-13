From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 08/10] mmc: mxs-mmc: add device tree support
Date: Sat, 12 May 2012 20:11:48 -0400
Message-ID: <871ump0wjf.fsf@laptop.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
	<1336401793-13753-9-git-send-email-shawn.guo@linaro.org>
	<87k40h1msl.fsf@laptop.org>
	<20120513000302.GJ17875@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55670 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab2EMAMD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 May 2012 20:12:03 -0400
In-Reply-To: <20120513000302.GJ17875@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Sun, 13 May 2012 08:03:04 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Arnd Bergmann <arnd@arndb.de>

Hi, adding Arnd,

On Sat, May 12 2012, Shawn Guo wrote:
>> > diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
>> > new file mode 100644
>> > index 0000000..d7c2a40
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
>> > @@ -0,0 +1,26 @@
>> > +* Freescale MXS MMC controller
>> > +
>> > +The Freescale MXS Synchronous Serial Ports (SSP) can act as a MMC controller
>> > +to support MMC, SD, and SDIO types of memory cards.
>> > +
>> > +Required properties:
>> > +- compatible: Should be "fsl,<chip>-mmc".  The supported chips include
>> > +  imx23 and imx28.
>> > +- reg: Should contain registers location and length
>> > +- interrupts: Should contain ERROR and DMA interrupts
>> > +- fsl,ssp-dma-channel: APBH DMA channel for the SSP
>> > +- fsl,bus-width: Number of data lines, can be <1>, <4>, or <8>
>> 
>> Please don't use a prefix on "bus-width" -- see Arnd's proposed bindings:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/091993.html
>> 
> Yes, I've been keeping my eyes on the discussion.  Before that generic
> bindings get landed, the vendor prefix can be treated as a marker that
> this is something should use generic binding.

Sorry, I don't understand this explanation.  As soon as Arnd's patch
lands (possibly even for 3.5), we will be making sure that all of the
bindings are consistently using "bus-width" with no prefix -- that's
what Arnd's patch does to the existing .dts files.  Why introduce an
inconsistent binding now that we have to change later, instead of
getting it right straight away?

I'd like bindings going into mainline to be as correct as possible from
the moment that they're merged into mainline, because they describe an
API with the kernel.  The fact that we have some bindings currently in
the tree that we'll have to change to use the consistent naming scheme
Arnd proposes is regrettable, not intentional, so we shouldn't be
planning on doing more of it.  Does that make sense?

I'll take a look at merging Arnd's bindings patch and fixing up the
review comments on it now; it sounds like we really need to get it
merged and adopted very soon.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
