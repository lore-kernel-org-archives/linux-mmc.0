From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/5] mmc: sdhci: Fix error paths in sdhci_add_host()
Date: Wed, 13 Apr 2016 13:41:45 +0200
Message-ID: <CAPDyKFqJf4hNVeYw8wvp3aOp9fLSXMADVrGaBeZFG=QLAR1tZg@mail.gmail.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
	<1460460309-13619-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37872 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760358AbcDMLlq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 07:41:46 -0400
Received: by mail-wm0-f54.google.com with SMTP id n3so72685864wmn.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 04:41:46 -0700 (PDT)
In-Reply-To: <1460460309-13619-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

[...]

>
>         pr_info("%s: SDHCI controller on %s [%s] using %s\n",
>                 mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
> @@ -3331,15 +3337,27 @@ int sdhci_add_host(struct sdhci_host *host)
>
>         return 0;
>
> +unled:
>  #ifdef SDHCI_USE_LEDS_CLASS

Shouldn't this ifdef be removed in the earlier patch?

> -reset:
> +       led_classdev_unregister(&host->led);
> +unirq:
> +#endif
>         sdhci_do_reset(host, SDHCI_RESET_ALL);
>         sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>         sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>         free_irq(host->irq, host);
> -#endif
>  untasklet:
>         tasklet_kill(&host->finish_tasklet);
> +unreg:
> +       if (!IS_ERR(mmc->supply.vqmmc))
> +               regulator_disable(mmc->supply.vqmmc);
> +undma:
> +       if (host->align_buffer)
> +               dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
> +                                 host->adma_table_sz, host->align_buffer,
> +                                 host->align_addr);
> +       host->adma_table = NULL;
> +       host->align_buffer = NULL;
>
>         return ret;
>  }
> --
> 1.9.1
>

Kind regards
Uffe
