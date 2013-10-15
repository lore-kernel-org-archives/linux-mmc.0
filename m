From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v3 3/4] mmc: omap_hsmmc: Remux pins to support SDIO
 interrupt on AM335x
Date: Tue, 15 Oct 2013 22:04:14 +0530
Message-ID: <525D6E86.1040208@ti.com>
References: <1380971830-21492-1-git-send-email-afenkart@gmail.com>
 <1380971830-21492-4-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380971830-21492-4-git-send-email-afenkart@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Thanks Andreas for the patch,

On Saturday 05 October 2013 04:47 PM, Andreas Fenkart wrote:
> The am335x can't detect pending cirq in PM runtime suspend.
> This patch reconfigures dat1 as a GPIO before going to suspend.
> SDIO interrupts are detected with the GPIO, while in runtime
> suspend, standard detection of the module block otherwise.
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>
> @@ -2293,23 +2440,66 @@ static int omap_hsmmc_resume(struct device *dev)
>   static int omap_hsmmc_runtime_suspend(struct device *dev)
>   {
>   	struct omap_hsmmc_host *host;
> +	unsigned long flags;
> +	int ret = 0;
>
>   	host = platform_get_drvdata(to_platform_device(dev));
>   	omap_hsmmc_context_save(host);
>   	dev_dbg(dev, "disabled\n");
>
> -	return 0;
> +	if (host->flags & HSMMC_SWAKEUP_QUIRK) {
> +		spin_lock_irqsave(&host->irq_lock, flags);
> +		OMAP_HSMMC_WRITE(host->base, ISE, 0);
> +		OMAP_HSMMC_WRITE(host->base, IE, 0);
> +		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +		spin_unlock_irqrestore(&host->irq_lock, flags);
> +
> +		ret = pinctrl_select_state(host->pinctrl, host->idle);
> +		if (ret < 0)
> +			dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
> +
> +		enable_irq(mmc_slot(host).sdio_irq);
> +	}
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +	/* infinite loop, if irq not cleared in omap_hsmmc_enable_sdio_irq */
> +	host->flags |= HSMMC_RUNTIME_SUSPENDED;

Can you provide more details about the infinite loop and how it will get recovered.

> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +
> +	return ret;
>   }
>
>   static int omap_hsmmc_runtime_resume(struct device *dev)
>   {
>   	struct omap_hsmmc_host *host;
> +	unsigned long flags;
> +	int ret = 0;
>
>   	host = platform_get_drvdata(to_platform_device(dev));
>   	omap_hsmmc_context_restore(host);
>   	dev_dbg(dev, "enabled\n");
>
> -	return 0;
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +	/* infinite loop, if irq not cleared in omap_hsmmc_enable_sdio_irq */
> +	host->flags &= ~HSMMC_RUNTIME_SUSPENDED;
> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +
> +	if (host->flags & HSMMC_SWAKEUP_QUIRK) {
> +		disable_irq(mmc_slot(host).sdio_irq);
> +
> +		ret = pinctrl_select_state(host->pinctrl, host->active);
> +		if (ret < 0)
> +			dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
> +
> +		spin_lock_irqsave(&host->irq_lock, flags);
> +		if (host->flags & HSMMC_SDIO_IRQ_ENABLED) {
> +			OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +			OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
> +			OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
> +		}
> +		spin_unlock_irqrestore(&host->irq_lock, flags);
> +	}
> +	return ret;
>   }
>
>   static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
> diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
> index 2bf1b30..fd5fff5 100644
> --- a/include/linux/platform_data/mmc-omap.h
> +++ b/include/linux/platform_data/mmc-omap.h
> @@ -115,6 +115,7 @@ struct omap_mmc_platform_data {
>
>   		int switch_pin;			/* gpio (card detect) */
>   		int gpio_wp;			/* gpio (write protect) */
> +		int gpio_cirq;			/* gpio (card irq) */
>
>   		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
>   		int (*set_power)(struct device *dev, int slot,
> @@ -145,6 +146,9 @@ struct omap_mmc_platform_data {
>   		int card_detect_irq;
>   		int (*card_detect)(struct device *dev, int slot);
>
> +		/* SDIO IRQs */
> +		int sdio_irq;
> +
>   		unsigned int ban_openended:1;
>
>   	} slots[OMAP_MMC_MAX_SLOTS];
>
