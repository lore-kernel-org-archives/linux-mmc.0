From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v13 1/7] mmc: omap_hsmmc: install dummy pm runtime hooks
 if !CONFIG_PM_RUNTIME
Date: Fri, 23 May 2014 14:10:59 +0200
Message-ID: <CALtMJEABZgB_vkX6wMrR11VSKgb8F3D-qTahk-5X_x73KW+bJA@mail.gmail.com>
References: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
	<1400833834-15893-2-git-send-email-afenkart@gmail.com>
	<537F1FFC.8070609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <537F1FFC.8070609@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2014-05-23 12:16 GMT+02:00 Balaji T K <balajitk@ti.com>:
> On Friday 23 May 2014 02:00 PM, Andreas Fenkart wrote:
>>
>>
>> +#ifdef CONFIG_PM_RUNTIME
>
>
> AFAIK, omap_hsmmc can build without these changes,
> So, I think this patch is not needed.
>
> Let me I know If it is not the case.

if do not guard suspend/resume then I have to add guards in patch 1/7:

> @@ -2200,11 +2346,18 @@ static int omap_hsmmc_suspend(struct device *dev)
>         pm_runtime_get_sync(host->dev);
>
>         if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER)) {
> -               omap_hsmmc_disable_irq(host);
> +               OMAP_HSMMC_WRITE(host->base, ISE, 0);
> +               OMAP_HSMMC_WRITE(host->base, IE, 0);
> +               OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>                 OMAP_HSMMC_WRITE(host->base, HCTL,
>                                 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
>         }
>
> +       /* do not wake up due to sdio irq */
> +       if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
> +           !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
> +               disable_irq(host->wake_irq);

here

> +
>         if (host->dbclk)
>                 clk_disable_unprepare(host->dbclk);
>
> @@ -2230,6 +2383,10 @@ static int omap_hsmmc_resume(struct device *dev)
>
>         omap_hsmmc_protect_card(host);
>
> +       if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
> +           !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
> +               enable_irq(host->wake_irq);
> +
>         pm_runtime_mark_last_busy(host->dev);
>         pm_runtime_put_autosuspend(host->dev);
>         return 0;
> @@ -2246,22 +2403,51 @@ static int omap_hsmmc_resume(struct device *dev)
>  static int omap_hsmmc_runtime_suspend(struct device *dev)
>  {
>         struct omap_hsmmc_host *host;
> +       unsigned long flags;
>
>         host = platform_get_drvdata(to_platform_device(dev));
>         omap_hsmmc_context_save(host);
>         dev_dbg(dev, "disabled\n");
>
> +       spin_lock_irqsave(&host->irq_lock, flags);
> +       if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
> +           (host->flags & HSMMC_SDIO_IRQ_ENABLED)) {
> +               /* disable sdio irq handling to prevent race */
> +               OMAP_HSMMC_WRITE(host->base, ISE, 0);
> +               OMAP_HSMMC_WRITE(host->base, IE, 0);
> +               OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +
> +               WARN_ON(host->flags & HSMMC_WAKE_IRQ_ENABLED);
> +               enable_irq(host->wake_irq);

and here

> +               host->flags |= HSMMC_WAKE_IRQ_ENABLED;
> +       }
> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>         return 0;
>  }
>
