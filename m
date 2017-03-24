From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6] mmc: sdhci: clarify the get_timeout_clock callback
Date: Fri, 24 Mar 2017 10:20:35 +0100
Message-ID: <CAPDyKFpcKh0Ur9XHCmjfm-EgVEz98Ag-OY0WA3iRwv-agE4WvQ@mail.gmail.com>
References: <1490341812-192513-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:32973 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934826AbdCXJUh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 05:20:37 -0400
Received: by mail-vk0-f53.google.com with SMTP id d188so8897223vka.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 02:20:36 -0700 (PDT)
In-Reply-To: <1490341812-192513-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 24 March 2017 at 08:50, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Currently the get_timeout_clock callback doesn't clearly
> have a statement that it needs the variant drivers to return
> the timeout clock rate in kHz if the SDHCI_TIMEOUT_CLK_UNIT
> isn't present, otherwise the variant drivers should return it
> in MHz. It's also very likely that further variant drivers which
> are going to use this callback will be confused by this situation.
> Given the fact that moderm sdhci variant hosts are very prone to get
> the timeout clock from common clock framework (actually the only three
> users did that), it's more natural to return the value in Hz and we
> make an explicit comment there. Then we put the unit conversion inside
> the sdhci core. Thus will improve the code and prevent further misuses.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next. Changed Adrian's cc to an ack.

Kind regards
Uffe

> ---
>
> Changes in v6:
> - rebase on Ulf's next
> - improve some commit msg and add Anssi's tag
>
> Changes in v5:
> - fix typo
> - remove unlikely
>
> Changes in v4:
> - rebased on -next
> - add Masahiro's ack for sdhci-cadence
>
> Changes in v3:
> - squash all the patches into one to keep bisectability
> - fix wrong return value of sdhci-cadence
> - slight improve the condition check to avoid the complaint of
>   checkpatch
>
> Changes in v2:
> - fix the comment and make it return in Hz
>
>  drivers/mmc/host/sdhci-cadence.c   |  4 ++--
>  drivers/mmc/host/sdhci-of-arasan.c | 17 +----------------
>  drivers/mmc/host/sdhci.c           | 16 +++++++++-------
>  drivers/mmc/host/sdhci.h           |  1 +
>  4 files changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 48f6419..07a27dc 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -105,9 +105,9 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>  {
>         /*
>          * Cadence's spec says the Timeout Clock Frequency is the same as the
> -        * Base Clock Frequency.  Divide it by 1000 to return a value in kHz.
> +        * Base Clock Frequency.
>          */
> -       return host->max_clk / 1000;
> +       return host->max_clk;
>  }
>
>  static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 61accf0..ea6b36c 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -157,21 +157,6 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
>         return ret;
>  }
>
> -static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
> -{
> -       unsigned long freq;
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -
> -       /* SDHCI timeout clock is in kHz */
> -       freq = DIV_ROUND_UP(clk_get_rate(pltfm_host->clk), 1000);
> -
> -       /* or in MHz */
> -       if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
> -               freq = DIV_ROUND_UP(freq, 1000);
> -
> -       return freq;
> -}
> -
>  static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -280,7 +265,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>  static struct sdhci_ops sdhci_arasan_ops = {
>         .set_clock = sdhci_arasan_set_clock,
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> -       .get_timeout_clock = sdhci_arasan_get_timeout_clock,
> +       .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>         .set_bus_width = sdhci_set_bus_width,
>         .reset = sdhci_arasan_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a33102f..0d4485d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3390,20 +3390,22 @@ int sdhci_setup_host(struct sdhci_host *host)
>         if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
>                 host->timeout_clk = (host->caps & SDHCI_TIMEOUT_CLK_MASK) >>
>                                         SDHCI_TIMEOUT_CLK_SHIFT;
> +
> +               if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
> +                       host->timeout_clk *= 1000;
> +
>                 if (host->timeout_clk == 0) {
> -                       if (host->ops->get_timeout_clock) {
> -                               host->timeout_clk =
> -                                       host->ops->get_timeout_clock(host);
> -                       } else {
> +                       if (!host->ops->get_timeout_clock) {
>                                 pr_err("%s: Hardware doesn't specify timeout clock frequency.\n",
>                                         mmc_hostname(mmc));
>                                 ret = -ENODEV;
>                                 goto undma;
>                         }
> -               }
>
> -               if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
> -                       host->timeout_clk *= 1000;
> +                       host->timeout_clk =
> +                               DIV_ROUND_UP(host->ops->get_timeout_clock(host),
> +                                            1000);
> +               }
>
>                 if (override_timeout_clk)
>                         host->timeout_clk = override_timeout_clk;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 35b41da..fdb5d7e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -561,6 +561,7 @@ struct sdhci_ops {
>         int             (*enable_dma)(struct sdhci_host *host);
>         unsigned int    (*get_max_clock)(struct sdhci_host *host);
>         unsigned int    (*get_min_clock)(struct sdhci_host *host);
> +       /* get_timeout_clock should return clk rate in unit of Hz */
>         unsigned int    (*get_timeout_clock)(struct sdhci_host *host);
>         unsigned int    (*get_max_timeout_count)(struct sdhci_host *host);
>         void            (*set_timeout)(struct sdhci_host *host,
> --
> 1.9.1
>
>
