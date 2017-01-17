From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v2, 2/2] mmc: sdhci-of-esdhc: avoid clock glitch when frequency
 is changing
Date: Tue, 17 Jan 2017 16:07:21 +0100
Message-ID: <CAPDyKFoxGPtJnCB45jRQMzVYVmpHmY_B7FtKuRns8BRg8C3TKw@mail.gmail.com>
References: <1482745590-29718-1-git-send-email-yangbo.lu@nxp.com> <1482745590-29718-2-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:37910 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdAQPHW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 10:07:22 -0500
Received: by mail-it0-f47.google.com with SMTP id c7so44043678itd.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2017 07:07:22 -0800 (PST)
In-Reply-To: <1482745590-29718-2-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 26 December 2016 at 10:46, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> The eSDHC_PRSSTAT[SDSTB] bit indicates whether the internal card clock is
> stable. This bit is for the host driver to poll clock status when changing
> the clock frequency. It is recommended to clear eSDHC_SYSCTL[SDCLKEN]
> to remove glitch on the card clock when the frequency is changing. This
> patch is to disable SDCLKEN bit before changing frequency and enable it
> after SDSTB bit is set.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes for v2:
>         - added Adrian into to list
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  5 +++++
>  drivers/mmc/host/sdhci-of-esdhc.c | 21 ++++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 8cd8449..ece8b37 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -31,6 +31,10 @@
>   * eSDHC register definition
>   */
>
> +/* Present State Register */
> +#define ESDHC_PRSSTAT                  0x24
> +#define ESDHC_CLOCK_STABLE             0x00000008
> +
>  /* Protocol Control Register */
>  #define ESDHC_PROCTL                   0x28
>  #define ESDHC_CTRL_4BITBUS             (0x1 << 1)
> @@ -43,6 +47,7 @@
>  #define ESDHC_CLOCK_MASK               0x0000fff0
>  #define ESDHC_PREDIV_SHIFT             8
>  #define ESDHC_DIVIDER_SHIFT            4
> +#define ESDHC_CLOCK_SDCLKEN            0x00000008
>  #define ESDHC_CLOCK_PEREN              0x00000004
>  #define ESDHC_CLOCK_HCKEN              0x00000002
>  #define ESDHC_CLOCK_IPGEN              0x00000001
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 9a6eb44..0849885 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -431,6 +431,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>         struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>         int pre_div = 1;
>         int div = 1;
> +       u32 timeout;
>         u32 temp;
>
>         host->mmc->actual_clock = 0;
> @@ -451,8 +452,8 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>
>         temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> -       temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
> -               | ESDHC_CLOCK_MASK);
> +       temp &= ~(ESDHC_CLOCK_SDCLKEN | ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
> +                 ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
>         sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>
>         while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
> @@ -472,7 +473,21 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>                 | (div << ESDHC_DIVIDER_SHIFT)
>                 | (pre_div << ESDHC_PREDIV_SHIFT));
>         sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> -       mdelay(1);
> +
> +       /* Wait max 20 ms */
> +       timeout = 20;
> +       while (!(sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)) {
> +               if (timeout == 0) {
> +                       pr_err("%s: Internal clock never stabilised.\n",
> +                               mmc_hostname(host->mmc));
> +                       return;
> +               }
> +               timeout--;
> +               mdelay(1);
> +       }
> +
> +       temp |= ESDHC_CLOCK_SDCLKEN;
> +       sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>  }
>
>  static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
> --
> 2.1.0.27.g96db324
>
