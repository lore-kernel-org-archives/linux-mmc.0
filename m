From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci: Make sdhci_disable_irq_wakeups() static
Date: Tue, 2 Sep 2014 11:23:08 +0200
Message-ID: <CAPDyKFq+RHqYHgF3C=QN3r+93FBvGtVyz3MXWwm6M4ixzSBk3w@mail.gmail.com>
References: <1409421193-17077-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:65079 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbaIBJXJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 05:23:09 -0400
Received: by mail-la0-f45.google.com with SMTP id pn19so7403724lab.32
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 02:23:08 -0700 (PDT)
In-Reply-To: <1409421193-17077-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 30 August 2014 19:53, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> sdhci_disable_irq_wakeups() is exported, but it is not called outside sdhci.c.
>
> Make it static and do not export it, so that the following sparse warning is
> fixed:
>
> drivers/mmc/host/sdhci.c:2548:6: warning: symbol 'sdhci_disable_irq_wakeups' was not declared. Should it be static?
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4cc2ff9..930c190 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2545,7 +2545,7 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
>
> -void sdhci_disable_irq_wakeups(struct sdhci_host *host)
> +static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
>  {
>         u8 val;
>         u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
> @@ -2555,7 +2555,6 @@ void sdhci_disable_irq_wakeups(struct sdhci_host *host)
>         val &= ~mask;
>         sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
>  }
> -EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
>
>  int sdhci_suspend_host(struct sdhci_host *host)
>  {
> --
> 1.9.1
>
