From: boris brezillon <b.brezillon@overkiz.com>
Subject: Re: [PATCH v4 2/5] mmc: atmel-mci: prepare clk before calling enable
Date: Thu, 22 Aug 2013 11:41:12 +0200
Message-ID: <5215DCB8.3020502@overkiz.com>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com> <1374133132-17556-1-git-send-email-b.brezillon@overkiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374133132-17556-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Boris BREZILLON <b.brezillon@overkiz.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Chris,

Could you take this patch ?

It has been acked by Ludovic, and I need it in order to gracefully handle
at91's SoCs migration to common clk framework.

Thanks.

Best Regards,

Boris

On 18/07/2013 09:38, Boris BREZILLON wrote:
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>   drivers/mmc/host/atmel-mci.c |   34 +++++++++++++++++++++++++++-------
>   1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index bdb84da..69e438e 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -378,6 +378,8 @@ static int atmci_regs_show(struct seq_file *s, void *v)
>   {
>   	struct atmel_mci	*host = s->private;
>   	u32			*buf;
> +	int			ret = 0;
> +
>   
>   	buf = kmalloc(ATMCI_REGS_SIZE, GFP_KERNEL);
>   	if (!buf)
> @@ -388,12 +390,16 @@ static int atmci_regs_show(struct seq_file *s, void *v)
>   	 * not disabling interrupts, so IMR and SR may not be
>   	 * consistent.
>   	 */
> +	ret = clk_prepare_enable(host->mck);
> +	if (ret)
> +		goto out;
> +
>   	spin_lock_bh(&host->lock);
> -	clk_enable(host->mck);
>   	memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
> -	clk_disable(host->mck);
>   	spin_unlock_bh(&host->lock);
>   
> +	clk_disable_unprepare(host->mck);
> +
>   	seq_printf(s, "MR:\t0x%08x%s%s ",
>   			buf[ATMCI_MR / 4],
>   			buf[ATMCI_MR / 4] & ATMCI_MR_RDPROOF ? " RDPROOF" : "",
> @@ -442,9 +448,10 @@ static int atmci_regs_show(struct seq_file *s, void *v)
>   				val & ATMCI_CFG_LSYNC ? " LSYNC" : "");
>   	}
>   
> +out:
>   	kfree(buf);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int atmci_regs_open(struct inode *inode, struct file *file)
> @@ -1262,6 +1269,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   	struct atmel_mci_slot	*slot = mmc_priv(mmc);
>   	struct atmel_mci	*host = slot->host;
>   	unsigned int		i;
> +	bool			unprepare_clk;
>   
>   	slot->sdc_reg &= ~ATMCI_SDCBUS_MASK;
>   	switch (ios->bus_width) {
> @@ -1277,9 +1285,13 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   		unsigned int clock_min = ~0U;
>   		u32 clkdiv;
>   
> +		clk_prepare(host->mck);
> +		unprepare_clk = true;
> +
>   		spin_lock_bh(&host->lock);
>   		if (!host->mode_reg) {
>   			clk_enable(host->mck);
> +			unprepare_clk = false;
>   			atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
>   			atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
>   			if (host->caps.has_cfg_reg)
> @@ -1347,6 +1359,8 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   	} else {
>   		bool any_slot_active = false;
>   
> +		unprepare_clk = false;
> +
>   		spin_lock_bh(&host->lock);
>   		slot->clock = 0;
>   		for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
> @@ -1360,12 +1374,16 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   			if (host->mode_reg) {
>   				atmci_readl(host, ATMCI_MR);
>   				clk_disable(host->mck);
> +				unprepare_clk = true;
>   			}
>   			host->mode_reg = 0;
>   		}
>   		spin_unlock_bh(&host->lock);
>   	}
>   
> +	if (unprepare_clk)
> +		clk_unprepare(host->mck);
> +
>   	switch (ios->power_mode) {
>   	case MMC_POWER_UP:
>   		set_bit(ATMCI_CARD_NEED_INIT, &slot->flags);
> @@ -2376,10 +2394,12 @@ static int __init atmci_probe(struct platform_device *pdev)
>   	if (!host->regs)
>   		goto err_ioremap;
>   
> -	clk_enable(host->mck);
> +	ret = clk_prepare_enable(host->mck);
> +	if (ret)
> +		goto err_request_irq;
>   	atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
>   	host->bus_hz = clk_get_rate(host->mck);
> -	clk_disable(host->mck);
> +	clk_disable_unprepare(host->mck);
>   
>   	host->mapbase = regs->start;
>   
> @@ -2482,11 +2502,11 @@ static int __exit atmci_remove(struct platform_device *pdev)
>   			atmci_cleanup_slot(host->slot[i], i);
>   	}
>   
> -	clk_enable(host->mck);
> +	clk_prepare_enable(host->mck);
>   	atmci_writel(host, ATMCI_IDR, ~0UL);
>   	atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIDIS);
>   	atmci_readl(host, ATMCI_SR);
> -	clk_disable(host->mck);
> +	clk_disable_unprepare(host->mck);
>   
>   	if (host->dma.chan)
>   		dma_release_channel(host->dma.chan);
