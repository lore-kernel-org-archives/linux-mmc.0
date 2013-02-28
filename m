From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 04/12] mmc: mxs-mmc: move to use generic DMA helper
Date: Thu, 28 Feb 2013 16:28:33 +0800
Message-ID: <20130228082831.GG26106@S2101-09.ap.freescale.net>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-5-git-send-email-shawn.guo@linaro.org>
 <201302272054.18829.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:10119
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752028Ab3B1I2e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Feb 2013 03:28:34 -0500
Content-Disposition: inline
In-Reply-To: <201302272054.18829.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Marek Vasut <marek.vasut@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Huang Shijie <b32955@freescale.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, Feb 27, 2013 at 08:54:18PM +0000, Arnd Bergmann wrote:
> On Wednesday 27 February 2013, Shawn Guo wrote:
> >  Required properties:
> >  - compatible: Should be "fsl,<chip>-mmc".  The supported chips include
> >    imx23 and imx28.
> > -- interrupts: Should contain ERROR and DMA interrupts
> > -- fsl,ssp-dma-channel: APBH DMA channel for the SSP
> > +- interrupts: Should contain ERROR interrupt number
> > +- dmas: DMA specifier, consisting of a phandle to DMA controller node
> > +  and SSP DMA channel ID.
> > +  Refer to dma.txt and fsl-mxs-dma.txt for details.
> 
> I wonder if we should leave support for old device trees files around,
> at least for a while. Your patch removes a lot of unnecessary code if
> we decide not to worry about backwards compatibility here, but I could
> imagine that we see a few surprises here.
> 
I'm less concerned by that at this point.  Though platform mxs has been
fully converted to device tree, device tree is still quite new for the
platform.  The incompatible device tree should be acceptable,
considering we have noticed that when adding the temporary DMA binding
for client devices.

/*
 * TODO: This is a temporary solution and should be changed
 * to use generic DMA binding later when the helper get in.
 */

Unless we have these TODO remarks leave in the tree forever, we will
break old device tree sooner or later anyway.  And I would have it
happen sooner than later.

And I would start thinking about maintaining the device tree
compatibility for mxs after generic DMA binding adoption.

> > +- dma-names: Must be "ssp".
> 
> I would prefer calling this "data" rather than "ssp". The name only
> has local significance in the ssp device, so calling the channel
> "ssp" seems wrong.
> 
Ok, will rename it per the use of the channel in the controller.

Shawn

