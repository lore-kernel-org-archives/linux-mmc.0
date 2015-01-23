From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pxav3: fix race between runtime pm and irq
Date: Fri, 23 Jan 2015 09:23:29 +0100
Message-ID: <CAPDyKFrEEN6a31edMbJAfhShm3X8Q5+FohSzOdiZ7NpXsaqKPQ@mail.gmail.com>
References: <1421844313-2851-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:58613 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbbAWIXa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jan 2015 03:23:30 -0500
Received: by mail-qc0-f169.google.com with SMTP id b13so5276863qcw.0
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2015 00:23:29 -0800 (PST)
In-Reply-To: <1421844313-2851-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Chris Ball <chris@printf.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org

On 21 January 2015 at 13:45, Jisheng Zhang <jszhang@marvell.com> wrote:
> This patch is to fix a race condition that may cause an unhandled irq,
> which results in big sdhci interrupt numbers and endless "mmc1: got irq
> while runtime suspended" msgs before v3.15.
>
> Consider following scenario:
>
>       CPU0                            CPU1
>                               sdhci_pxav3_runtime_suspend()
>                                spin_lock_irqsave(&host->lock, flags);
>  sdhci_irq()
>   spining on the &host->lock
>                                host->runtime_suspended = true;
>                                spin_unlock_irqrestore(&host->lock, flags);
>   get the &host->lock
>   runtime_suspended is true now
>   return IRQ_NONE;
>
> Fix this race by using the core sdhci.c supplied sdhci_runtime_suspend_host()
> in runtime suspend hook which will disable card interrupts. We also use the
> sdhci_runtime_resume_host() in the runtime resume hook accordingly.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Cc: <stable@vger.kernel.org> # v3.9+
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 4de39fb..6975c51 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -460,17 +460,15 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_pxa *pxa = pltfm_host->priv;
> -       unsigned long flags;
> +       int ret;
>
> -       spin_lock_irqsave(&host->lock, flags);
> -       host->runtime_suspended = true;
> -       spin_unlock_irqrestore(&host->lock, flags);
> +       ret = sdhci_runtime_suspend_host(host);

If you get an error at this point, you shouldn't continue but instead
just return an error. Maybe even return -EBUSY.

Now, since sdhci_runtime_suspend_host() always returns 0 (should it be
converted to void? ), perhaps you could ignore the error completely
and return 0, as before?

>
>         clk_disable_unprepare(pxa->clk_io);
>         if (!IS_ERR(pxa->clk_core))
>                 clk_disable_unprepare(pxa->clk_core);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int sdhci_pxav3_runtime_resume(struct device *dev)
> @@ -478,17 +476,12 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_pxa *pxa = pltfm_host->priv;
> -       unsigned long flags;
>
>         clk_prepare_enable(pxa->clk_io);
>         if (!IS_ERR(pxa->clk_core))
>                 clk_prepare_enable(pxa->clk_core);
>
> -       spin_lock_irqsave(&host->lock, flags);
> -       host->runtime_suspended = false;
> -       spin_unlock_irqrestore(&host->lock, flags);
> -
> -       return 0;
> +       return sdhci_runtime_resume_host(host);
>  }
>  #endif
>
> --
> 2.1.4
>

Kind regards
Uffe
