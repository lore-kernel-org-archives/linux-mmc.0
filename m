From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 28/38] mmc: sdhci: remove platform_suspend/platform_resume callbacks
Date: Thu, 24 Apr 2014 09:33:40 +0200
Message-ID: <CAPDyKFqLEqsFGWXOenT--_D4hmUhVauJoUYHjsKF2KwCvvSt1Q@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
	<E1Wd2X3-0003wA-Dv@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:36895 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaDXHdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 03:33:41 -0400
Received: by mail-qa0-f48.google.com with SMTP id dc16so1869902qab.21
        for <linux-mmc@vger.kernel.org>; Thu, 24 Apr 2014 00:33:40 -0700 (PDT)
In-Reply-To: <E1Wd2X3-0003wA-Dv@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 23 April 2014 21:08, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> The only user (sdhci-of-esdhc) no longer uses these callbacks, so lets
> remove them to discourage any further use.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sdhci.c | 6 ------
>  drivers/mmc/host/sdhci.h | 2 --
>  2 files changed, 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c1bd77e17458..f9bca1e7da25 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2530,9 +2530,6 @@ EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
>
>  int sdhci_suspend_host(struct sdhci_host *host)
>  {
> -       if (host->ops->platform_suspend)
> -               host->ops->platform_suspend(host);
> -
>         sdhci_disable_card_detection(host);
>
>         /* Disable tuning since we are suspending */
> @@ -2589,9 +2586,6 @@ int sdhci_resume_host(struct sdhci_host *host)
>
>         sdhci_enable_card_detection(host);
>
> -       if (host->ops->platform_resume)
> -               host->ops->platform_resume(host);
> -
>         /* Set the re-tuning expiration flag */
>         if (host->flags & SDHCI_USING_RETUNING_TIMER)
>                 host->flags |= SDHCI_NEEDS_RETUNING;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7a35395e5f56..4a5cd5e3fa3e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -289,8 +289,6 @@ struct sdhci_ops {
>         int     (*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
>         void    (*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
>         void    (*hw_reset)(struct sdhci_host *host);
> -       void    (*platform_suspend)(struct sdhci_host *host);
> -       void    (*platform_resume)(struct sdhci_host *host);
>         void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
>         void    (*platform_init)(struct sdhci_host *host);
>         void    (*card_event)(struct sdhci_host *host);
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
