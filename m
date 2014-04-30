From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
Subject: Re: [PATCH v10 1/5] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Wed, 30 Apr 2014 14:23:54 +0200
Message-ID: <CALbNGRQL_GoEkyiNnihdP9NQ4Dz5my-FuqH6YYKKv+CBnSq67g@mail.gmail.com>
References: <1398670860-30695-1-git-send-email-afenkart@gmail.com>
	<1398670860-30695-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1398670860-30695-2-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 28, 2014 at 9:40 AM, Andreas Fenkart <afenkart@gmail.com> wrote:
> @@ -2201,11 +2346,16 @@ static int omap_hsmmc_suspend(struct device *dev)
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
> +       if (host->wake_irq && !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
> +               disable_irq(host->wake_irq);
> +
>         if (host->dbclk)
>                 clk_disable_unprepare(host->dbclk);
>
> @@ -2231,6 +2381,9 @@ static int omap_hsmmc_resume(struct device *dev)
>
>         omap_hsmmc_protect_card(host);
>
> +       if (host->wake_irq & !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
> +               enable_irq(host->wake_irq);
> +
>         pm_runtime_mark_last_busy(host->dev);
>         pm_runtime_put_autosuspend(host->dev);
>         return 0;
Maybe I misunderstand something here but shouldn't
disable_irq/enable_irq be swapped here?

regards

Andreas
