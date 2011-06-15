From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
 write_protect support for mx5
Date: Wed, 15 Jun 2011 11:10:00 +0800
Message-ID: <20110615030959.GA31191@S2100-06.ap.freescale.net>
References: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
 <1308034059-4014-1-git-send-email-shawn.guo@linaro.org>
 <20110614095129.GD5043@pengutronix.de>
 <20110614130610.GH30295@S2100-06.ap.freescale.net>
 <20110614135520.GH5043@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:53177 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab1FODEd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 23:04:33 -0400
Content-Disposition: inline
In-Reply-To: <20110614135520.GH5043@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Eric Benard <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, Jun 14, 2011 at 03:55:20PM +0200, Wolfram Sang wrote:
> 
> > important issue needs to be fixed in the release.  Please find some
> > time to do a full review, if possible.  We need your ack to know if
> > the patch stands :)  
> 
> Huh, my ack is needed for the linaro-kernel? :) Isn't it possible to
> replace a V1 patch with a V2 patch in later kernels?
> 
The linaro-kernel tree only accepts patches that have been on upstream
or are on the way to upstream (sitting on 'next' is a good proving).
Also since we are touching sdhci.c a little bit, it should be good for
us to get the patch on 'next' as early as we can, so that people can
start testing it.

Anyway, I will post v2 shortly.  Please help do a full review if
possible.  I'd appreciate it.

> > > > diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
> > > > index 86003f4..fced348 100644
> > > > --- a/arch/arm/plat-mxc/include/mach/esdhc.h
> > > > +++ b/arch/arm/plat-mxc/include/mach/esdhc.h
> > > > @@ -10,17 +10,32 @@
> > > >  #ifndef __ASM_ARCH_IMX_ESDHC_H
> > > >  #define __ASM_ARCH_IMX_ESDHC_H
> > > >  
> > > > +enum wp_types {
> > > > +	ESDHC_WP_NONE,		/* no WP, neither signal nor gpio */
> > > > +	ESDHC_WP_SIGNAL,	/* mmc internal WP signal */
> > > 
> > > I think SIGNAL is not descriptive enough. Maybe
> > > 
> > We have the document telling it's internal.
> > 
> > > ESDHC_WP_INTERNAL		/* WP routed directly to mmc controller */
> > > 
> > I thought about that.  If we use ESDHC_WP_INTERNAL, ESDHC_WP_GPIO
> > should probably be the ESDHC_WP_EXTERNAL for the couple naming.  But
> > I like ESDHC_WP_GPIO over ESDHC_WP_EXTERNAL, so chose the couple
> > naming of ESDHC_WP_GPIO vs. ESDHC_WP_SIGNAL.
> 
> ESDHC_WP_CONTROLLER? Or ESDHC_WP_CORE?
> 
Ok, going ESDHC_WP_CONTROLLER

> > > ? It should be mentioned on which SoCs this is not available?
> > > 
> > From SoC/controller POV, it's all available.  It's really a board
> > design choice to connect card CD/WP to the pads or not, which the
> > controller CD/WP signal/function is available on.
> 
> For mx25/35, I tried to find muxer settings but couldn't find them. It
> seemed to me, GPIO is the only option there (I think I even asked
> Richard). Can you route them on mx25/35, too?
> 
Sorry for confusion here.  It's all available from eSDHC controller
POV.  But no, it's not available on mx25/35 from SoC pinmux POV.  So
you are right.

-- 
Regards,
Shawn

