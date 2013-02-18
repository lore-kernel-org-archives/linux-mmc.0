From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v4 13/13] mmc: tmio: add barriers to IO operations
Date: Mon, 18 Feb 2013 16:56:09 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302181614070.4526@axis700.grange>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
 <1360941242-18153-14-git-send-email-g.liakhovetski@gmx.de>
 <201302181505.58118.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201302181505.58118.arnd@arndb.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Arnd

On Mon, 18 Feb 2013, Arnd Bergmann wrote:

> On Friday 15 February 2013, Guennadi Liakhovetski wrote:
> > Without barriers SDIO operations fail with runtime PM enabled.
> 
> I don't understand how the changeset comment relates to the patch.
> 
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > index d857f5c..a10ebd0 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -159,19 +159,20 @@ int tmio_mmc_host_runtime_resume(struct device *dev);
> >  
> >  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
> >  {
> > -	return readw(host->ctl + (addr << host->bus_shift));
> > +	return ioread16(host->ctl + (addr << host->bus_shift));
> >  }
> >  
> 
> As far as I know, all architectures are required to have the same barrier
> semantics on readw and ioread16. The only difference between the two is
> that ioread16 must be able top operate on an __iomem token returned by
> ioport_map() or pci_iomap, which readw does not have to, but does on ARM.

Indeed, the real difference are the barriers in repeated IO operations.

> >  static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
> >  		u16 *buf, int count)
> >  {
> > -	readsw(host->ctl + (addr << host->bus_shift), buf, count);
> > +	wmb();
> > +	ioread16_rep(host->ctl + (addr << host->bus_shift), buf, count);
> >  }
> 
> Same thing here: both readsw and ioread16_rep are supposed to do the same
> thing, and I would assume that they should also include that barrier.
> For some reason I don't understand, they do not have the barrier on
> ARM at the moment, but I cannot say whether that is intentional or not.
> 
> Maybe Russell can comment on this.
> 
> Also, should the barrier not be /after/ the MMIO read, rather than before it?
> Typically the barrier should ensure that any read from memory after an
> MMIO read reflects the memory contents after any DMA is complete that
> the MMIO read has already claimed to be done.

Errors, that I've been observing were happening with no DMA, in pure PIO 
mode.

Unfortunately, I don't have a good explanation, why the barriers _have_ to 
be there, where I put them. At some point during my testing, I had 
printk()s in the code and SDIO worked. Then the classical - remove 
printk()s - stops working. Delays didn't halp, but barriers did. The 
motivation to put a write barrier before a (repeated) read was to wait for 
completion of any write operations before starting a read. And indeed, 
normal write operations, like writew() / iowrite16() have a write barrier 
_before_ the write. So, isn't it possible, that the last write hasn't 
completed yet, while we begin with reading? But reads / writes should, 
probably, anyway be serialised on the bus...

It's also possible, that these errors are related to runtime 
power-management, which would involve IO to other SoC peripherals. But 
they all should also contain barriers, so, this doesn't explain it 
immediately either.

Thanks
Guennadi

> >  static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
> >  		u16 *buf, int count)
> >  {
> > -	writesw(host->ctl + (addr << host->bus_shift), buf, count);
> > +	iowrite16_rep(host->ctl + (addr << host->bus_shift), buf, count);
> > +	wmb();
> >  }
> 
> Similarly here: why do you have the wmb after the iowrite rather than before it?
> 
> 	Arnd
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
