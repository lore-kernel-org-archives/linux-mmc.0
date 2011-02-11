From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 07:14:18 +0800
Message-ID: <20110211231417.GC9289@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<201102042126.52701.arnd@arndb.de>
	<20110211003533.GA9151@S2100-06.ap.freescale.net>
	<201102101817.42099.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201102101817.42099.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 10, 2011 at 06:17:41PM +0100, Arnd Bergmann wrote:
> On Friday 11 February 2011, Shawn Guo wrote:
> > 
> > > > +	struct mxs_dma_data		dma_data;
> > > 
> > > Why do you need host specific DMA structures? Please stick to
> > > the generic dma-engine API if possible.
> > > 
> > I'm sticking to the generic dmaengine api.  The mxs dma hardware
> > has separate irq line for every single dma channel, which needs to
> > be told by client driver.
> 
> I'm not convinced, it still sounds like a layering violation to
> have specific information about the DMA controller in the
> platform data of a driver using the dma engine API.
> 
It sounds like something about the dma controller, but it really
belongs to dma client device e.g. ssp here.  Every single dma client
device has two dma related resources, dma channel and dma irq, which
should be defined in client device data.

> Why can't you put the interrupt number into the platform data of
> the dma engine device? Your filter function already identifies
> the number of the DMA channel.
> 
We have 16 channels for dma-apbh and dma-apbx respectively.  And each
channel has fixed peripheral device and irq.  You think we can define
2 x 16 x (channel number + channel irq) in dma engine driver?  I'm
afraid not.  The channel number can be identified in filter function
because dmaengine core code and mxs dma hw are indexing the channel
in the same way, so that the sw channel id can be used to address hw
channel, otherwise we have to pass hw channel id to dma driver just
like what we do with irq.

> > > > +static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
> > > > +{
> > > > +	struct mxs_mmc_host *host = dev_id;
> > > > +	u32 stat;
> > > > +
> > > > +	stat = __raw_readl(host->base + HW_SSP_CTRL1);
> > > > +	__mxs_clrl(stat & MXS_MMC_IRQ_BITS, host->base + HW_SSP_CTRL1);
> > > > +
> > > > +	if (host->cmd && (stat & MXS_MMC_ERR_BITS))
> > > > +		host->status = __raw_readl(host->base + HW_SSP_STATUS);
> > > > +
> > > > +	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> > > > +		mmc_signal_sdio_irq(host->mmc);
> > > > +
> > > > +	return IRQ_HANDLED;
> > > > +}
> > > 
> > > You use spin_lock_irqsave in mxs_mmc_enable_sdio_irq, but don't
> > > actually use the spinlock in the interrupt handler. This means
> > > that either your interrupt handler is broken because it doesn't
> > > lock, or that you don't actually need the _irqsave part.
> > > 
> > I do not understand this one.  I'm seeing mxcmmc and pxamci use
> > spin_lock_irqsave/irqrestore in the similar way.
> 
> The difference is that e.g. mxcmci_irq() takes the spinlock that is
> used to protect the host->use_sdio flag, serializing the the
> code that initializes sdio with the code that uses it.
> 
> [Actually, mxcmci_irq() also looks wrong, because it releases the
> spinlock before calling mmc_signal_sdio_irq(), so sdio may be
> disabled by then, but that is a slightly different bug]
> 
> What I meant is that you take care to avoid getting into the
> interrupt handler while holding the spinlock, but in the handler,
> you don't check if the lock is held. It can't be correct to
> serialize just half the cases.
> 
Thanks for the explanation.  Please help review the fix below to see
if I understand the comment correctly.

        if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN)) {
                spin_lock_irqsave(&host->lock, flags);
                mmc_signal_sdio_irq(host->mmc);
                spin_unlock_irqrestore(&host->lock, flags);
        }

Regards,
Shawn
