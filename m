From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: mmc: mxs: DEADLOCK
Date: Wed, 11 Jul 2012 14:06:09 +0800
Message-ID: <20120711060607.GE14060@S2101-09.ap.freescale.net>
References: <4FFC367A.8020100@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4FFC367A.8020100@bluegiga.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Marek Vasut <marex@denx.de>, Koen Beel <koen.beel@barco.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 10, 2012 at 05:04:42PM +0300, Lauri Hintsala wrote:
> Hi,
> 
> I was able to get deadlock with CONFIG_DEBUG_SPINLOCK enabled. I
> added also CONFIG_PROVE_LOCKING to get more verbose output. I got
> following error message after SDIO device has been powered.
> 
> I'm able to replicate issue with Linux next-20120710. Platform is imx28.
> 
The bug is there probably because the driver hasn't been widely tested
on SDIO card.

> I found a way to fix this issue:
> 
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int
> irq, void *dev_id)
>  	writel(stat & MXS_MMC_IRQ_BITS,
>  	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);
> 
> +	spin_unlock(&host->lock);
> +
>  	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
>  		mmc_signal_sdio_irq(host->mmc);
> 
> -	spin_unlock(&host->lock);
> -
>  	if (stat & BM_SSP_CTRL1_RESP_TIMEOUT_IRQ)
>  		cmd->error = -ETIMEDOUT;
>  	else if (stat & BM_SSP_CTRL1_RESP_ERR_IRQ)
> 
> 
> Is there any reason to keep mmc_signal_sdio_irq inside the spinlock?
> mmc_signal_sdio_irq calls mxs_mmc_enable_sdio_irq and it tries to
> acquire lock while it is already acquired.
> 
The fix looks right to me.  You can have my ack when you send a patch
for it.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
