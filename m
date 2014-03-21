From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v9 resend 1/3] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Fri, 21 Mar 2014 21:40:49 +0530
Message-ID: <532C6489.4050307@ti.com>
References: <1395404448-30030-1-git-send-email-afenkart@gmail.com> <1395404448-30030-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday 21 March 2014 05:50 PM, Andreas Fenkart wrote:

Thanks Andreas for the patch series

I rebased against latest mmc-next, made few changes to your patch.
I have hosted your series along with devm cleanups on a branch[1] for testing
[1]
git://git.ti.com/~balajitk/ti-linux-kernel/omap-hsmmc.git omap_hsmmc_sdio_irq_devm_cleanup

Can you please test on your platform and provide feedback.

Details about the changes below.

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> @@ -1088,6 +1113,45 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>
> +static inline void hsmmc_enable_wake_irq(struct omap_hsmmc_host *host)
> +{
> +	unsigned long flags;
> +
> +	if (!host->wake_irq)
> +		return;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +	enable_irq(host->wake_irq);
> +	host->wake_irq_en = true;

Using wake_irq_en flag leads to wake_irq enabled always after
suspend/resume due to unbalanced disable/enable_irq
so adding back HSMMC_WAKE_IRQ_ENABLED to host->flags

> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +}
> +
> +static inline void hsmmc_disable_wake_irq(struct omap_hsmmc_host *host)
> +{
> +	unsigned long flags;
> +
> +	if (!host->wake_irq)
> +		return;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +	if (host->wake_irq_en)
> +		disable_irq_nosync(host->wake_irq);
> +	host->wake_irq_en = false;
> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +}
> +
> +static irqreturn_t omap_hsmmc_wake_irq(int irq, void *dev_id)
> +{
> +	struct omap_hsmmc_host *host = dev_id;
> +
> +	/* cirq is level triggered, disable to avoid infinite loop */
> +	hsmmc_disable_wake_irq(host);
> +
> +	pm_request_resume(host->dev); /* no use counter */
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static void set_sd_bus_power(struct omap_hsmmc_host *host)
>   {
>   	unsigned long i;
> @@ -1591,6 +1655,72 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>   		mmc_slot(host).init_card(card);
>   }
>
> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct omap_hsmmc_host *host = mmc_priv(mmc);
> +	u32 irq_mask;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +

Introduced check for runtime suspend to be sure and explicitly
enable clocks using runtime_get_sync for enable sdio irq path.

> +	irq_mask = OMAP_HSMMC_READ(host->base, ISE);
> +	if (enable) {
> +		host->flags |= HSMMC_SDIO_IRQ_ENABLED;
> +		irq_mask |= CIRQ_EN;
> +	} else {
> +		host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
> +		irq_mask &= ~CIRQ_EN;
> +	}
> +	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
> +
> +	/*
> +	 * if enable, piggy back detection on current request
> +	 * but always disable immediately
> +	 */
> +	if (!host->req_in_progress || !enable)
> +		OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
> +
> +	/* flush posted write */
> +	OMAP_HSMMC_READ(host->base, IE);
> +
> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +}
> +
> +static int omap_hscmm_configure_wake_irq(struct omap_hsmmc_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	int ret;
> +
> +	/*
> +	 * The wake-irq is needed for omaps with wake-up path and also
> +	 * when doing GPIO remuxing, because omap_hsmmc is doing runtime PM.
> +	 * So there's nothing stopping from shutting it down. And there's
> +	 * really no need to block runtime PM for it as it's working.
> +	 */
> +	if (!host->dev->of_node || !host->wake_irq)
> +		return -ENODEV;
> +
> +	/* Prevent auto-enabling of IRQ */
> +	irq_set_status_flags(host->wake_irq, IRQ_NOAUTOEN);
> +	ret = request_irq(host->wake_irq, omap_hsmmc_wake_irq,
> +			  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +			  mmc_hostname(mmc), host);

Replaced request_irq with devm_request_irq

> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc),
> +			"Unable to request wake IRQ\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Some omaps don't have wake-up path from deeper idle states
> +	 * and need to remux SDIO DAT1 to GPIO for wake-up from idle.
> +	 */
> +	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING)
> +		host->flags |= HSMMC_SWAKEUP_QUIRK;
> +
> +	return 0;
> +}
> +
>   static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>   {
>   	u32 hctl, capa, value;
> @@ -1643,7 +1773,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>   	.get_cd = omap_hsmmc_get_cd,
>   	.get_ro = omap_hsmmc_get_ro,
>   	.init_card = omap_hsmmc_init_card,
> -	/* NYET -- enable_sdio_irq */
> +	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>   };
>
>   #ifdef CONFIG_DEBUG_FS
> @@ -1704,8 +1834,19 @@ static void omap_hsmmc_debugfs(struct mmc_host *mmc)
>
>   #endif
>
> +struct of_data {
> +	u16 offset;
> +	int flags;
> +};
> +
>   #ifdef CONFIG_OF
> -static u16 omap4_reg_offset = 0x100;
> +static struct of_data omap4_data = {
> +	.offset	= 0x100,
> +};
> +static struct of_data am33xx_data = {
> +	.offset	= 0x100,
> +	.flags	= OMAP_HSMMC_SWAKEUP_MISSING,
> +};
>
>   static const struct of_device_id omap_mmc_of_match[] = {
>   	{
> @@ -1716,7 +1857,11 @@ static const struct of_device_id omap_mmc_of_match[] = {
>   	},
>   	{
>   		.compatible = "ti,omap4-hsmmc",
> -		.data = &omap4_reg_offset,
> +		.data = &omap4_data,
> +	},
> +	{
> +		.compatible = "ti,am33xx-hsmmc",
> +		.data = &am33xx_data,
>   	},
>   	{},
>   };
> @@ -1779,6 +1924,7 @@ static inline struct omap_mmc_platform_data
>   {
>   	return NULL;
>   }
> +#define omap_mmc_of_match	NULL
>   #endif
>
>   static int omap_hsmmc_probe(struct platform_device *pdev)
> @@ -1787,7 +1933,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   	struct mmc_host *mmc;
>   	struct omap_hsmmc_host *host = NULL;
>   	struct resource *res;
> -	int ret, irq;
> +	int ret, irq, _wake_irq = 0;
>   	const struct of_device_id *match;
>   	dma_cap_mask_t mask;
>   	unsigned tx_req, rx_req;
> @@ -1801,8 +1947,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   			return PTR_ERR(pdata);
>
>   		if (match->data) {
> -			const u16 *offsetp = match->data;
> -			pdata->reg_offset = *offsetp;
> +			const struct of_data *d = match->data;
> +			pdata->reg_offset = d->offset;
> +			pdata->controller_flags |= d->flags;
>   		}
>   	}
>
> @@ -1821,6 +1968,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   	if (res == NULL || irq < 0)
>   		return -ENXIO;
>
> +	if (pdev->dev.of_node)
> +		_wake_irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
> +

Moved this code further down to remove _wake_irq

>   	res = request_mem_region(res->start, resource_size(res), pdev->name);
>   	if (res == NULL)
>   		return -EBUSY;
> @@ -1842,6 +1992,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   	host->use_dma	= 1;
>   	host->dma_ch	= -1;
>   	host->irq	= irq;
> +	host->wake_irq = _wake_irq;
>   	host->slot_id	= 0;
>   	host->mapbase	= res->start + pdata->reg_offset;
>   	host->base	= ioremap(host->mapbase, SZ_4K);
> @@ -2018,6 +2169,18 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   		dev_warn(&pdev->dev,
>   			"pins are not configured from the driver\n");
>
> +	/*
> +	 * For now, only support SDIO interrupt if we have a separate
> +	 * wake-up interrupt configured from device tree. This is because
> +	 * the wake-up interrupt is needed for idle state and some
> +	 * platforms need special quirks. And we don't want to add new
> +	 * legacy mux platform init code callbacks any longer as we
> +	 * are moving to DT based booting anyways.
> +	 */
> +	ret = omap_hscmm_configure_wake_irq(host);

fixed the typo in hsmmc :-)

> +	if (!ret)
> +		mmc->caps |= MMC_CAP_SDIO_IRQ;
> +
>   	omap_hsmmc_protect_card(host);
>
>   	mmc_add_host(mmc);
> @@ -2042,7 +2205,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>
>   err_slot_name:
>   	mmc_remove_host(mmc);
> -	free_irq(mmc_slot(host).card_detect_irq, host);
> +	if (host->wake_irq)
> +		free_irq(host->wake_irq, host);
> +	if (mmc_slot(host).card_detect_irq)
> +		free_irq(mmc_slot(host).card_detect_irq, host);
>   err_irq_cd:
>   	if (host->use_reg)
>   		omap_hsmmc_reg_put(host);
> @@ -2087,6 +2253,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>   	if (host->pdata->cleanup)
>   		host->pdata->cleanup(&pdev->dev);
>   	free_irq(host->irq, host);
> +	if (host->wake_irq)
> +		free_irq(host->wake_irq, host);
>   	if (mmc_slot(host).card_detect_irq)
>   		free_irq(mmc_slot(host).card_detect_irq, host);
>
> @@ -2149,6 +2317,8 @@ static int omap_hsmmc_suspend(struct device *dev)
>   				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
>   	}
>
> +	hsmmc_disable_wake_irq(host);
> +

Made disable/enable_wake_irq conditional on MMC_PM_WAKE_SDIO_IRQ cap

>   	if (host->dbclk)
>   		clk_disable_unprepare(host->dbclk);
>
> @@ -2176,6 +2346,8 @@ static int omap_hsmmc_resume(struct device *dev)
>
>   	omap_hsmmc_protect_card(host);
>
> +	hsmmc_enable_wake_irq(host);
> +
>   	pm_runtime_mark_last_busy(host->dev);
>   	pm_runtime_put_autosuspend(host->dev);
>   	return 0;
> @@ -2191,23 +2363,38 @@ static int omap_hsmmc_resume(struct device *dev)
>   static int omap_hsmmc_runtime_suspend(struct device *dev)
>   {
>   	struct omap_hsmmc_host *host;
> +	int ret = 0;
>
>   	host = platform_get_drvdata(to_platform_device(dev));
>   	omap_hsmmc_context_save(host);
>   	dev_dbg(dev, "disabled\n");
>
> -	return 0;
> +	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
> +		OMAP_HSMMC_WRITE(host->base, ISE, 0);
> +		OMAP_HSMMC_WRITE(host->base, IE, 0);
> +		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +		hsmmc_enable_wake_irq(host);

here too.

> +	}
> +
> +	return ret;
>   }
>
>   static int omap_hsmmc_runtime_resume(struct device *dev)
>   {
>   	struct omap_hsmmc_host *host;
> +	int ret = 0;
>
>   	host = platform_get_drvdata(to_platform_device(dev));
>   	omap_hsmmc_context_restore(host);
>   	dev_dbg(dev, "enabled\n");
>
> -	return 0;
> +	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {

This leads to unconditional re-enabling sdio_irq/wake_irq
on next runtime resume, so replaced the check with HSMMC_SDIO_IRQ_ENABLED

> +		hsmmc_disable_wake_irq(host);
> +		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +		OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
> +		OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
> +	}
> +	return ret;
>   }
>
>   static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
> diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
> index 2bf1b30..51e70cf 100644
> --- a/include/linux/platform_data/mmc-omap.h
> +++ b/include/linux/platform_data/mmc-omap.h
> @@ -28,6 +28,7 @@
>    */
>   #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
>   #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
> +#define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
>
>   struct mmc_card;
>
>

