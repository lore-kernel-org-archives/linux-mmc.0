From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v2] mmc: sdhci-of-esdhc: disable SD clock for clock value 0
Date: Fri, 22 Sep 2017 11:12:28 +0200
Message-ID: <CAPDyKFo5YCBau3PCA3PqrMuYS14hFuZfqfAaVK_uS31zTNZaaw@mail.gmail.com>
References: <20170921084331.23169-1-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:46658 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdIVJM3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 05:12:29 -0400
Received: by mail-it0-f52.google.com with SMTP id d192so737792itd.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 02:12:29 -0700 (PDT)
In-Reply-To: <20170921084331.23169-1-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 21 September 2017 at 10:43, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> SD clock should be disabled for clock value 0. It's not
> right to just return. This may cause failure of signal
> voltage switching.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Right, here is the v2, I didn't notice that.

Applied for next, thanks!

Kind regards
Uffe

> ---
> Changes for v2:
>         - Moved esdhc_clock_enable() instead of forware declaring.
>         - Added "Acked-by: Adrian Hunter".
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 58 ++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d96a057a7db8..1f424374bbbb 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -458,6 +458,33 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
>         return clock / 256 / 16;
>  }
>
> +static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
> +{
> +       u32 val;
> +       ktime_t timeout;
> +
> +       val = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> +
> +       if (enable)
> +               val |= ESDHC_CLOCK_SDCLKEN;
> +       else
> +               val &= ~ESDHC_CLOCK_SDCLKEN;
> +
> +       sdhci_writel(host, val, ESDHC_SYSTEM_CONTROL);
> +
> +       /* Wait max 20 ms */
> +       timeout = ktime_add_ms(ktime_get(), 20);
> +       val = ESDHC_CLOCK_STABLE;
> +       while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
> +               if (ktime_after(ktime_get(), timeout)) {
> +                       pr_err("%s: Internal clock never stabilised.\n",
> +                               mmc_hostname(host->mmc));
> +                       break;
> +               }
> +               udelay(10);
> +       }
> +}
> +
>  static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -469,8 +496,10 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>
>         host->mmc->actual_clock = 0;
>
> -       if (clock == 0)
> +       if (clock == 0) {
> +               esdhc_clock_enable(host, false);
>                 return;
> +       }
>
>         /* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
>         if (esdhc->vendor_ver < VENDOR_V_23)
> @@ -558,33 +587,6 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>         sdhci_writel(host, ctrl, ESDHC_PROCTL);
>  }
>
> -static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
> -{
> -       u32 val;
> -       ktime_t timeout;
> -
> -       val = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> -
> -       if (enable)
> -               val |= ESDHC_CLOCK_SDCLKEN;
> -       else
> -               val &= ~ESDHC_CLOCK_SDCLKEN;
> -
> -       sdhci_writel(host, val, ESDHC_SYSTEM_CONTROL);
> -
> -       /* Wait max 20 ms */
> -       timeout = ktime_add_ms(ktime_get(), 20);
> -       val = ESDHC_CLOCK_STABLE;
> -       while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
> -               if (ktime_after(ktime_get(), timeout)) {
> -                       pr_err("%s: Internal clock never stabilised.\n",
> -                               mmc_hostname(host->mmc));
> -                       break;
> -               }
> -               udelay(10);
> -       }
> -}
> -
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
>         sdhci_reset(host, mask);
> --
> 2.14.1
>
