From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: call sdhci_init() before request irq
Date: Thu, 17 Sep 2015 10:48:56 +0200
Message-ID: <CAPDyKFqvzcUO8k=7yZYfHd5S77f45cFCuTfLg6Sxs-1ntiC4BQ@mail.gmail.com>
References: <1442313178-31705-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442313178-31705-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ivan Ivanov <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15 September 2015 at 12:32, Haibo Chen <haibo.chen@freescale.com> wrote:
> sdhci_init() will clear all irqs and set the needed irqs. So
> logically sdhci_init() should be called before request irq.
>
> If not, some irqs may be triggled and handled wrongly. Take
> the following into consideration, after request irq, if
> SDIO card interrupt enabled, a sd card in the sd slot will
> trigger a mass of interrupt(SDHCI_INT_CARD_INT), because at
> this time, the vmmc-regulator still not restore, no voltage
> supply for the sd card, so the pin of data0~data3 change and
> keep low, interrupt(SDHCI_INT_CARD_INT) will rise up ceaselessly.
> Due to we already reguest irq, system will be busy in handling
> this endless irq, can't response to other event.
>
> So we should call sdhci_init() before request irq in sd resume.
>
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 64b7fdb..6861573 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2714,17 +2714,6 @@ int sdhci_resume_host(struct sdhci_host *host)
>                         host->ops->enable_dma(host);
>         }
>
> -       if (!device_may_wakeup(mmc_dev(host->mmc))) {
> -               ret = request_threaded_irq(host->irq, sdhci_irq,
> -                                          sdhci_thread_irq, IRQF_SHARED,
> -                                          mmc_hostname(host->mmc), host);
> -               if (ret)
> -                       return ret;
> -       } else {
> -               sdhci_disable_irq_wakeups(host);
> -               disable_irq_wake(host->irq);
> -       }
> -
>         if ((host->mmc->pm_flags & MMC_PM_KEEP_POWER) &&
>             (host->quirks2 & SDHCI_QUIRK2_HOST_OFF_CARD_ON)) {
>                 /* Card keeps power but host controller does not */
> @@ -2737,6 +2726,17 @@ int sdhci_resume_host(struct sdhci_host *host)
>                 mmiowb();
>         }
>
> +       if (!device_may_wakeup(mmc_dev(host->mmc))) {
> +               ret = request_threaded_irq(host->irq, sdhci_irq,
> +                                          sdhci_thread_irq, IRQF_SHARED,
> +                                          mmc_hostname(host->mmc), host);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               sdhci_disable_irq_wakeups(host);
> +               disable_irq_wake(host->irq);
> +       }
> +
>         sdhci_enable_card_detection(host);
>
>         return ret;
> --
> 1.9.1
>
