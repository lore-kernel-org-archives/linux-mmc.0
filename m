From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: sdhci-esdhc-imx -- MMC 10x slower than it should be
Date: Wed, 15 Jun 2011 19:24:34 +0800
Message-ID: <20110615112433.GB3579@S2100-06.ap.freescale.net>
References: <20110615094001.GA21137@pma.sysgo.com>
 <20110615105318.GB3097@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:6104
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754312Ab1FOLTI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 07:19:08 -0400
Content-Disposition: inline
In-Reply-To: <20110615105318.GB3097@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Pavel Machek <pma@sysgo.com>, linux-mmc@vger.kernel.org, pba@sysgo.com, cjb@laptop.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Wed, Jun 15, 2011 at 12:53:18PM +0200, Wolfram Sang wrote:
> Hi,
> 
> > We are seeing issues with sdhci-esdhc-imx in 2.6.39; performance is
> > not what it should be; it is about 10x lower in fact.
> 
> Which SoC? 25/35/51/53?
> 
> > ...any idea what this comment means? I'd like to eventualy support
> > 8BITBUS...
> 
> 8-Bit bus is not specified in the standard, so it cannot be detected.
> Check other drivers where they use MMC_CAP_8_BIT_DATA.
> 
> > Part of the problem is that esdhc_writeb_le() does translation of bits
> > into breescale format; but readb() does not do translation back, and
> > core code uses read-modify-write on the register, for example when
> > turning on the LED. What to do there? Translate back? Add shadow
> > variable? Get rid of read-modify-write?
> 
> Probably the least ugly solution :/
> 
> > Any ideas why it is slow?
> 
> Your board polls for card-detect, Shawn recently sent a series which
> lets you fix that for mx5.
> 
> ADMA is marked broken in mainline, cause it didn't work with a number of
> cards. Richard sent a patch recently.
> 
The ADMA support is recently added into Freescale BSP.  IOW, the ADMA
does not play on kernel "2.6.34 -with-freescale-patches" either.

-- 
Regards,
Shawn

