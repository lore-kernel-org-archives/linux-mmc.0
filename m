From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 1/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Tue, 12 Nov 2013 22:52:38 +0530
Message-ID: <528263DE.2030001@ti.com>
References: <1384200405-8402-1-git-send-email-afenkart@gmail.com> <1384200405-8402-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1384200405-8402-2-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 12 November 2013 01:36 AM, Andreas Fenkart wrote:
> For now, only support SDIO interrupt if we are booted with
> DT. This is because some platforms need special quirks. And
> we don't want to add new legacy mux platform init code
> callbacks any longer as we are moving to DT based booting
> anyways.
>
> Broken hardware, missing the swakueup line, should fallback
> to polling, by setting 'ti,quirk-swakup-missing' in the
> device tree. Otherwise pending SDIO IRQ are not detected
> while in suspend. This affects am33xx processors.
>
> For the DT-Binding portion:
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
> ---
>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   18 ++++
>   drivers/mmc/host/omap_hsmmc.c                      |   86 ++++++++++++++++++--
>   2 files changed, 95 insertions(+), 9 deletions(-)
>

> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct omap_hsmmc_host *host = mmc_priv(mmc);
> +	u32 irq_mask;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +
Hi Andreas,

Thanks for the patch,
You don't check for runtime pm status here before read/write to HSMMC registers,
can you please explain ?

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
>   static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>   {
>   	u32 hctl, capa, value;
> @@ -1635,7 +1687,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>   	.get_cd = omap_hsmmc_get_cd,
>   	.get_ro = omap_hsmmc_get_ro,
>   	.init_card = omap_hsmmc_init_card,
> -	/* NYET -- enable_sdio_irq */
> +	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>   };
>
>   #ifdef CONFIG_DEBUG_FS
> @@ -2021,6 +2073,22 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   		dev_warn(&pdev->dev,
>   			"pins are not configured from the driver\n");
>
> +	/*
> +	 * For now, only support SDIO interrupt if we are booted with
> +	 * DT. This is because some platforms need special quirks. And
> +	 * we don't want to add new legacy mux platform init code
> +	 * callbacks any longer as we are moving to DT based booting
> +	 * anyways.
> +	 */
> +	if (pdev->dev.of_node) {
> +		mmc->caps |= MMC_CAP_SDIO_IRQ;
> +		if (of_find_property(host->dev->of_node,
> +				     "ti,quirk-swakeup-missing", NULL)) {
> +			/* no wakeup from deeper power states, use polling */
> +			mmc->caps &= ~MMC_CAP_SDIO_IRQ;
> +		}
> +	}
> +
>   	omap_hsmmc_protect_card(host);
>
>   	mmc_add_host(mmc);
>

