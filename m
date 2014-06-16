From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Remove unused ret variables
Date: Mon, 16 Jun 2014 10:46:08 +0200
Message-ID: <CAPDyKFr8Rx5QAf7yH708_P3=T9c_2PMp1nPAfbPzR5WtQmktog@mail.gmail.com>
References: <1401888269-15564-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:47607 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbaFPIqJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 04:46:09 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so7201249qcv.26
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 01:46:08 -0700 (PDT)
In-Reply-To: <1401888269-15564-1-git-send-email-mpa@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 4 June 2014 15:24, Markus Pargmann <mpa@pengutronix.de> wrote:
> Remove those unused ret variables to make it obvious that these function
> will not return any errors in the current implementation.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 47055f3..77c1c27 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2643,7 +2643,6 @@ static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
>  int sdhci_runtime_suspend_host(struct sdhci_host *host)
>  {
>         unsigned long flags;
> -       int ret = 0;
>
>         /* Disable tuning since we are suspending */
>         if (host->flags & SDHCI_USING_RETUNING_TIMER) {
> @@ -2663,14 +2662,14 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>         host->runtime_suspended = true;
>         spin_unlock_irqrestore(&host->lock, flags);
>
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
>
>  int sdhci_runtime_resume_host(struct sdhci_host *host)
>  {
>         unsigned long flags;
> -       int ret = 0, host_flags = host->flags;
> +       int host_flags = host->flags;
>
>         if (host_flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>                 if (host->ops->enable_dma)
> @@ -2709,7 +2708,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>
>         spin_unlock_irqrestore(&host->lock, flags);
>
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
>
> --
> 2.0.0.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
