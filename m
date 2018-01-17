From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 5/9] mmc: sdhci: Rework sdhci_enable_irq_wakeups()
Date: Wed, 17 Jan 2018 12:48:48 +0100
Message-ID: <CAPDyKFrzym=nAJreEZUyosg4G7qvV=MB=_2wua64OD9AA1QM1w@mail.gmail.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com> <1515484346-800-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1515484346-800-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 9 January 2018 at 08:52, Adrian Hunter <adrian.hunter@intel.com> wrote:
> In preparation for adding more conditions for whether IRQ wakeup is
> enabled, rework sdhci_enable_irq_wakeups() so that needed bits are added
> instead of adding them all and then removing the unneeded bits.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a8129d091207..dd922923019a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2823,20 +2823,25 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>   */
>  static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
>  {
> +       u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE |
> +                 SDHCI_WAKE_ON_INT;
> +       u32 irq_val = 0;
> +       u8 wake_val = 0;
>         u8 val;
> -       u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
> -                       | SDHCI_WAKE_ON_INT;
> -       u32 irq_val = SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
> -                     SDHCI_INT_CARD_INT;
>
> -       val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
> -       val |= mask ;
> -       /* Avoid fake wake up */
> -       if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
> -               val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
> -               irq_val &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
> +       if (!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)) {
> +               wake_val |= SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE;
> +               irq_val |= SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE;
>         }
> +
> +       wake_val |= SDHCI_WAKE_ON_INT;
> +       irq_val |= SDHCI_INT_CARD_INT;
> +
> +       val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
> +       val &= ~mask;
> +       val |= wake_val;
>         sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
> +
>         sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
>
>         host->irq_wake_enabled = !enable_irq_wake(host->irq);
> --
> 1.9.1
>
