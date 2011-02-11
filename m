From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Fri, 11 Feb 2011 08:35:34 +0800
Message-ID: <20110211003533.GA9151@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
	<201102042126.52701.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201102042126.52701.arnd@arndb.de>
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

Hi Arnd,

Sorry for the late response.  It really took me some time to address
your comments, especially about using mmc core completion to save
the one in the driver.

On Fri, Feb 04, 2011 at 09:26:52PM +0100, Arnd Bergmann wrote:
> On Saturday 05 February 2011 03:18:41 Shawn Guo wrote:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > The driver calls into mxs-dma via generic dmaengine api for both pio
> > and data transfer.
> 
> Hi Shawn,
> 
> The driver looks good coding-style wise, but it's my impression that
> you do some thing less efficient or more complex than necessary. To
> be more specific:

Thanks for the review and comments.

> 
> > +struct mxs_mmc_host {
> 
> It seems you have a number of members in this struct that only
> add confusion but are not actually needed, so just get rid of
> them:
> 
> > +	struct device			*dev;
> 
> mmc_host->parent ?
> 
OK.  Will replace all host->dev with mmc_dev(host->mmc) to save it.

> > +	struct resource			*res;
> > +	struct resource			*dma_res;
> > +	struct clk			*clk;
> 
> are visible in the parent.
> 
It seems this is a generally used approach, seen in mxcmmc and pxamci.

> > +	unsigned int			version;
> 
> unused
> 
#define ssp_is_old()		(host->version < SSP_VERSION_LATEST)

> > +	struct mmc_command		*cmd;
> 
> mrq->cmd ?
> 
Generally used approach again.

> > +	struct mmc_data			*data;
> 
> unused
> 
Will be used in v2.

> > +	unsigned			present:1;
> 
> Your card detection by polling through this variable is
> really bad for power management. Is there really no interrupt
> that gets triggered when installing or removing a card?
> 
Good point.  Will try to use interrupt.

> Also, please try to avoid bit fields. 'bool' variables are
> fine for flags.
> 
> > +	unsigned int			dma_dir;
> 
> not needed, a local variable would be just fine.
> 
Will be needed in v2.

> > +	struct mxs_dma_data		dma_data;
> 
> Why do you need host specific DMA structures? Please stick to
> the generic dma-engine API if possible.
> 
I'm sticking to the generic dmaengine api.  The mxs dma hardware
has separate irq line for every single dma channel, which needs to
be told by client driver.

> > +	struct completion 		done;
> 
> The mmc layer already comes with a generic completion that you
> can and should use, mainly for performance reasons. Adding your
> own completion forces every single request to go through an
> additional context switch, compared to just returning from
> the request function when you have scheduled the command, and
> calling mmc_request_done from the interrupt handler.
> 
I'm rewriting some amount of codes to address it.

> > +	u32				status;
> 
> Won't be needed any more when you complete the requests at
> interrupt time.
> 
Yes.

> > +#define SSP_PIO_NUM	3
> > +static u32 ssp_pio_words[SSP_PIO_NUM];
> 
> I don't think this is safe: This is a global variable, so if you have
> multiple controllers, they would access the same data. Why not integrate
> it into the host data structure?
> 
Sounds sane.

> > +
> > +static void mxs_mmc_reset(struct mxs_mmc_host *host)
> > +{
> > +	u32 ctrl0, ctrl1;
> > +
> > +	mxs_reset_block(host->base);
> > +
> > +	ctrl0 = BM_SSP_CTRL0_IGNORE_CRC;
> > +	ctrl1 = BF_SSP(0x3, SSP_CTRL1_SSP_MODE) |
> > +		BF_SSP(0x7, SSP_CTRL1_WORD_LENGTH) |
> > +		BM_SSP_CTRL1_DMA_ENABLE |
> > +		BM_SSP_CTRL1_POLARITY |
> > +		BM_SSP_CTRL1_RECV_TIMEOUT_IRQ_EN |
> > +		BM_SSP_CTRL1_DATA_CRC_IRQ_EN |
> > +		BM_SSP_CTRL1_DATA_TIMEOUT_IRQ_EN |
> > +		BM_SSP_CTRL1_RESP_TIMEOUT_IRQ_EN |
> > +		BM_SSP_CTRL1_RESP_ERR_IRQ_EN;
> > +
> > +	__raw_writel(BF_SSP(0xffff, SSP_TIMING_TIMEOUT) |
> > +		     BF_SSP(2, SSP_TIMING_CLOCK_DIVIDE) |
> > +		     BF_SSP(0, SSP_TIMING_CLOCK_RATE),
> > +		     host->base + HW_SSP_TIMING);
> 
> Please use proper MMIO accessors like writel() and readl() that
> are known to be safe here. The __raw_ variants are not really
> meant for device drivers, which can lead to very subtle bugs.
> 
OK.  __mxs_clrl/setl will also be replaced by writel with set/clr
register offset, so that code looks more consistent.

> > +static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
> > +{
> > +	struct mxs_mmc_host *host = dev_id;
> > +	u32 stat;
> > +
> > +	stat = __raw_readl(host->base + HW_SSP_CTRL1);
> > +	__mxs_clrl(stat & MXS_MMC_IRQ_BITS, host->base + HW_SSP_CTRL1);
> > +
> > +	if (host->cmd && (stat & MXS_MMC_ERR_BITS))
> > +		host->status = __raw_readl(host->base + HW_SSP_STATUS);
> > +
> > +	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> > +		mmc_signal_sdio_irq(host->mmc);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> You use spin_lock_irqsave in mxs_mmc_enable_sdio_irq, but don't
> actually use the spinlock in the interrupt handler. This means
> that either your interrupt handler is broken because it doesn't
> lock, or that you don't actually need the _irqsave part.
> 
I do not understand this one.  I'm seeing mxcmmc and pxamci use
spin_lock_irqsave/irqrestore in the similar way.

> > +static void mxs_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > +{
> > +	struct mxs_mmc_host *host = mmc_priv(mmc);
> > +
> > +	BUG_ON(host->mrq != NULL);
> > +
> > +	host->mrq = mrq;
> > +	mxs_mmc_start_cmd(host, mrq->cmd);
> > +
> > +	if (mrq->data && mrq->data->stop) {
> > +		dev_dbg(host->dev, "Stop opcode is %u\n",
> > +				mrq->data->stop->opcode);
> > +		mxs_mmc_start_cmd(host, mrq->data->stop);
> > +	}
> > +
> > +	host->mrq = NULL;
> > +	mmc_request_done(mmc, mrq);
> > +}
> 
> As mentioned above, the mmc_request_done() shouldn't really be needed here,
> it's more efficient to do it in the interrupt handler.
> 
OK.

Regards,
Shawn
