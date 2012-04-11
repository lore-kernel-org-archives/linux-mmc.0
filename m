From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: remove linux/blkdev.h include from host drivers
Date: Wed, 11 Apr 2012 18:52:23 +0200
Message-ID: <20120411165223.GP3852@pengutronix.de>
References: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
 <87ty0qs2fz.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50523 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418Ab2DKQwk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Apr 2012 12:52:40 -0400
Content-Disposition: inline
In-Reply-To: <87ty0qs2fz.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>

On Wed, Apr 11, 2012 at 11:39:12AM -0400, Chris Ball wrote:
> Hi Sascha, Wolfram,
> 
> On Tue, Apr 10 2012, Dmitry Artamonow wrote:
> > I've compile tested everything with and without CONFIG_BLOCK enabled,
> > except for imxmmc.c - this driver seems to be long time broken
> > (at least since the removal of mach-imx in 2.6.31 - see commit
> > 1341d34ffc296f98dc84876f35f3151525dc02a2 ) 
> 
> I can confirm that it no longer builds:
> 
> /home/cjb/git/mmc/drivers/mmc/host/imxmmc.c:32:26: fatal error: mach/imx-dma.h: No such file or directory
> 
> Should imxmmc simply be removed from drivers/mmc/host?  Do any of the
> more current i.MX MMC drivers support the same hardware?

It has long been on my todo list to remove this driver. The more recent
i.MX use the mxcmmc driver which is basically the same hardware but
without a bunch of bugs which made the older imxmmc driver unusable on
newer hardware. I can send a patch if you like.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
