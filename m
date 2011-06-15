From: Pavel Machek <pma@sysgo.com>
Subject: Re: sdhci-esdhc-imx -- MMC 10x slower than it should be
Date: Wed, 15 Jun 2011 14:30:13 +0200
Message-ID: <20110615123013.GA29886@pma.sysgo.com>
References: <20110615094001.GA21137@pma.sysgo.com>
 <20110615105318.GB3097@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.sysgo.com ([195.145.229.155]:45872 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab1FOMaS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Jun 2011 08:30:18 -0400
Content-Disposition: inline
In-Reply-To: <20110615105318.GB3097@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, pba@sysgo.com, cjb@laptop.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com

Hi!

> > We are seeing issues with sdhci-esdhc-imx in 2.6.39; performance is
> > not what it should be; it is about 10x lower in fact.
> 
> Which SoC? 25/35/51/53?

It is on

Hardware        : Freescale MX25 3-Stack Board
Revision        : 25010

...so MX25 AFAICT.

> > Any ideas why it is slow?
> 
> Your board polls for card-detect, Shawn recently sent a series which
> lets you fix that for mx5.

Thanks, I'll check.
								Pavel
