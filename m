From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Date: Wed, 07 Jan 2015 10:15:44 +0100
Message-ID: <1538016.zLWF4l4JFj@wuerfel>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com> <7306460.62PqiTEhxi@wuerfel> <87bnmbpa3c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60827 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbbAGJPt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jan 2015 04:15:49 -0500
In-Reply-To: <87bnmbpa3c.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Wednesday 07 January 2015 03:01:22 Kuninori Morimoto wrote:
> Hi Arnd
> 
> > dmaengine: shdma: use normal interface for passing slave id
> > 
> > The shmobile platform is one of only two users of the slave_id field
> > in dma_slave_config, which is incompatible with the way that the
> > dmaengine API normally works.
> > 
> > I've had a closer look at the existing code now and found that all
> > slave drivers that pass a slave_id in dma_slave_config for SH do that
> > right after passing the same ID into shdma_chan_filter, so we can just
> > rely on that. However, the various shdma drivers currently do not
> > remember the slave ID that was passed into the filter function when
> > used in non-DT mode and only check the value to find a matching channel,
> > unlike all other drivers.
> > 
> > There might still be drivers that are not part of the kernel that rely
> > on setting the slave_id to some other value, so to be on the safe side,
> > this adds another 'real_slave_id' field to shdma_chan that remembers
> > the ID and uses it when a driver passes a zero slave_id in dma_slave_config,
> > like most drivers do.
> > 
> > Eventually, the real_slave_id and slave_id fields should just get merged
> > into one field, but that requires other changes.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ----
> >  drivers/dma/sh/shdma-base.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++++-------------------
> >  drivers/mmc/host/sh_mmcif.c     |  4 +---
> >  drivers/mmc/host/tmio_mmc_dma.c |  4 ----
> >  drivers/mtd/nand/sh_flctl.c     |  2 --
> >  drivers/spi/spi-rspi.c          |  1 -
> >  drivers/spi/spi-sh-msiof.c      |  1 -
> >  include/linux/shdma-base.h      |  1 +
> >  7 files changed, 52 insertions(+), 31 deletions(-)
> (snip)
> > -     /* In the OF case the driver will get the slave ID from the DT */
> > -     cfg.slave_id = slave_id;
> >       cfg.direction = direction;
> 
> My other drivers are using slave_id
>  linux/sound/soc/sh/fsi.c
>  linux/sound/soc/sh/rcar/core.c

My mistake, I did a 'git grep' the linux/drivers but missed linux/sound/soc.
 
> I guess it should remove cfg.slave_id = xxx ?

Correct. I checked both drivers, and  they behave just like the ones
I included in my patch.

> Can you include these in this patch ?
> or I can do it as other patch

I was actually hoping that you could pick up my patch and send it as a
follow-up to your series once you have a working version. As I mentioned,
the driver changes to remove the slave_id assignment can be done either
together with the base patch or as a follow-up.

	Arnd
