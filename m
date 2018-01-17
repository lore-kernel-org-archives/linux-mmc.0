From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 4/9] mmc: sdhci: Handle failure of enable_irq_wake()
Date: Wed, 17 Jan 2018 12:48:41 +0100
Message-ID: <CAPDyKFrui7p4KZ1mBvx+e=kbA--QD66YKORc0s+PDi3+T2ek8w@mail.gmail.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com> <1515484346-800-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1515484346-800-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 9 January 2018 at 08:52, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Now that sdhci_enable_irq_wakeups() is a local function, change it to
> return whether the IRQ wakeup was successfully enabled. This is in
> preparation for adding more conditions for whether IRQ wakeup is enabled.
>
> Note it is assumed, for SDHCI devices, that suspend is more important than
> wakeup, so we continue to suspend regardless.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 24 +++++++++++++++---------
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8b2ccf7795ec..a8129d091207 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2821,7 +2821,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>   * sdhci_disable_irq_wakeups() since it will be set by
>   * sdhci_enable_card_detection() or sdhci_init().
>   */
> -static void sdhci_enable_irq_wakeups(struct sdhci_host *host)
> +static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
>  {
>         u8 val;
>         u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
> @@ -2838,6 +2838,10 @@ static void sdhci_enable_irq_wakeups(struct sdhci_host *host)
>         }
>         sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
>         sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
> +
> +       host->irq_wake_enabled = !enable_irq_wake(host->irq);
> +
> +       return host->irq_wake_enabled;
>  }
>
>  static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
> @@ -2849,6 +2853,10 @@ static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
>         val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
>         val &= ~mask;
>         sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
> +
> +       disable_irq_wake(host->irq);
> +
> +       host->irq_wake_enabled = false;
>  }
>
>  int sdhci_suspend_host(struct sdhci_host *host)
> @@ -2857,15 +2865,14 @@ int sdhci_suspend_host(struct sdhci_host *host)
>
>         mmc_retune_timer_stop(host->mmc);
>
> -       if (!device_may_wakeup(mmc_dev(host->mmc))) {
> +       if (!device_may_wakeup(mmc_dev(host->mmc)) ||
> +           !sdhci_enable_irq_wakeups(host)) {
>                 host->ier = 0;
>                 sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>                 sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>                 free_irq(host->irq, host);
> -       } else {
> -               sdhci_enable_irq_wakeups(host);
> -               enable_irq_wake(host->irq);
>         }
> +
>         return 0;
>  }
>
> @@ -2893,15 +2900,14 @@ int sdhci_resume_host(struct sdhci_host *host)
>                 mmiowb();
>         }
>
> -       if (!device_may_wakeup(mmc_dev(host->mmc))) {
> +       if (host->irq_wake_enabled) {
> +               sdhci_disable_irq_wakeups(host);
> +       } else {
>                 ret = request_threaded_irq(host->irq, sdhci_irq,
>                                            sdhci_thread_irq, IRQF_SHARED,
>                                            mmc_hostname(host->mmc), host);
>                 if (ret)
>                         return ret;
> -       } else {
> -               sdhci_disable_irq_wakeups(host);
> -               disable_irq_wake(host->irq);
>         }
>
>         sdhci_enable_card_detection(host);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7393b3a54772..afab26fd70e6 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -484,6 +484,7 @@ struct sdhci_host {
>         bool bus_on;            /* Bus power prevents runtime suspend */
>         bool preset_enabled;    /* Preset is enabled */
>         bool pending_reset;     /* Cmd/data reset is pending */
> +       bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>
>         struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
>         struct mmc_command *cmd;        /* Current command */
> --
> 1.9.1
>
