From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Mon, 20 Jun 2011 22:40:13 +0900
Message-ID: <20110620134012.GC9325@verge.net.au>
References: <1308550015-15717-1-git-send-email-horms@verge.net.au>
 <1308550015-15717-4-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1106200823560.9989@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1106200823560.9989@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2011 at 08:29:18AM +0200, Guennadi Liakhovetski wrote:
> On Mon, 20 Jun 2011, Simon Horman wrote:
> 
> > Some controllers require waiting for the bus to become idle
> > before writing to some registers. I have implemented this
> > by adding a hook to sd_ctrl_write16() and implementing
> > a hook for SDHI which waits for the bus to become idle.
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > 
> > ---
> > 
> > Dependenvies: "mmc: tmio: Share register access functions"
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |   34 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/tmio_mmc.h       |    2 ++
> >  include/linux/mfd/tmio.h          |    8 ++++++++
> >  include/linux/mmc/tmio.h          |    1 +
> >  4 files changed, 45 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > index b365429..6c56453 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -27,6 +27,8 @@
> >  #include <linux/mfd/tmio.h>
> >  #include <linux/sh_dma.h>
> >  
> > +#include <asm/delay.h>
> 
> linux/delay.h

Thanks.

> > +
> >  #include "tmio_mmc.h"
> >  
> >  struct sh_mobile_sdhi {
> > @@ -55,6 +57,37 @@ static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
> >  		return -ENOSYS;
> >  }
> >  
> > +static void sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
> > +{
> > +	int timeout = 1000;
> > +
> > +	while (--timeout && !(sd_ctrl_read16(host, CTL_STATUS2) & (1 << 13)))
> > +		udelay(1);
> > +
> > +	if (!timeout)
> > +		dev_warn(host->pdata->dev, "timeout waiting for SD bus idle\n");
> > +
> > +}
> > +
> > +static void sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
> > +{
> > +	if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
> > +		return;
> > +
> > +	switch (addr)
> > +	{
> > +	case CTL_SD_CMD:
> > +	case CTL_STOP_INTERNAL_ACTION:
> > +	case CTL_XFER_BLK_COUNT:
> > +	case CTL_SD_CARD_CLK_CTL:
> > +	case CTL_SD_XFER_LEN:
> > +	case CTL_SD_MEM_CARD_OPT:
> > +	case CTL_TRANSACTION_CTL:
> > +	case CTL_DMA_ENABLE:
> > +		sh_mobile_sdhi_wait_idle(host);
> > +	}
> > +}
> > +
> >  static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
> >  {
> >  	struct sh_mobile_sdhi *priv;
> > @@ -86,6 +119,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
> >  	mmc_data->hclk = clk_get_rate(priv->clk);
> >  	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
> >  	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
> > +	mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
> 
> Not sure I like the "write16_hook" name. You consider this callback as 
> something the host might need to do, when writing to a 16-bit register. In 
> this specific case it is actually waiting for the bus to become idle, 
> which might also be needed in other locations. So, maybe it is better to 
> call this callback "wait_idle" or something similar? Or you think, other 
> hosts might need a write16 hook doing something different?...

I'm not strongly attached to the name, and I do see your point.  But as it
stands the hook is currently only needed on 16bit register writes; the hook
is called from sd_ctrl_write16(): and sh_mobile_sdhi_write16_hook() works
by looking at addr, which is specific to register reads and writes.  So
while it isn't great, I think the current name isn't entirely horrible.

I think its a little hard to look into a crystal ball and see
where other TMIO hardware might need wait_idle(). Who knows
what we might need to do for the next batch of hardware? :-)

I had considered other approaches to this problem, such as
calling something_wait_idle() from within tmio_mmc_*.c as needed.
But the approach in the patch I posted turned out to be quite
a lot cleaner and have the advantage of concisely documenting
what is being done - that is, writes to which registers need
wait_idle treatment.

The down side is that the callback is obviously more specific
than perhaps a hook ought to be. But I think that it can evolve
as the need arises.

