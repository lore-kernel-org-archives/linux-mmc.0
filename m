From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v5 03/13] mmc: provide a standard MMC device-tree binding
 parser centrally
Date: Mon, 18 Feb 2013 09:54:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302180953140.4526@axis700.grange>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
 <1360941242-18153-4-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1302161613450.20044@axis700.grange> <20130216165825.GF1906@pengutronix.de>
 <20130217075216.GA3871@verge.net.au> <20130217075805.GB3871@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65194 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756705Ab3BRIy0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 03:54:26 -0500
In-Reply-To: <20130217075805.GB3871@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Markus Pargmann <mpa@pengutronix.de>

On Sun, 17 Feb 2013, Simon Horman wrote:

> On Sun, Feb 17, 2013 at 04:52:16PM +0900, Simon Horman wrote:
> > On Sat, Feb 16, 2013 at 05:58:25PM +0100, Sascha Hauer wrote:
> > > Hi Guennadi,
> > > 
> > > On Sat, Feb 16, 2013 at 04:21:16PM +0100, Guennadi Liakhovetski wrote:
> > > > MMC defines a number of standard DT bindings. Having each driver parse
> > > > them individually adds code redundancy and is error prone. Provide a
> > > > standard function to unify the parsing. After all drivers are converted
> > > > to using it instead of their own parsers, this function can be integrated
> > > > into mmc_alloc_host().
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > ---
> > > > 
> > > > v5:
> > > > 
> > > > 1. fix an uninitialised variable warning. Note, I don't actually know, 
> > > > whether this will fix the error, reported by the kbuild test robot. None 
> > > > of my compilers reports an error there, at most, I've got a warning with 
> > > > one of them, and, surprisingly, it is gone after this change. 
> > > > Surprisingly, because I only add the bus_width initialisation in the error 
> > > > case - exactly as it actually has to be done. In the success case it is 
> > > > assigned set by the function. But the compiler cannot know that!
> > > 
> > > Maybe the build robot builds with devicetree disabled? In this case
> > > of_property_read_u32_array expands to a static inline function and the
> > > compiler indeed knows that &bus_width is unitialized. It also knows that
> > > this function always returns an error, so what you did below should
> > > silence the compiler.
> > 
> > It seems so. The configuration that flagged the error was atngw100_defconfig.
> > 
> > ARCH=avr32 make atngw100_defconfig
> > grep USE_OF .config
> > [nothing]
> 
> In that vein I managed to reproduce the warning using ap4evb_defconfig
> and then enabled MMC. I have also verified that v5 does not produce
> the same warning.
> 
> I chose this as I don't have a avr32 cross-compile environment
> but I do have one for ARM and I know that ap4evb doesn't use DT.
> 
> I will update topic/mmc with v5.

Very good, thanks! So, this way I think, v5 should be ok.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
